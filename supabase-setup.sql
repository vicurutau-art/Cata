-- ══════════════════════════════════════════
-- Ejecutá esto en Supabase → SQL Editor
-- ══════════════════════════════════════════

create table catas (
  id            uuid default gen_random_uuid() primary key,
  user_id       uuid references auth.users not null,
  created_at    timestamptz default now(),

  -- Identificación
  bodega        text, etiqueta text, varietal text,
  anada         text, origen   text, precio   text,

  -- Vista
  apariencia      text, intensidad_vista text,
  color_hex       text, color_name       text,
  color_varietal  text, color_type       text,
  reflejo         text,

  -- Nariz
  limpidez        text, intensidad_nariz  text,
  desarrollo      text, perfil_nariz      text[],
  complejidad_nariz text, aromas          text[],

  -- Boca
  dulzor          text, volumen          text,
  acidez          text, alcohol          text,
  tanino          text, intensidad_sabor text,
  perfil_boca     text[], complejidad_boca text,
  persistencia    text, final            text,

  -- Puntuación
  score     integer,
  cata_com  text
);

-- Seguridad: cada usuario solo ve sus propias catas
alter table catas enable row level security;

create policy "ver propias"    on catas for select using (auth.uid() = user_id);
create policy "crear propias"  on catas for insert with check (auth.uid() = user_id);
create policy "editar propias" on catas for update using (auth.uid() = user_id);
create policy "borrar propias" on catas for delete using (auth.uid() = user_id);
