# Proyecto: Vault 18

## Descripción

Vamos a realizar una aplicación en Swift exclusiva para iPhone móviles. Apple y la idea surge de una conversación con mi pareja en la que como vamos a ser padres recientes próximamente queremos una aplicación en la que poniéndole notas fotos vídeos a nuestra hija y que cuando tenga 18 años se le libere ese contenido, a modo de correo electrónico o o que se genere un informe o o que se le dé una usuario y un contraseña y entonces pueda acceder a cierta página web como es cosas para tan largo plazo. Ahora no pienso en cuál es la mejor metodología pero vamos a explorarla porque puedo haber gente que usa esta aplicación y la quiera para dentro de tres años en 18 años ha cambiado mucho el mundo pero en tres no tanto así que vamos a pensar en la mejor metodología de dar este Contenido a día de hoy como visualizó la aplicación pues la visualizo aunque se vaya a usar los adultos pero es para los niños vamos a meterle un color crema algo así infantil visualizo la aplicación que vaya como por ritos pues por ejemplo el día del nacimiento semana 1 mes 16 meses año uno año dos año tres y que cada uno de estos hitos sean unidos como por unas ramas por unas ramitas con flores o con hojas algo así que tenga como una visualización infantil que que busque ternura, inocencia tenemos que valorar de que cuál es la mejor forma de almacenar ese contenido a lo largo del tiempo vale sabemos que es contenido multimedia que puede llegar. A pesar mucho. Estamos hablando de que el la situación ideal de la aplicación es imágenes víde, notas audios de voz vale audios luego podemos crear tantos hijos como tengamos vale o sea que no es una aplicación para solo un hijo, pues si tenemos tres hijos que nos permita añadirle vale y pues que es una es una aplicación orientada a los padres pero pensada para los niños y vamos a hacer la bonita que se agradable este este viaje y que si cumples su función son 18 años de utilizar la aplicación va a evolucionar con el tiempo los tiempos cambian pero vamos a hacer una funcionalidad agradable que vale y luego funcionaría muy bien utilizar una mascota algún Pou o algo de eso así que sea como agradable esa tanto para él cuando llegue el momento del llegue el momento del on Boarding.

## Preferencias técnicas (opcionales, no vinculantes)


- El stack concreto lo decide el planner en la spec y el generator en la implementación.

## Principios de diseño

Este proyecto sigue una filosofía de diseño exigente. NO se acepta output genérico de IA.

### Lo que queremos

- Interfaces con identidad propia: cada app debe sentirse única, con una personalidad visual definida desde el inicio.
- Diseño con intención: cada color, tipografía, espaciado y elemento visual debe estar elegido con un propósito, no por defecto.
- Experiencia humana: la app debe sentirse como algo diseñado por una persona con criterio, no generada por una máquina.
- Referentes de calidad: apps como Linear, Vercel, Raycast, Stripe Dashboard, o Notion. No se busca copiarlas sino alcanzar ese nivel de cuidado y coherencia.

### Lo que rechazamos

- Gradientes genéricos (especialmente morado/azul sobre tarjetas blancas).
- Componentes de librería sin personalizar (shadcn/ui o Tailwind UI tal cual, sin adaptar).
- Layouts predecibles: hero + tres columnas de features + footer. Eso es un template, no un producto.
- Exceso de bordes redondeados, sombras suaves y paletas pastel sin justificación.
- Cualquier patrón que un diseñador humano identificaría como "esto lo ha hecho una IA".

## Seguridad y repositorio público
Este repositorio es público. Todo el código, configuración y archivos del proyecto son visibles para cualquier persona. Esto es intencionado (build-in-public), pero implica responsabilidades estrictas de seguridad.
### Reglas obligatorias

Nunca hardcodear credenciales, tokens, claves de API, URLs de base de datos ni ningún valor sensible directamente en el código.
Siempre usar variables de entorno para cualquier valor de configuración sensible.
El archivo .env debe estar siempre en .gitignore. Verificarlo antes de cualquier commit.
Mantener un archivo .env.example con las claves necesarias pero sin valores reales, como referencia pública.
Antes de cualquier acción que implique ficheros de configuración o credenciales, verificar que .gitignore está correctamente configurado y que no hay nada sensible en el staging area.

Aislamiento de entornos externos
Los servicios externos (Supabase, APIs de terceros, etc.) utilizados en este proyecto deben ser instancias o proyectos dedicados exclusivamente a este proyecto. No se deben compartir instancias con proyectos productivos de otros clientes o proyectos propios en producción. Si se detecta que una credencial o URL apunta a un entorno compartido con otros proyectos, advertir explícitamente antes de continuar.

## Metodología de trabajo

Este proyecto utiliza una metodología multi-agente inspirada en harness design. Hay tres roles definidos en `.claude/`:

- **Planner** (`.claude/planner.md`): Genera la spec del producto.
- **Generator** (`.claude/generator.md`): Construye el producto feature a feature.
- **Evaluator** (`.claude/evaluator.md`): Evalúa la calidad con criterios exigentes.

La comunicación entre agentes se hace mediante archivos en `docs/`.

## Estructura fija (metodología)

```
.claude/           → Definición de roles de los agentes (no tocar)
docs/              → Specs, reportes de sprint y feedback de QA (no tocar)
```

El resto de la estructura del proyecto (carpetas de código, assets, configuración) la define el planner en la spec y el generator en la implementación según las mejores prácticas del stack elegido.
