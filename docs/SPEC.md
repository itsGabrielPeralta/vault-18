# Vault 18 - Spec de producto

## Vision

Vault 18 es una app para iPhone pensada para padres que quieren preservar recuerdos para sus hijos. Fotos, videos, notas escritas y audios de voz se organizan en una linea temporal de hitos — desde el dia del nacimiento hasta los 18 anos — y se liberan al hijo cuando llega el momento. No es un album de fotos mas: es una experiencia narrativa que crece con el nino.

Lo que hace especial a Vault 18 es que el viaje visual ES el producto. La pantalla principal es un arbol que crece: empieza como semilla el dia del nacimiento y se convierte en un arbol frondoso a los 18 anos. Cada hito es un nodo en las ramas, y los padres van llenando esos nodos con capsulas de contenido a lo largo de los anos. El acto de abrir la app y ver el arbol mas grande que la ultima vez es parte de la experiencia.

La app soporta multiples hijos — cada uno con su propio arbol y su propia linea temporal. Esta disenada para los padres, pero pensada para los ninos: cuando llega la fecha de liberacion, el hijo vive una experiencia de "Gran Apertura" disenada para ser memorable. Vault 18 convierte 18 anos de recuerdos en un regalo.

## Identidad visual

### Mood

Calido, tierno, con sofisticacion. La estetica de un libro ilustrado de calidad: algo que un adulto disfruta usando pero que transmite ternura e inocencia. No es infantil barato ni es una app de productividad disfrazada con colores pastel. Tiene personalidad propia, como si un ilustrador con criterio hubiera disenado cada pantalla.

### Paleta de colores

| Rol | Color | Hex |
|-----|-------|-----|
| Fondo base | Crema calido | #F5F0E8 |
| Ramas, progreso, elementos naturales | Verde musgo | #5B7553 |
| Acentos, botones principales, momentos destacados | Terracota suave | #C17F59 |
| Texto principal, iconos | Marron chocolate | #4A3728 |
| Texto secundario, estados inactivos | Marron claro | #8B7D6B |
| Superficies elevadas (tarjetas, modales) | Crema claro | #FAF7F2 |

