# Flujo de Trabajo


```mermaid
%%{init: { 
  'theme': 'base', 
  'themeVariables': {
    'git0': '#000000',
    'git1': '#666666',
    'git2': '#aaaaaa',
    'git3': '#333333',
    'git4': '#888888',
    'git5': '#444444',
    'gitBranchLabel0': '#ffffff',
    'gitBranchLabel1': '#ffffff',
    'gitBranchLabel2': '#ffffff',
    'gitBranchLabel3': '#ffffff',
    'gitBranchLabel4': '#ffffff',
    'gitBranchLabel5': '#ffffff',
    'commitLabelColor': '#000000',
    'commitLabelBackground': '#ffffff',
    'mainBkg': '#000000',
    'lineColor': '#ffffff'
  }
} }%%
gitGraph
   commit id: "Inicio"
   branch qa
   checkout qa
   commit id: "Init QA"
   
   %% 1. Feature Testing: QA -> Main
   %% Sale de QA
   branch feature/testing
   checkout feature/testing
   commit id: "Add Tests"
   checkout qa
   merge feature/testing id: "Merge Testing"
   
   %% 2. Unit Testing: QA -> Main
   %% Sale de QA, pero se mergea directo a Main
   checkout qa
   branch feature/unit_testing
   checkout feature/unit_testing
   commit id: "Add Unit Tests"
   checkout qa
   merge feature/unit_testing id: "Merge Unit Tests"
   
   %% 3. Feature Snapshots: QA -> QA
   checkout qa
   branch feature/snapshots
   checkout feature/snapshots
   commit id: "Add Snapshots"
   checkout qa
   merge feature/snapshots id: "Integrate Snapshots"
   
   %% 4. Feature Grants: QA -> QA
   branch feature/grants
   checkout feature/grants
   commit id: "Add Grants"
   checkout qa
   merge feature/grants id: "Integrate Grants"
   
   %% 5. Feature Versioning: QA -> QA
   branch feature/versioning
   checkout feature/versioning
   commit id: "Add Versioning"
   checkout qa
   merge feature/versioning id: "Integrate Versioning"
   
   %% 6. Volcado Final: QA -> Main
   checkout main
   merge qa id: "Release Final"
