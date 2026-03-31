# QA Feedback - Sprint 1: Fundamentos

## Veredicto: APROBADO

Los 14 criterios del contrato de sprint se cumplen. La app compila sin errores ni warnings. El arbol Canvas con curvas Bezier es genuinamente original y le da identidad al producto. El design system esta bien ejecutado. Dicho esto, hay problemas concretos que deben corregirse antes del Sprint 2.

## Puntuaciones

| Criterio | Puntuacion | Minimo | Estado |
|---|---|---|---|
| Calidad de diseno | 7/10 | 7 | OK |
| Originalidad | 7/10 | 6 | OK |
| Craft | 7/10 | 7 | OK |
| Funcionalidad | 8/10 | 8 | OK |
| Profundidad | 6/10 | 6 | OK |

## Justificacion de puntuaciones

### Calidad de diseno: 7/10

La paleta calida (crema, verde musgo, terracota, chocolate) esta aplicada con coherencia en los 28 archivos Swift. No hay blanco puro, negro puro ni azul sistema en ninguna pantalla. SF Rounded se usa en toda la tipografia con 7 niveles jerarquicos. Las VaultCards usan borde sutil (1pt, 12% opacidad) en lugar de sombras difusas genericas. El Theme.swift centraliza colores, tipografia, spacing y radii.

**Donde pierde puntos:** Fuera del arbol, las pantallas son layouts SwiftUI estandar con colores personalizados. El detalle de hito es una lista de tarjetas vertical. La creacion de notas es un TextEditor basico. No hay elementos visuales sorprendentes mas alla del arbol y la semilla del onboarding. Es coherente, pero no memorable en todas sus pantallas.

### Originalidad: 7/10

El arbol dibujado con Canvas usando Bezier cubicas y cuadraticas es genuinamente original. El wobble del tronco con sin(), las hojas decorativas alrededor de nodos filled, y la alternancia izquierda/derecha crean un elemento visual que no se parece a ningun template. La metafora del onboarding ("plantar una semilla" en lugar de "crear un perfil") es creativa y mantiene la narrativa. Las decisiones anti-patron (bordes en vez de sombras, sin gradientes) son deliberadas.

**Donde pierde puntos:** El 70% de las pantallas restantes son patrones convencionales con paleta custom: lista de cards, FAB con menu, sheet con TextEditor, DatePicker wheel. No hay un segundo elemento visual sorprendente. El formulario de notas no tiene personalidad propia.

### Craft: 7/10

La jerarquia tipografica es clara: titleLarge para titulos principales, titleMedium para headers, bodyFont para contenido, caption para metadatos. El spacing sigue la escala de 8pt (4, 8, 16, 24, 32, 48) sin excepciones. Las animaciones usan spring physics apropiados (response 0.4-0.8, damping 0.6-0.85). Los nodos aparecen con efecto cascade (delay de 0.03s por sortOrder). El pulso del hito activo (1.8s, autoreversal) es sutil y con proposito.

**Donde pierde puntos:**
- `MilestoneDetailView.swift:128` — Font hardcodeada `.system(size: 22, weight: .semibold, design: .rounded)` fuera del design system
- `TreeView.swift:98` — `.ultraThinMaterial` no esta definido en Theme, rompe la abstraccion
- Las labels de los nodos ("N", "S1", "M1", "6M", "1", "2"...) son cripticas sin contexto. Un padre no sabe que "S1" significa "Semana 1" o que "6M" significa "6 Meses"

### Funcionalidad: 8/10

Todos los 14 criterios del contrato de sprint se cumplen verificablemente:
- Build exitoso sin errores ni warnings (verificado con xcodebuild)
- Onboarding crea hijo + 22 hitos via MilestoneGenerator
- Arbol con curvas Bezier (`path.addCurve`, `path.addQuadCurve`) — no hay `addLine` en tronco ni ramas
- 4 estados de nodo: filled (terracota), vacio disponible (borde punteado), activo (pulso), futuro (opacity 0.3)
- Foto en 3 toques: tap nodo -> tap "+" -> PhotosPicker
- Texto: TextEditor con validacion de no-vacio
- SwiftData + Documents/Vault18Media/{childUUID}/ con compresion JPEG >2MB
- Hitos futuros: `.disabled(!milestone.isAvailable)` + `.opacity(0.3)`

