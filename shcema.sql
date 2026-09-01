-- Ejecuta todo este archivo de una vez en Supabase → SQL Editor → New query → Run

create extension if not exists "pgcrypto";

create table if not exists productos (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  nombre text not null,
  emoji text not null default '📦',
  estado text not null default 'stock' check (estado in ('stock','poco','agotado')),
  categoria text,
  creado_en timestamptz not null default now()
);

create table if not exists lista_compra (
  id uuid primary key default gen_random_uuid(),
  nombre text not null,
  emoji text not null default '🛒',
  comprado boolean not null default false,
  creado_en timestamptz not null default now()
);

alter table productos enable row level security;
alter table lista_compra enable row level security;

-- App de uso personal, sin login: permitimos leer/escribir con la clave "anon".
-- (Solo quien tenga tu URL de Supabase podría tocar los datos; para un uso
-- doméstico es un riesgo asumible. Si más adelante quieres cerrarlo del todo,
-- se puede añadir login con email/contraseña de Supabase Auth.)
create policy "anon_all_productos" on productos for all using (true) with check (true);
create policy "anon_all_lista" on lista_compra for all using (true) with check (true);

-- Unos productos de ejemplo para probar que todo funciona.
-- Bórralos cuando quieras y añade los tuyos desde la propia app (hasta 200 sin problema).
insert into productos (slug, nombre, emoji, estado) values
  ('leche', 'Leche', '🥛', 'stock'),
  ('huevos', 'Huevos', '🥚', 'stock'),
  ('queso', 'Queso', '🧀', 'poco'),
  ('yogures', 'Yogures', '🍶', 'stock'),
  ('tomates', 'Tomates', '🍅', 'agotado')
on conflict (slug) do nothing;