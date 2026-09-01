# Mi Nevera — inventario con pegatinas NFC

App de 3 páginas para llevar el control de la nevera/despensa y de la lista
de la compra, pensada para tocarla con el móvil vía NFC. 100% gratis:
Supabase (base de datos) + GitHub Pages o Cloudflare Pages (hosting).

## Qué incluye
- `index.html` — inventario de la nevera. Añadir productos, marcar estado
  (en la nevera / queda poco / se acabó) o borrarlos.
- `producto.html` — la página a la que apunta cada pegatina NFC. Marca el
  producto automáticamente y pregunta si lo añades a la lista de la compra.
- `lista.html` — lista de la compra: marcar comprados, añadir cosas nuevas
  a mano, vaciar lo ya comprado.
- `schema.sql` — crea las tablas en Supabase.
- `config.js` — aquí pegas tus claves de Supabase (2 líneas).

## Paso 1 — Crear la base de datos (Supabase, gratis)
1. Ve a [supabase.com](https://supabase.com) → crea una cuenta gratis →
   "New project" (elige una región cercana y una contraseña para la base
   de datos, no la necesitarás para esta app).
2. Cuando el proyecto esté listo, ve al menú **SQL Editor** → **New query**.
3. Abre `schema.sql`, copia todo su contenido, pégalo ahí y pulsa **Run**.
   Esto crea las tablas `productos` y `lista_compra`, con 5 productos de
   ejemplo.
4. Ve a **Project Settings** (icono de engranaje) → **API**.
   - Copia el **Project URL**.
   - Copia la clave **anon public**.

## Paso 2 — Configurar la app
Abre `config.js` y pega ahí esos dos valores:

```js
export const SUPABASE_URL = "https://xxxxxxxx.supabase.co";
export const SUPABASE_ANON_KEY = "eyJhbGciOi....";
```

Guarda el archivo. No hay que tocar nada más del código.

## Paso 3 — Publicarla gratis (elige una opción)

**Opción A — Cloudflare Pages (la más simple, sin usar terminal)** !2uxE*VM^j5S#eT
1. Ve a [pages.cloudflare.com](https://pages.cloudflare.com) → crea cuenta
   gratis → "Create a project" → "Direct upload".
2. Arrastra la carpeta `nevera-app` completa (o los archivos sueltos).
3. Te da una URL tipo `https://mi-nevera.pages.dev`.

**Opción B — GitHub Pages**
1. Crea un repositorio en GitHub y sube estos archivos.
2. Ve a Settings → Pages → selecciona la rama `main` y carpeta raíz.
3. Te da una URL tipo `https://tuusuario.github.io/nevera-app/`.

Guarda esa URL, la usarás para grabar las pegatinas.

## Paso 4 — Grabar las pegatinas NFC
1. Compra pegatinas NFC tipo **NTAG213** (las más baratas y suficientes;
   se consiguen en packs de 10-25 muy económicos).
2. Instala la app gratuita **NFC Tools** (Android / iPhone).
3. En NFC Tools → "Escribir" → "Añadir un registro" → "URL/URI".
4. Escribe la URL de tu web + la página `producto.html` + el `slug` del
   producto, por ejemplo:

   ```
   https://mi-nevera.pages.dev/producto.html?slug=leche&accion=agotado
   ```

   - `slug` es el identificador del producto. Cuando lo añades desde
     `index.html`, la app genera el slug automáticamente a partir del
     nombre (ej. "Leche" → `leche`). Si tienes dudas de cuál es, puedes
     mirarlo en Supabase → Table Editor → `productos`.
   - `accion` puede ser `agotado` (por defecto, si no la escribes) o
     `poco`, según qué quieras que haga esa pegatina en concreto.
5. Pulsa "Escribir" y acerca el móvil a la pegatina.
6. Pega la pegatina en el envase del producto o en un lugar fijo de la
   nevera/despensa.

Al acercar el móvil, se abre la web, se actualiza el estado del producto
y aparece el popup preguntando si quieres añadirlo a la lista de la
compra.

## Notas y límites
- El plan gratuito de Supabase es de sobra para 200 productos (el límite
  gratuito es de 500 MB, aquí usarás un par de KB).
- Al no llevar login, cualquiera con tu URL de Supabase podría editar los
  datos — para un uso doméstico personal es un riesgo mínimo asumible.
  Si algún día quieres cerrarlo, se puede añadir un login sencillo con
  Supabase Auth.
- Puedes seguir añadiendo productos nuevos a mano desde `index.html` en
  cualquier momento, no hace falta pegatina para eso.
- Si quieres, puedes anclar `index.html` como icono en la pantalla de
  inicio del móvil para que parezca una app normal.