**Donde pierde puntos:**
- Error handling silencioso: `MilestoneDetailViewModel.swift:37-39` tiene un catch vacio. Si falla la carga de la foto, el usuario no recibe feedback
- Sin confirmacion de creacion: al guardar una capsula no hay animacion, haptic ni toast. El usuario tiene que deducir que funciono
- Auto-scroll con `DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)` es fragil. Si el layout tarda mas de 0.3s, el scroll no llega al destino

### Profundidad: 6/10

Hay detalles que demuestran reflexion: el spacing del arbol es denso en los primeros hitos (90pt) y amplio en los anuales (130pt), reflejando la psicologia real de los padres. El texto dinamico de edad se actualiza en tiempo real al mover el DatePicker. Los empty states tienen personalidad ("Este hito esta esperando sus primeros recuerdos"). Las hojas alrededor de nodos filled escalan con la cantidad de capsulas (capsuleCount + 2, max 6). La compresion de fotos >2MB a quality 0.82 es un detalle tecnico bien pensado.

**Donde pierde puntos:**
- Cero feedback haptico en toda la app. Crear una capsula, completar un hito, tocar un nodo — todo es mudo al tacto
- No hay animacion de transicion cuando un nodo pasa de "vacio" a "filled"
- La experiencia de crear notas es minima: un TextEditor plano sin personalidad (no hay formato, no hay placeholder inspirador, no hay conteo de caracteres)
- No hay loading skeleton para las imagenes — solo un rectangulo gris con icono
- No hay accesibilidad (VoiceOver) en los nodos del arbol, que son el elemento interactivo principal

## Bugs encontrados

### Bug 1: Tildes ausentes en textos visibles al usuario
- **Ubicacion:** `MilestoneGenerator.swift:25`, `Child.swift:31`
- **Descripcion:** Los titulos de hitos usan "Ano" en lugar de "Ano" (sin tilde). Lo mismo en ageDescription: "anos", "dias". Estos textos son visibles al usuario en el arbol y en el header
- **Impacto:** Error ortografico visible en la UI. Para una app en espanol, esto es inaceptable
- **Pasos para reproducir:** Crear un hijo → ver el arbol → las etiquetas de anos muestran "Ano 1", "Ano 2"... sin tilde

### Bug 2: Error handling silencioso en fotos
- **Ubicacion:** `MilestoneDetailViewModel.swift:37-39`
- **Descripcion:** Si la carga de foto falla (permisos denegados, formato no soportado, disco lleno), el catch esta vacio y el usuario no recibe feedback
- **Impacto:** El usuario selecciona una foto, ve el loading, y luego... nada. No sabe si fallo o si tiene que reintentar
- **Pasos para reproducir:** Dificil de reproducir en condiciones normales, pero critico cuando ocurre

### Bug 3: Font fuera del design system
- **Ubicacion:** `MilestoneDetailView.swift:128`
- **Descripcion:** El icono "+" del FAB usa `.font(.system(size: 22, weight: .semibold, design: .rounded))` hardcodeado en vez de un valor de Theme
- **Impacto:** Si se cambia el design system, este valor no se actualiza. Inconsistencia arquitectonica

## Problemas de diseno

### 1. Labels de nodos cripticos
Los nodos muestran "N", "S1", "M1", "6M", "1", "2"... como etiquetas. Un padre que abre la app no sabe intuitivamente que "S1" significa "Semana 1" ni que "6M" es "6 Meses". Las labels de anos (solo el numero) son aceptables porque se infieren por posicion, pero las primeras cuatro son confusas.

**Sugerencia:** Usar labels mas descriptivas para los primeros 4 hitos: "Nac", "1sem", "1mes", "6m". O mejor aun, mostrar un tooltip/subtitle debajo del nodo con el nombre completo.

