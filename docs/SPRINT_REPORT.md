# Sprint Report - Sprint 1: Fundamentos

## Qué se ha construido

### Proyecto base
- Proyecto Xcode generado con XcodeGen, target iOS 17.0, iPhone only
- Design system completo en `Theme.swift`: paleta de 6 colores (crema cálido, verde musgo, terracota, chocolate, marrón claro, crema claro), tipografía SF Rounded con 7 niveles jerárquicos, sistema de spacing (XS a XXL), radios de esquina consistentes
- Componentes reutilizables: `VaultButton` (3 estilos), `VaultTextField` (bottom-line animada), `VaultCard` (superficie elevada con borde sutil), `EmptyStateView` (con ilustración de rama)
- ViewModifiers de tipografía para aplicar estilos consistentes

### Modelos SwiftData
- `Child`: nombre, fecha nacimiento, UUID, con computed properties para edad y fecha de liberación
- `Milestone`: 22 hitos predefinidos (Nacimiento, Semana 1, Mes 1, 6 Meses, Año 1-18), con sortOrder, tipo, y relaciones cascade
- `TimeCapsule`: texto opcional, media filename, tipo de media, fecha de creación
- `MilestoneGenerator`: genera automáticamente los 22 hitos desde una fecha de nacimiento

### Onboarding (3 pasos)
1. **Bienvenida**: Ilustración de semilla germinando (dibujada con Canvas — tallo, hojas, brote, tierra) con animación spring de crecimiento. Botón "Plantar mi primera semilla"
2. **Nombre**: Campo de texto con bottom-line verde musgo que se anima al recibir foco. Texto hint "Puedes cambiarlo después"
3. **Fecha de nacimiento**: DatePicker wheel con tinte terracota, indicador dinámico "Hoy [nombre] tiene X meses y Y días" que se actualiza en tiempo real. Botón personalizado "Plantar el árbol de [nombre]"
- Transiciones entre pasos con animación spring asimétrica (slide horizontal)

### Árbol del Tiempo
- **Canvas orgánico**: Tronco con Bezier curves y wobble determinístico (seeded por sortOrder), glow exterior para profundidad. Ramas curvas desde tronco hasta cada nodo
- **4 estados de nodos**: Filled (terracota con label), vacío disponible (borde punteado verde musgo), activo (pulso animado), futuro (opacidad baja, deshabilitado)
- **Hojas decorativas**: Elipses rotadas alrededor de nodos con cápsulas, cantidad proporcional al contenido
- **Suelo**: Curva suave marrón en la base del árbol
- **Layout**: Nacimiento en la parte inferior, futuro arriba. Hitos alternan izquierda/derecha. Spacing denso al inicio (90pt), espaciado para anuales (130pt)
- **Auto-scroll**: Se posiciona automáticamente en el hito activo al abrir

### Detalle de hito y cápsulas
- **MilestoneDetailView**: Header con título, fecha y conteo de recuerdos. Lista de cápsulas como tarjetas. Empty state con ilustración de rama y CTA
- **FAB con menú**: "Agregar foto" (abre PhotosPicker nativo) y "Escribir nota" (abre sheet con TextEditor)
- **CapsuleRowView**: Tarjeta con foto (carga async desde file system) y/o texto, fecha
- **Eliminación**: Context menu con opción de eliminar (borra archivo de media también)
- **Sheet de notas**: TextEditor con fondo crema, botones cancelar/guardar

### Almacenamiento
- **SwiftData**: Metadata y relaciones entre Child, Milestone, TimeCapsule
- **File System**: Fotos guardadas en Documents/Vault18Media/{childUUID}/, compresión JPEG automática para archivos >2MB
- **MediaStorageService**: Save, load y delete de archivos de media

## Decisiones de diseño

