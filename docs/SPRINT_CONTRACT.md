# Sprint Contract - Sprint 1: Fundamentos

## Qué se va a construir

### 1. Proyecto base
- Proyecto Xcode con SwiftUI + SwiftData, target iOS 17.0, iPhone only
- Design system completo: paleta de colores (crema, verde musgo, terracota, chocolate), tipografía SF Rounded, spacing, componentes reutilizables (botones, text fields, cards)

### 2. Onboarding (3 pasos)
- Paso 1: Pantalla de bienvenida con ilustración de semilla y botón "Plantar mi primera semilla"
- Paso 2: Input del nombre del hijo con campo estilizado
- Paso 3: Selector de fecha de nacimiento con texto dinámico ("Hoy [nombre] tiene X meses y Y días") y botón "Plantar el árbol de [nombre]"
- Al completar: se crea el hijo con sus 22 hitos auto-generados

### 3. Vista del Árbol del Tiempo
- Visualización principal con Canvas (ramas Bezier orgánicas) + nodos SwiftUI superpuestos
- Tronco con wobble orgánico, grosor variable (más grueso en la base)
- Ramas que conectan el tronco con cada nodo de hito
- 4 estados visuales de nodos: filled (terracota), vacío disponible (borde punteado verde), activo (pulso), futuro (opacidad baja)
- Hojas decorativas alrededor de nodos filled
- ScrollView vertical con auto-scroll al hito activo
- Hitos alternan izquierda/derecha

### 4. Creación de cápsulas
- Flujo de 3 toques: tap nodo → tap "+" → seleccionar foto → cápsula creada
- PhotosPicker nativo de iOS
- Opción de añadir texto a la cápsula
- Ruta alternativa: cápsula de solo texto ("Escribir nota")
- Almacenamiento de fotos en file system, ruta relativa en SwiftData

### 5. Vista de detalle de hito
- Muestra todas las cápsulas del hito ordenadas cronológicamente
- Estado vacío con personalidad ("Este hito está esperando sus primeros recuerdos")
- Tarjetas de cápsula con foto y/o texto
- FAB "+" para agregar contenido

### 6. Navegación
- NavigationStack tipado
- Routing: onboarding ↔ árbol → detalle hito → creación cápsula → back

## Criterios de "terminado"

- [ ] La app compila y ejecuta sin errores en simulador iPhone
- [ ] El onboarding crea un hijo y genera 22 hitos automáticamente
- [ ] El árbol muestra todos los hitos con ramas orgánicas Bezier (no líneas rectas)
- [ ] Los hitos filled, vacíos, activos y futuros son visualmente distinguibles
- [ ] Se puede crear una cápsula con foto en 3 toques desde el árbol
- [ ] Se puede crear una cápsula de solo texto
- [ ] Las cápsulas se persisten (SwiftData + file system) y sobreviven al reinicio de la app
- [ ] El hito activo se destaca con animación de pulso
- [ ] Los hitos futuros son visibles pero NO editables
- [ ] Los hitos pasados permiten agregar contenido retroactivamente
- [ ] NO hay blanco puro (#FFFFFF) ni negro puro (#000000) en ninguna pantalla
- [ ] Toda la tipografía usa SF Rounded
- [ ] El color de acento es terracota (#C17F59), no azul sistema
- [ ] El fondo de todas las pantallas es crema cálido (#F5F0E8)

## Qué debe testear el evaluador

1. **Flujo completo**: Launch → Onboarding (3 pasos) → Árbol → Tap hito → Detalle → Añadir foto → Ver cápsula → Volver al árbol → Nodo aparece como "filled"
2. **Coherencia visual**: Verificar paleta de colores, tipografía y ausencia de colores por defecto del sistema
3. **Árbol orgánico**: Las ramas deben verse como curvas naturales, no líneas rectas ni ángulos duros
4. **Estados de hitos**: Crear hijo nacido hoy (solo "Nacimiento" disponible) y hijo nacido hace 2 años (hitos hasta "Año 2" disponibles)
5. **Persistencia**: Crear cápsulas, cerrar la app, reabrir — todo debe estar ahí
6. **Empty states**: Verificar que los hitos sin cápsulas tienen estado vacío con personalidad
7. **Edge cases**: Muchas cápsulas en un hito, foto que no carga, scroll del árbol completo
