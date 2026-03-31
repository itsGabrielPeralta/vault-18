# Vault 18

**18 años de recuerdos. Un árbol que crece. Un regalo que espera.**

![iOS 17+](https://img.shields.io/badge/iOS-17%2B-000?style=flat&logo=apple&logoColor=white&color=C17F59)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5B7553?style=flat&logo=swift&logoColor=white)
![SwiftData](https://img.shields.io/badge/SwiftData-4A3728?style=flat&logo=swift&logoColor=white)
![Build in Public](https://img.shields.io/badge/build--in--public-YouTube-8B7D6B?style=flat&logo=youtube&logoColor=white)

---

## Qué es Vault 18

Vault 18 es una app iOS para padres que quieren preservar recuerdos para sus hijos. Fotos, notas, audios y vídeos se organizan en una línea temporal de hitos — desde el día del nacimiento hasta los 18 años — y se liberan al hijo cuando llega el momento.

La pantalla principal es un **árbol que crece**: empieza como semilla el día del nacimiento y se convierte en un árbol frondoso a los 18 años. Cada hito es un nodo en las ramas, y los padres van llenando esos nodos con cápsulas de contenido a lo largo de los años.

No es un álbum de fotos más. Es una experiencia narrativa que crece con el niño.

> Este repositorio es un proyecto **build-in-public**: se construye en directo como ejemplo de metodología multi-agente con IA para vídeos de YouTube. Todo el código, las specs, los reportes de QA y los roles de los agentes están aquí para que puedas consultarlos.

---

## Identidad visual

La estética de un libro ilustrado de calidad: algo que un adulto disfruta usando pero que transmite ternura e inocencia.

| Rol | Color | Hex |
|-----|-------|-----|
| Fondo base | Crema cálido | `#F5F0E8` |
| Ramas, progreso | Verde musgo | `#5B7553` |
| Acentos, botones | Terracota suave | `#C17F59` |
| Texto principal | Marrón chocolate | `#4A3728` |
| Texto secundario | Marrón claro | `#8B7D6B` |
| Superficies elevadas | Crema claro | `#FAF7F2` |

**Reglas estrictas:** cero blanco puro, cero negro puro, cero azul sistema. Tipografía SF Rounded en toda la app. Cards con borde sutil en vez de sombras difusas.

---

## Metodología multi-agente

Este proyecto se construye con tres agentes de IA especializados que se comunican mediante archivos en el repositorio:

```
                    docs/SPEC.md
                        |
                   +---------+
                   | PLANNER |  Define qué construir
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
                  | EVALUATOR |  Evalúa con criterios estrictos
                  +-----------+
                        |
               docs/QA_FEEDBACK.md
                        |
                   (siguiente sprint)
```

### Los roles

| Agente | Archivo | Qué hace |
|--------|---------|----------|
| **Planner** | [`.claude/planner.md`](.claude/planner.md) | Transforma la idea en una spec de producto completa con identidad visual, features y roadmap de sprints |
| **Generator** | [`.claude/generator.md`](.claude/generator.md) | Implementa una feature por sprint, con contrato previo y reporte posterior. Diseño con intención |
| **Evaluator** | [`.claude/evaluator.md`](.claude/evaluator.md) | QA senior extremadamente exigente. Puntúa diseño, originalidad, craft, funcionalidad y profundidad. No aprueba trabajo genérico |

### Los documentos

| Documento | Quién lo escribe | Para qué |
|-----------|-----------------|----------|
| [`docs/SPEC.md`](docs/SPEC.md) | Planner | Spec completa del producto |
| [`docs/SPRINT_CONTRACT.md`](docs/SPRINT_CONTRACT.md) | Generator | Qué se va a construir en este sprint |
| [`docs/SPRINT_REPORT.md`](docs/SPRINT_REPORT.md) | Generator | Qué se construyó, decisiones, autoevaluación |
| [`docs/QA_FEEDBACK.md`](docs/QA_FEEDBACK.md) | Evaluator | Puntuaciones, bugs, acciones requeridas |

---

## Tech stack

| Tecnología | Decisión | Razón |
|------------|----------|-------|
| SwiftUI | Framework de UI | Declarativo, nativo iOS 17+ |
| SwiftData | Persistencia de metadata | Reemplaza Core Data, integra con `@Query` |
| File System | Persistencia de media | Fotos en Documents/, no en base de datos |
| Canvas | Renderizado del árbol | Bézier curves orgánicas en un solo render pass |
| MVVM + @Observable | Arquitectura | Observación granular sin boilerplate |
| NavigationStack | Navegación | Destinos tipados, patrón moderno |
| XcodeGen | Generación de proyecto | Evita conflictos de merge en .xcodeproj |

---

## Estructura del proyecto

```
vault-18/
├── .claude/                           # Roles de los agentes
│   ├── planner.md
│   ├── generator.md
│   └── evaluator.md
├── docs/                              # Comunicación entre agentes
│   ├── SPEC.md                        # Spec del producto
│   ├── SPRINT_CONTRACT.md             # Contrato del sprint actual
│   ├── SPRINT_REPORT.md               # Reporte del sprint actual
│   └── QA_FEEDBACK.md                 # Feedback del evaluador
├── Vault18/
│   ├── Design/
│   │   ├── Theme.swift                # Paleta, tipografía, spacing, radii
│   │   ├── Typography.swift           # ViewModifiers de texto
│   │   └── Components/               # VaultButton, VaultTextField, VaultCard, EmptyStateView
│   ├── Models/
│   │   ├── Child.swift                # Perfil del hijo
│   │   ├── Milestone.swift            # Hito temporal (22 predefinidos)
│   │   └── TimeCapsule.swift          # Cápsula de contenido
│   ├── Features/
│   │   ├── Onboarding/               # 3 pasos: bienvenida, nombre, fecha
│   │   ├── Tree/                      # Árbol Canvas + nodos SwiftUI
│   │   └── MilestoneDetail/           # Detalle de hito + creación de cápsulas
│   ├── Services/
│   │   ├── MilestoneGenerator.swift   # Genera 22 hitos desde fecha de nacimiento
│   │   └── MediaStorageService.swift  # CRUD de archivos de foto
│   └── Navigation/
│       └── AppRouter.swift            # Destinos de navegación tipados
├── project.yml                        # Configuración XcodeGen
└── CLAUDE.md                          # Filosofía del proyecto y reglas
```

---

## Cómo ejecutar

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

| Criterio | Puntuación | Mínimo |
|----------|------------|--------|
| Calidad de diseño | 7/10 | 7 |
| Originalidad | 7/10 | 6 |
| Craft | 7/10 | 7 |
| Funcionalidad | 8/10 | 8 |
| Profundidad | 6/10 | 6 |

### Qué incluye el Sprint 1

- **Onboarding narrativo** — 3 pasos con ilustración Canvas de semilla germinando, animaciones spring, texto dinámico de edad
- **Árbol del Tiempo** — Tronco con Bézier curves orgánicas, ramas curvas, hojas decorativas, 4 estados visuales de nodos (filled, vacío, activo con pulso, futuro)
- **Cápsulas** — Creación de foto (3 toques vía PhotosPicker) y texto, con haptic feedback y toast de confirmación
- **Detalle de hito** — Lista de cápsulas, empty state con personalidad, FAB con menú, sheet de notas con placeholders inspiradores
- **Selección multi-hijo** — Lista "Tus semillas" con navegación entre árboles
- **Persistencia** — SwiftData + file system, sobrevive al reinicio

---

## Roadmap

| Sprint | Nombre | Qué incluye |
|--------|--------|-------------|
| ~~1~~ | ~~Fundamentos~~ | ~~Onboarding, árbol, cápsulas foto/texto, detalle de hito~~ |
| 2 | Multimedia completo | Vídeo, audio, Carta al Futuro |
| 3 | El Árbol vivo | 7 estados visuales según edad, animaciones de crecimiento |
| 4 | Mascota Buu | Búho con 4 expresiones, integrado en árbol y onboarding |
| 5 | Inteligencia | Recordatorios push, compilaciones anuales automáticas |
| 6 | La Gran Apertura | Experiencia de liberación para el hijo a los 18 años |
| 7 | Persistencia segura | Export, backup, migración, Face ID |

---

## Filosofía de diseño

### Lo que aceptamos

- Interfaces con identidad propia
- Cada color, tipografía y espaciado elegido con propósito
- Experiencia que se siente diseñada por una persona con criterio
- Nivel de cuidado comparable a Linear, Vercel, Raycast o Notion

### Lo que rechazamos

- Gradientes genéricos (morado/azul sobre tarjetas blancas)
- Componentes de librería sin personalizar
- Layouts predecibles: hero + tres columnas + footer
- Exceso de bordes redondeados y sombras suaves sin justificación
- Cualquier patrón que un diseñador humano identificaría como "esto lo ha hecho una IA"

---

## Licencia

Este proyecto es de código abierto con fines educativos y de demostración.