### Paleta de colores
Se aplicó la paleta de la SPEC al 100%. No hay blanco puro ni negro puro en ningún lugar. El fondo crema cálido (#F5F0E8) está presente en todas las pantallas. El terracota (#C17F59) sustituye al azul sistema como color de acento en toda la app.

### Tipografía
SF Rounded en todos los textos, con 7 niveles jerárquicos claramente diferenciados. Los títulos usan bold, el cuerpo regular, las etiquetas caption — todo con el mismo design: .rounded.

### El árbol como identidad
El árbol es el elemento visual más distintivo. Se dibuja con Canvas usando paths Bezier orgánicos en lugar de líneas rectas o layouts de lista. El wobble del tronco, las curvas de las ramas y las hojas alrededor de nodos filled le dan un carácter ilustrado que se aleja completamente de un diseño genérico.

### Onboarding narrativo
Se descartó el típico formulario de "crear cuenta". En su lugar, el onboarding es una experiencia narrativa: "plantar una semilla" en lugar de "crear un perfil". Los botones reflejan esta narrativa ("Plantar mi primera semilla" en lugar de "Siguiente").

### Cards sin sombra
Las tarjetas de cápsulas usan un borde sutil de 1pt al 12% de opacidad en lugar de sombras difusas. Esto evita el patrón "tarjeta flotante genérica" que delata generación por IA.

## Decisiones técnicas

- **MVVM + @Observable**: Cada feature tiene su ViewModel `@Observable`, aprovechando la observación granular de iOS 17
- **SwiftData sobre Core Data**: Macro `@Model`, relaciones con `@Relationship`, queries con `@Query`
- **Canvas sobre Shape**: El árbol usa Canvas para dibujar todas las ramas en un solo render pass, más eficiente que 20+ Shape views
- **File System para media**: Las fotos se guardan en Documents/ y SwiftData solo almacena la ruta relativa
- **XcodeGen**: El proyecto se genera desde `project.yml` para evitar conflictos de merge en el .xcodeproj
- **TimeCapsule en lugar de Capsule**: Para evitar conflicto con SwiftUI's built-in `Capsule` shape

## Autoevaluación

### Lo que ha quedado bien
- La estructura del proyecto es limpia y modular
- El design system garantiza coherencia visual
- El árbol tiene personalidad genuina — no se parece a ningún template
- El onboarding tiene narrativa y animaciones con intención
- El flujo de creación de cápsulas es fluido (PhotosPicker directo desde FAB)

### Lo que podría mejorar
- El árbol es estático visualmente — aún no tiene los 7 estados de crecimiento según la edad (eso viene en Sprint 3)
- El tronco usa un solo grosor medio en lugar de un taper real de grueso a fino (limitación de Canvas stroke)
- No hay animación de confirmación tras crear una cápsula
- Las milestone labels podrían ser más descriptivas (ahora son "N", "S1", "M1"...)

### Dudas
- ¿El spacing entre hitos es correcto? Con 22 hitos el scroll es largo (~3000pt)
- ¿El evaluador preferirá milestone labels más descriptivos o los cortos funcionan en el contexto del nodo?

## Listo para QA

### Cómo ejecutar
1. Abrir `Vault18.xcodeproj` en Xcode
2. Seleccionar un simulador iPhone (iPhone 17 Pro recomendado)
3. Build & Run (Cmd+R)

### Qué revisar
1. **Flujo completo**: Launch → Onboarding → Árbol → Tap hito → Detalle → Agregar foto → Ver cápsula → Volver → Nodo filled
2. **Coherencia visual**: Paleta, tipografía, ausencia de blanco/negro puro
3. **Árbol orgánico**: Ramas curvas, no rectas. Hojas en nodos filled
4. **4 estados de nodos**: Filled, vacío, activo (pulso), futuro (opacidad)
5. **Edge cases**: Hijo nacido hoy vs hace 2 años
6. **Persistencia**: Crear cápsulas → cerrar app → reabrir → todo persiste
7. **Hitos futuros**: Visibles pero no tappables
8. **Empty state**: Hito sin cápsulas muestra estado vacío con personalidad
