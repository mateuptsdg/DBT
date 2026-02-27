# Estrategia de Ramificación (Branching Strategy)

Este documento define el flujo de trabajo Git para el proyecto. El objetivo es mantener un entorno de producción estable (`main`) mientras se integran y prueban nuevas funcionalidades en un entorno seguro (`qa`).

## Diagrama de Flujo (Ciclo Continuo)

El siguiente gráfico ilustra el ciclo de vida completo: desarrollo de features, integración en QA y despliegues periódicos a Producción (Main).

```mermaid
%%{init: { 'theme': 'neutral' } }%%
gitGraph
    commit id: "Init"
    branch qa
    checkout qa
    commit id: "v1.0-rc"
    
    %% --- CICLO 1: Versión 1.1.0 ---
    branch feature/snapshots
    checkout feature/snapshots
    commit id: "Add Snapshots"
    checkout qa
    merge feature/snapshots id: "Merge Snapshots"
    
    %% Despliegue v1.1.0
    checkout main
    merge qa tag: "v1.1.0"
    
    %% --- CICLO 2: Versión 1.2.0 (El ciclo se repite) ---
    checkout qa
    branch feature/nuevos-marts
    checkout feature/nuevos-marts
    commit id: "Add Marts"
    commit id: "Fix Tests"
    
    checkout qa
    merge feature/nuevos-marts id: "Merge Marts"
    
    %% Vuelta a mergear QA -> Main
    checkout main
    merge qa tag: "v1.2.0"
