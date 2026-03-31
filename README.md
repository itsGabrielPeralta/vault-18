# Vault 18

**18 anos de recuerdos. Un arbol que crece. Un regalo que espera.**

![iOS 17+](https://img.shields.io/badge/iOS-17%2B-000?style=flat&logo=apple&logoColor=white&color=C17F59)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5B7553?style=flat&logo=swift&logoColor=white)
![SwiftData](https://img.shields.io/badge/SwiftData-4A3728?style=flat&logo=swift&logoColor=white)
![Build in Public](https://img.shields.io/badge/build--in--public-YouTube-8B7D6B?style=flat&logo=youtube&logoColor=white)

---

## Que es Vault 18

Vault 18 es una app iOS para padres que quieren preservar recuerdos para sus hijos. Fotos, notas, audios y videos se organizan en una linea temporal de hitos — desde el dia del nacimiento hasta los 18 anos — y se liberan al hijo cuando llega el momento.

La pantalla principal es un **arbol que crece**: empieza como semilla el dia del nacimiento y se convierte en un arbol frondoso a los 18 anos. Cada hito es un nodo en las ramas, y los padres van llenando esos nodos con capsulas de contenido a lo largo de los anos.

No es un album de fotos mas. Es una experiencia narrativa que crece con el nino.

> Este repositorio es un proyecto **build-in-public**: se construye en directo como ejemplo de metodologia multi-agente con IA para videos de YouTube. Todo el codigo, las specs, los reportes de QA y los roles de los agentes estan aqui para que puedas consultarlos.

---

## Identidad visual

La estetica de un libro ilustrado de calidad: algo que un adulto disfruta usando pero que transmite ternura e inocencia.

| Rol | Color | Hex |
|-----|-------|-----|
| Fondo base | Crema calido | `#F5F0E8` |
| Ramas, progreso | Verde musgo | `#5B7553` |
| Acentos, botones | Terracota suave | `#C17F59` |
| Texto principal | Marron chocolate | `#4A3728` |
| Texto secundario | Marron claro | `#8B7D6B` |
| Superficies elevadas | Crema claro | `#FAF7F2` |

**Reglas estrictas:** cero blanco puro, cero negro puro, cero azul sistema. Tipografia SF Rounded en toda la app. Cards con borde sutil en vez de sombras difusas.

---

## Metodologia multi-agente

Este proyecto se construye con tres agentes de IA especializados que se comunican mediante archivos en el repositorio:

```
                    docs/SPEC.md
                        |
                   +---------+
                   | PLANNER |  Define que construir
                   +---------+
                        |
              docs/SPRINT_CONTRACT.md
                        |
                  +-----------+
                  | GENERATOR |  Construye sprint a sprint
                  +-----------+
                        |
              docs/SPRINT_REPORT.md
                        |
                  +-----------+
                  | EVALUATOR |  Evalua con criterios estrictos
                  +-----------+
                        |
               docs/QA_FEEDBACK.md
                        |
                   (siguiente sprint)
```

### Los roles

| Agente | Archivo | Que hace |
|--------|---------|----------|
| **Planner** | [`.claude/planner.md`](.claude/planner.md) | Transforma la idea en una spec de producto completa con identidad visual, features y roadmap de sprints |
| **Generator** | [`.claude/generator.md`](.claude/generator.md) | Implementa una feature por sprint, con contrato previo y reporte posterior. Diseno con intencion |
| **Evaluator** | [`.claude/evaluator.md`](.claude/evaluator.md) | QA senior extremadamente exigente. Puntua diseno, originalidad, craft, funcionalidad y profundidad. No aprueba trabajo generico |

### Los documentos

| Documento | Quien lo escribe | Para que |
|-----------|-----------------|----------|
| [`docs/SPEC.md`](docs/SPEC.md) | Planner | Spec completa del producto |
| [`docs/SPRINT_CONTRACT.md`](docs/SPRINT_CONTRACT.md) | Generator | Que se va a construir en este sprint |
| [`docs/SPRINT_REPORT.md`](docs/SPRINT_REPORT.md) | Generator | Que se construyo, decisiones, autoevaluacion |
| [`docs/QA_FEEDBACK.md`](docs/QA_FEEDBACK.md) | Evaluator | Puntuaciones, bugs, acciones requeridas |

---

## Tech stack

| Tecnologia | Decision | Razon |
|------------|----------|-------|
| SwiftUI | Framework de UI | Declarativo, nativo iOS 17+ |
| SwiftData | Persistencia de metadata | Reemplaza Core Data, integra con `@Query` |
| File System | Persistencia de media | Fotos en Documents/, no en base de datos |
| Canvas | Renderizado del arbol | Bezier curves organicas en un solo render pass |
| MVVM + @Observable | Arquitectura | Observacion granular sin boilerplate |
| NavigationStack | Navegacion | Destinos tipados, patron moderno |
| XcodeGen | Generacion de proyecto | Evita conflictos de merge en .xcodeproj |

---

## Estructura del proyecto

```
vault-18/
├── .claude/                           # Roles de los agentes
│   ├── planner.md
│   ├── generator.md
│   └── evaluator.md
├── docs/                              # Comunicacion entre agentes
│   ├── SPEC.md                        # Spec del producto
│   ├── SPRINT_CONTRACT.md             # Contrato del sprint actual
│   ├── SPRINT_REPORT.md               # Reporte del sprint actual
│   └── QA_FEEDBACK.md                 # Feedback del evaluador
├── Vault18/
│   ├── Design/
│   │   ├── Theme.swift                # Paleta, tipografia, spacing, radii
│   │   ├── Typography.swift           # ViewModifiers de texto
│   │   └── Components/               # VaultButton, VaultTextField, VaultCard, EmptyStateView
│   ├── Models/
│   │   ├── Child.swift                # Perfil del hijo
│   │   ├── Milestone.swift            # Hito temporal (22 predefinidos)
│   │   └── TimeCapsule.swift          # Capsula de contenido
│   ├── Features/
│   │   ├── Onboarding/               # 3 pasos: bienvenida, nombre, fecha
│   │   ├── Tree/                      # Arbol Canvas + nodos SwiftUI
│   │   └── MilestoneDetail/           # Detalle de hito + creacion de capsulas
│   ├── Services/
│   │   ├── MilestoneGenerator.swift   # Genera 22 hitos desde fecha de nacimiento
│   │   └── MediaStorageService.swift  # CRUD de archivos de foto
│   └── Navigation/
│       └── AppRouter.swift            # Destinos de navegacion tipados
├── project.yml                        # Configuracion XcodeGen
└── CLAUDE.md                          # Filosofia del proyecto y reglas
```

---

## Como ejecutar

### Requisitos

- macOS con Xcode 16+
- iOS Simulator (iPhone)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)

### Pasos

```bash
# Clonar el repositorio
git clone https://github.com/itsGabrielPeralta/vault-18.git
cd vault-18

# Generar el proyecto Xcode
xcodegen generate

# Abrir en Xcode
open Vault18.xcodeproj

# Seleccionar un simulador iPhone → Build & Run (Cmd+R)
```

No hay dependencias externas. Todo es SwiftUI y SwiftData nativos.

---

## Estado actual: Sprint 1 completado

**Veredicto del evaluador: APROBADO**

| Criterio | Puntuacion | Minimo |
|----------|------------|--------|
| Calidad de diseno | 7/10 | 7 |
| Originalidad | 7/10 | 6 |
| Craft | 7/10 | 7 |
| Funcionalidad | 8/10 | 8 |
| Profundidad | 6/10 | 6 |

### Que incluye el Sprint 1

- **Onboarding narrativo** — 3 pasos con ilustracion Canvas de semilla germinando, animaciones spring, texto dinamico de edad
- **Arbol del Tiempo** — Tronco con Bezier curves organicas, ramas curvas, hojas decorativas, 4 estados visuales de nodos (filled, vacio, activo con pulso, futuro)
- **Capsulas** — Creacion de foto (3 toques via PhotosPicker) y texto, con haptic feedback y toast de confirmacion
- **Detalle de hito** — Lista de capsulas, empty state con personalidad, FAB con menu, sheet de notas con placeholders inspiradores
- **Seleccion multi-hijo** — Lista "Tus semillas" con navegacion entre arboles
- **Persistencia** — SwiftData + file system, sobrevive al reinicio

---

## Roadmap

| Sprint | Nombre | Que incluye |
|--------|--------|-------------|
| ~~1~~ | ~~Fundamentos~~ | ~~Onboarding, arbol, capsulas foto/texto, detalle de hito~~ |
| 2 | Multimedia completo | Video, audio, Carta al Futuro |
| 3 | El Arbol vivo | 7 estados visuales segun edad, animaciones de crecimiento |
| 4 | Mascota Buu | Buho con 4 expresiones, integrado en arbol y onboarding |
| 5 | Inteligencia | Recordatorios push, compilaciones anuales automaticas |
| 6 | La Gran Apertura | Experiencia de liberacion para el hijo a los 18 anos |
| 7 | Persistencia segura | Export, backup, migracion, Face ID |

---

## Filosofia de diseno

### Lo que aceptamos

- Interfaces con identidad propia
- Cada color, tipografia y espaciado elegido con proposito
- Experiencia que se siente disenada por una persona con criterio
- Nivel de cuidado comparable a Linear, Vercel, Raycast o Notion

### Lo que rechazamos

- Gradientes genericos (morado/azul sobre tarjetas blancas)
- Componentes de libreria sin personalizar
- Layouts predecibles: hero + tres columnas + footer
- Exceso de bordes redondeados y sombras suaves sin justificacion
- Cualquier patron que un disenador humano identificaria como "esto lo ha hecho una IA"

---

## Licencia

Este proyecto es de codigo abierto con fines educativos y de demostracion.