### 2. Detalle de hito sin identidad visual
La pantalla de detalle de hito es una lista vertical de VaultCards. Es funcional pero generica. No transmite la calidez ni la narrativa del arbol. Es la pantalla donde el padre pasa mas tiempo (leyendo recuerdos) y la experiencia es plana.

**Sugerencia:** Agregar un header visual que conecte con la estetica del arbol: una mini-rama decorativa, el estado del nodo, o un gradiente sutil crema→surface. Algo que haga sentir que estas "dentro" de un nodo del arbol.

### 3. Creacion de notas sin emocion
El TextEditor para crear notas es funcional pero frio. No hay un prompt que inspire escritura. No hay fondo tipo papel. No hay sensacion de estar escribiendo algo intimo para tu hijo.

**Sugerencia:** Un placeholder inspirador que rote ("Cuentale sobre su primer paseo...", "Que le dirias hoy?"), fondo tipo papel sutil, y una animacion suave de confirmacion al guardar.

### 4. Material del sistema en el header del arbol
`TreeView.swift:98` usa `.ultraThinMaterial` que es un material del sistema iOS, no definido en el Theme. Esto introduce un color/efecto fuera del control del design system y puede generar inconsistencias si Apple cambia el rendering del material.

**Sugerencia:** Usar `Theme.background.opacity(0.95)` o definir un material custom en Theme.

## Lo que funciona bien

- **El arbol es el producto.** Las curvas Bezier, el wobble organico, las hojas decorativas y la alternancia izquierda/derecha crean un elemento visual con identidad genuina. No se parece a nada generado por template
- **El onboarding tiene alma.** "Plantar una semilla" es una metafora potente que convierte un formulario en una experiencia narrativa. La animacion spring de la semilla creciendo es un buen momento
- **El design system es solido.** Theme.swift + Typography.swift + 4 componentes reutilizables garantizan coherencia. Zero blanco puro, zero negro puro, zero azul sistema
- **La arquitectura es limpia.** MVVM con @Observable, feature-based folder structure, Canvas para rendering eficiente, SwiftData para persistencia. Sin codigo muerto, sin duplicacion
- **La persistencia esta bien pensada.** Media en file system (no en SwiftData) con compresion automatica. Rutas relativas en la DB. Cascade delete correcto

## Acciones requeridas

### Prioridad alta (corregir antes del Sprint 2)
1. **Corregir tildes** en MilestoneGenerator.swift y Child.swift: "Ano" → "Ano" (usar caracteres Unicode correctos). Verificar todos los strings visibles al usuario
2. **Anadir feedback de error** en la carga de fotos: mostrar una alerta o toast cuando falla
3. **Anadir confirmacion de creacion** al guardar una capsula: animacion sutil, haptic, o transicion visual del nodo

### Prioridad media (resolver en Sprint 2)
4. **Mejorar labels de nodos** para los 4 primeros hitos: mas descriptivos que "N", "S1", "M1", "6M"
5. **Mover font hardcodeada** de MilestoneDetailView:128 a Theme
6. **Reemplazar .ultraThinMaterial** por un valor del design system

### Prioridad baja (backlog)
7. **Anadir haptics** en interacciones clave (tap nodo, crear capsula, completar hito)
8. **Anadir accesibilidad basica** (VoiceOver labels) en nodos del arbol
9. **Reemplazar DispatchQueue.main.asyncAfter** por `.task` o `onFirstAppear` pattern para scroll

## Recomendacion

**Refinar la direccion actual.** La base es solida: el arbol es original, el design system es coherente, la arquitectura es limpia, y todas las funcionalidades del contrato funcionan. Las puntuaciones estan en el umbral minimo en varios criterios — hay que subir el nivel de detalle en la interaccion (haptics, animaciones de estado, feedback) y llevar la personalidad visual del arbol al resto de pantallas. El Sprint 2 (multimedia completo) es una buena oportunidad para mejorar la experiencia de creacion de capsulas, que es donde la profundidad actual es mas debil.
