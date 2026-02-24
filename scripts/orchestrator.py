import os
import sys
import time
import requests
import argparse

def trigger_job(account_id, job_id, token, message):
    base_url = f"https://cloud.getdbt.com/api/v2/accounts/{account_id}/jobs/{job_id}/run/"
    headers = {
        "Authorization": f"Token {token}",
        "Content-Type": "application/json"
    }
    
    payload = {
        "cause": message,
        # Opcional: Si quieres forzar comandos específicos, descomenta abajo:
        # "steps_override": ["dbt build"] 
    }

    print(f"🚀 Disparando Job {job_id} en Cuenta {account_id}...")
    
    try:
        req = requests.post(base_url, headers=headers, json=payload)
        req.raise_for_status()
        run_id = req.json()['data']['id']
        print(f"✅ Job iniciado. Run ID: {run_id}. Esperando finalización...")
        return run_id, headers
    except Exception as e:
        print(f"❌ Error al iniciar el job: {e}")
        sys.exit(1)

def wait_for_completion(account_id, run_id, headers):
    while True:
        time.sleep(15)
        status_url = f"https://cloud.getdbt.com/api/v2/accounts/{account_id}/runs/{run_id}/"
        try:
            res = requests.get(status_url, headers=headers).json()['data']
            status = res['status']
            
            # 10=Success, 20=Error, 30=Cancelled
            if status == 10:
                print(f"🎉 Ejecución Exitosa! Ver logs: {res['href']}")
                sys.exit(0)
            elif status == 20:
                print(f"🔥 La ejecución FALLÓ. Ver logs: {res['href']}")
                sys.exit(1)
            elif status == 30:
                print("⚠️ Ejecución Cancelada.")
                sys.exit(1)
        except Exception as e:
            print(f"Error consultando estado: {e}")
            # No salimos, reintentamos en el siguiente loop

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--job_id", required=True)
    parser.add_argument("--message", default="Triggered from GitHub Actions")
    args = parser.parse_args()

    # Leemos credenciales de variables de entorno (Inyectadas por GitHub)
    token = os.environ.get('DBT_API_TOKEN')
    account_id = os.environ.get('DBT_ACCOUNT_ID')

    if not token or not account_id:
        print("Error: Faltan variables de entorno DBT_API_TOKEN o DBT_ACCOUNT_ID")
        sys.exit(1)

    run_id, headers = trigger_job(account_id, args.job_id, token, args.message)
    wait_for_completion(account_id, run_id, headers)
