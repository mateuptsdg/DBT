# Estrategia de Ramificación (Branching Strategy)



Este documento define el flujo de trabajo Git para el proyecto. El objetivo es mantener un entorno de producción estable (`main`) mientras se integran y prueban nuevas funcionalidades en un entorno seguro (`qa`).



## Diagrama de Flujo



El siguiente gráfico ilustra cómo las "ramas especiales" (features) nacen, se desarrollan y se integran primero en **QA** para su validación antes de llegar a **Main**.



```mermaid

gitGraph

    commit id: "Init"

    branch qa

    checkout qa

    commit id: "v1.0-rc"

    

    %% Ramas de Features (Las "Ramas Especiales")

    branch feature/snapshots

    checkout feature/snapshots

    commit id: "Add Snapshots"

    

    checkout qa

    merge feature/snapshots id: "Merge Snapshots"

    

    branch feature/docs

    checkout feature/docs

    commit id: "Update Docs"

    

    checkout qa

    merge feature/docs id: "Merge Docs"

    

    branch feature/custom-tests

    checkout feature/custom-tests