No se usa blanco puro (#FFFFFF) ni negro puro (#000000) en ningun lugar de la interfaz. La paleta completa vive dentro del espectro calido.

### Tipografia

Redondeada y amigable pero completamente legible. Se prioriza el uso de SF Rounded (tipografia del sistema) para mantener coherencia con iOS y evitar dependencias externas. Los titulos pueden usar un peso mas bold para dar caracter, pero sin caer en tipografias decorativas que dificulten la lectura.

### Metafora visual central: El Arbol

El arbol es el corazon visual de la app. Crece de forma organica:

- **Nacimiento:** Una semilla plantada en tierra, con un pequeno brote verde
- **Primeras semanas/meses:** Un tallo con las primeras hojas
- **Primer ano:** Un arbolito joven con ramas incipientes
- **Anos 2-5:** El arbol gana cuerpo, aparecen flores
- **Anos 6-12:** Arbol robusto con ramas extendidas
- **Anos 13-17:** Arbol grande con copa frondosa
- **Ano 18 (liberacion):** Arbol en plena floracion, con frutos dorados

Los hitos son nodos en las ramas, conectados por el tronco y las ramas del arbol. No son puntos en una linea — son parte de un organismo vivo.

### Mascota: Buu

Un buho pequeno y expresivo que acompana el viaje. Buu no es un personaje que habla constantemente — aparece en momentos clave:

- Da la bienvenida en el onboarding
- Celebra cuando se completa un hito
- Anima cuando pasa tiempo sin agregar contenido
- Protagoniza la experiencia de "La Gran Apertura" para el hijo

Buu transmite sabiduria (es un buho) y ternura (es pequeno y redondeado). Su estilo visual es coherente con la estetica de libro ilustrado: trazos suaves, colores de la paleta, expresiones simples pero emotivas.

### Referentes visuales

- **Duolingo:** Por la mascota con personalidad que genera vinculo emocional, y la gamificacion que no se siente forzada
- **Day One:** Por la calidad y el cuidado en la experiencia de escritura de un diario personal
- **Growing Up (app):** Por la estetica de crecimiento infantil con diseno de calidad para adultos

### Anti-referentes (lo que esta app NO es)

- Gradientes morado/azul sobre tarjetas blancas con bordes redondeados
- Componentes de libreria sin personalizar
- Layout de "hero + tres columnas de features"
- Sombras difusas genericas sobre fondos blancos
- Cualquier cosa que un disenador humano identificaria como "esto lo ha hecho una IA"

## Funcionalidades

### Feature 1: El Arbol del Tiempo

- **Descripcion:** Vista principal de la app. Muestra el arbol del hijo seleccionado con todos sus hitos como nodos en las ramas. El arbol refleja visualmente la edad actual del nino — cuanto mas grande el nino, mas grande y frondoso el arbol. Los hitos completados (con contenido) se ven llenos y vivos; los hitos vacios se ven como nodos latentes esperando ser llenados.
- **Historias de usuario:**
  - Como padre, quiero ver de un vistazo el progreso del arbol de mi hijo para sentir que estoy construyendo algo con el tiempo
  - Como padre, quiero tocar un hito para ver o agregar contenido en ese momento temporal
  - Como padre, quiero poder navegar facilmente entre hitos pasados y el hito actual
- **Criterios de aceptacion:**
  - El arbol se renderiza de forma diferente segun la edad del nino (minimo 7 estados visuales distintos)
  - Los hitos completados son visualmente distinguibles de los vacios
  - Se puede hacer scroll vertical para navegar por todo el arbol
  - Tocar un nodo abre la vista de detalle del hito

### Feature 2: Capsulas

- **Descripcion:** Una capsula es la unidad basica de contenido. Puede contener una foto, un video, una nota de texto o un audio de voz. Cada capsula esta asociada a un hito temporal y tiene fecha de creacion. Un hito puede contener multiples capsulas. Las capsulas son el "contenido" que el hijo recibira el dia de la liberacion.
- **Historias de usuario:**
  - Como padre, quiero agregar una foto con una nota corta a un hito especifico
  - Como padre, quiero grabar un audio de voz directamente desde la app para dejarle un mensaje a mi hijo
  - Como padre, quiero poder editar o eliminar una capsula que agregue por error
  - Como padre, quiero ver todas las capsulas de un hito organizadas cronologicamente
- **Criterios de aceptacion:**
  - Se pueden crear capsulas con foto, video, texto o audio
  - Cada capsula tiene fecha, tipo de contenido y hito asociado
  - Las capsulas se pueden editar y eliminar
  - La interfaz de creacion es rapida y fluida (maximo 3 toques para agregar una foto)

### Feature 3: Hitos temporales

- **Descripcion:** Los hitos son los momentos clave en la vida del nino que organizan el contenido. Siguen una progresion no uniforme que refleja como los padres viven el crecimiento: muy denso al principio (dia, semana, mes) y mas espaciado despues (anual). Los hitos disponibles son: Nacimiento, Semana 1, Mes 1, 6 meses, Ano 1, Ano 2, Ano 3, ..., Ano 18.
- **Historias de usuario:**
  - Como padre, quiero que los hitos vengan predefinidos para no tener que pensar en la estructura
  - Como padre, quiero poder agregar contenido a hitos pasados que no llene en su momento
  - Como padre, quiero ver claramente en que hito estoy actualmente segun la edad de mi hijo
- **Criterios de aceptacion:**
  - Los hitos se generan automaticamente al crear un hijo (basados en fecha de nacimiento)
  - El hito "activo" (el que corresponde a la edad actual) esta destacado visualmente
  - Se puede agregar contenido retroactivamente a cualquier hito pasado
  - Los hitos futuros son visibles pero no editables hasta que llegue su momento

### Feature 4: Multi-hijo

- **Descripcion:** La app permite crear perfiles para multiples hijos. Cada hijo tiene su propio arbol, sus propios hitos y sus propias capsulas. La navegacion entre hijos es sencilla y clara. Al abrir la app se muestra el ultimo hijo seleccionado o una pantalla de seleccion si hay varios.
- **Historias de usuario:**
  - Como padre de dos hijos, quiero tener arboles separados para cada uno
  - Como padre, quiero cambiar facilmente entre los perfiles de mis hijos
  - Como padre, quiero que cada hijo tenga su nombre, fecha de nacimiento y foto de perfil
- **Criterios de aceptacion:**
  - Se pueden crear multiples perfiles de hijo
  - Cada perfil tiene nombre, fecha de nacimiento, fecha de liberacion (por defecto 18 anos) y foto opcional
  - La navegacion entre hijos es accesible desde la vista principal
  - Cada hijo tiene datos completamente independientes

### Feature 5: Recordatorios inteligentes

- **Descripcion:** La app envia notificaciones push en momentos significativos para animar a los padres a capturar recuerdos. Los recordatorios se adaptan a la edad del nino y a los hitos proximos. Tambien detecta inactividad prolongada y envia un recordatorio gentil.
- **Historias de usuario:**
  - Como padre, quiero recibir una notificacion cuando mi hijo cumple un hito ("Hoy Luna cumple 6 meses")
  - Como padre, quiero que me recuerden agregar contenido si llevo mucho tiempo sin hacerlo
  - Como padre, quiero poder configurar la frecuencia de los recordatorios o desactivarlos
- **Criterios de aceptacion:**
  - Se envian notificaciones automaticas en cada hito temporal
  - Se detecta inactividad (configurable, por defecto 2 semanas) y se envia recordatorio
  - Los recordatorios se pueden configurar (frecuencia) o desactivar completamente
  - El tono de los recordatorios es calido y no invasivo (usa a Buu como remitente)

### Feature 6: Carta al futuro

- **Descripcion:** Un tipo especial de capsula con formato de carta. Los padres escriben directamente a su hijo del futuro. La interfaz de escritura es diferente a una nota normal — simula papel, tiene un saludo ("Querida Luna...") y una despedida. Las cartas se presentan de forma destacada en la vista del hito y tendran un protagonismo especial en La Gran Apertura.
- **Historias de usuario:**
  - Como padre, quiero escribirle una carta a mi hijo que leera dentro de anos
  - Como padre, quiero que la carta se sienta diferente a una nota — mas intima, mas especial
  - Como padre, quiero poder escribir multiples cartas a lo largo del tiempo
- **Criterios de aceptacion:**
  - La interfaz de carta tiene un diseno diferenciado (fondo tipo papel, tipografia manuscrita opcional)
  - Las cartas tienen saludo y despedida predefinidos (editables)
  - Las cartas aparecen destacadas visualmente en la vista del hito
  - Se pueden escribir cartas en cualquier hito

### Feature 7: La Gran Apertura

- **Descripcion:** La experiencia mas importante de la app. Cuando llega la fecha de liberacion, se activa un flujo especial disenado para el hijo. El padre puede iniciar La Gran Apertura manualmente o programarla. El hijo recibe acceso a todo el contenido a traves de una experiencia narrativa guiada por Buu: ve el arbol completo, recorre los hitos uno a uno, lee las cartas, ve las fotos y videos. Es un momento emotivo disenado para ser memorable.
- **Historias de usuario:**
  - Como padre, quiero que cuando llegue el momento, mi hijo viva una experiencia especial al recibir todo el contenido
  - Como padre, quiero poder elegir cuando activar La Gran Apertura (en la fecha exacta o cuando yo decida)
  - Como hijo, quiero recorrer los recuerdos de forma guiada y emotiva, no como un dump de archivos
- **Criterios de aceptacion:**
  - El padre puede activar La Gran Apertura manualmente o programarla para una fecha
  - La experiencia es guiada: el hijo recorre el arbol hito por hito
  - Las cartas se presentan de forma especial (animacion de "abrir sobre")
  - Buu guia el recorrido con mensajes contextuales
  - Al finalizar, el hijo tiene acceso libre a todo el contenido para volver cuando quiera

### Feature 8: Mascota Buu

- **Descripcion:** Buu es un buho pequeno que vive en el arbol y acompana la experiencia. No es un chatbot ni un asistente — es una presencia calida que aparece en momentos especificos para dar vida a la app. Buu tiene expresiones (feliz, dormido, emocionado, nostalgico) que cambian segun el contexto.
- **Historias de usuario:**
  - Como padre, quiero sentir que la app tiene personalidad y no es solo una herramienta fria
  - Como padre, quiero que Buu celebre conmigo cuando completo un hito
  - Como hijo (en La Gran Apertura), quiero que Buu me guie por los recuerdos de forma amigable
- **Criterios de aceptacion:**
  - Buu aparece en el onboarding inicial con animacion de bienvenida
  - Buu reacciona cuando se completa un hito (animacion de celebracion)
  - Buu aparece en los recordatorios con expresion contextual
  - Buu tiene un papel protagonista en La Gran Apertura
  - Las animaciones de Buu son sutiles y no interrumpen el flujo

### Feature 9: Compilaciones automaticas

- **Descripcion:** Al completarse un hito anual, la app genera automaticamente un resumen visual con las mejores capsulas del periodo. Es como un "recap" al estilo Spotify Wrapped pero intimo y personal. La compilacion se puede guardar como contenido especial del hito y sera parte de La Gran Apertura.
- **Historias de usuario:**
  - Como padre, quiero que la app me muestre un resumen bonito de lo que he guardado en el ultimo ano
  - Como padre, quiero poder editar la compilacion antes de guardarla (anadir o quitar capsulas)
  - Como padre, quiero que estas compilaciones sean parte de lo que mi hijo vera en La Gran Apertura
- **Criterios de aceptacion:**
  - Se genera una compilacion automatica al completarse cada hito anual
  - La compilacion selecciona automaticamente las capsulas mas representativas
  - El padre puede editar la compilacion (anadir, quitar, reordenar)
  - Las compilaciones se almacenan como contenido especial del hito
  - La presentacion visual es cuidada y emotiva

### Feature 10: Exportacion y persistencia segura

- **Descripcion:** Dado que la app esta pensada para 18 anos de uso, la persistencia del contenido es critica. La app ofrece opciones de backup y exportacion para que los padres puedan garantizar que el contenido sobrevive al paso del tiempo independientemente de lo que pase con la app, el telefono o la App Store.
- **Historias de usuario:**
  - Como padre, quiero poder exportar todo el contenido de un hijo en un formato estandar (fotos, videos, textos)
  - Como padre, quiero tener la tranquilidad de que mis datos estan respaldados
  - Como padre, quiero poder migrar el contenido si cambio de telefono
- **Criterios de aceptacion:**
  - Exportacion completa del contenido de un hijo en formato estandar (carpeta con archivos + JSON con metadatos)
  - Backup automatico o manual del contenido
  - La estrategia de almacenamiento garantiza que el contenido es recuperable ante perdida del dispositivo
  - El proceso de exportacion es claro y el padre entiende que ha exportado y donde esta

## Sprints sugeridos

### Sprint 1: Fundamentos

Objetivo: Tener la base funcional de la app con la experiencia principal.

- Onboarding basico (crear primer hijo con nombre y fecha de nacimiento)
- Vista del Arbol del Tiempo con hitos generados automaticamente
- Creacion de capsulas con foto y texto
- Vista de detalle de hito con sus capsulas
- Navegacion basica entre hitos
- Almacenamiento local de datos

### Sprint 2: Multimedia completo

Objetivo: Completar todos los tipos de contenido.

- Capsulas de video (grabar o elegir de galeria)
- Capsulas de audio (grabar desde la app)
- Carta al futuro (interfaz especial de escritura)
- Edicion y eliminacion de capsulas

### Sprint 3: El Arbol vivo

Objetivo: Dar vida visual al arbol.

- Diferentes estados visuales del arbol segun la edad
- Animaciones de crecimiento al agregar contenido
- Hitos completados vs vacios con diferenciacion visual clara
- Transiciones fluidas al navegar entre hitos
- Scroll suave por todo el arbol

### Sprint 4: Mascota Buu

Objetivo: Integrar a Buu en la experiencia.

- Diseno y animaciones base de Buu (minimo 4 expresiones)
- Buu en el onboarding
- Buu celebrando completar hitos
- Buu en estados de inactividad
- Integracion visual de Buu en el arbol (vive en una rama)

### Sprint 5: Inteligencia

Objetivo: Hacer que la app sea proactiva y util.

- Recordatorios push en hitos
- Deteccion de inactividad y recordatorio gentil
- Configuracion de frecuencia de recordatorios
- Compilaciones automaticas anuales
- Edicion de compilaciones

### Sprint 6: La Gran Apertura

Objetivo: Construir la experiencia culminante.

- Flujo de activacion por el padre (manual o programada)
- Experiencia guiada para el hijo
- Recorrido hito por hito con animaciones
- Presentacion especial de cartas (animacion de sobre)
- Buu como guia del recorrido
- Acceso libre al contenido post-apertura

### Sprint 7: Persistencia y seguridad

Objetivo: Garantizar que el contenido sobrevive 18 anos.

- Multi-hijo (crear, navegar, gestionar perfiles)
- Exportacion de contenido en formato estandar
- Backup del contenido
- Migracion entre dispositivos
- Proteccion de acceso a la app (Face ID / codigo)

## Fuera de alcance (v1)

- **Version iPad / macOS:** Solo iPhone en esta version
- **Compartir entre familiares:** Un solo dispositivo padre por hijo. No hay cuentas compartidas ni roles (mama/papa)
- **Red social o comunidad:** No hay componente social. Es una experiencia intima y privada
- **Integracion automatica con iCloud Photos:** Las fotos se importan manualmente desde la galeria
- **Monetizacion / suscripciones:** No se define modelo de negocio en esta version
- **Soporte offline avanzado:** Se asume conectividad para backups, pero la creacion de contenido funciona offline
- **Localizacion / multi-idioma:** La app estara en espanol inicialmente
- **Modo oscuro:** La identidad visual esta definida en modo claro. El modo oscuro se planteara en una version futura
