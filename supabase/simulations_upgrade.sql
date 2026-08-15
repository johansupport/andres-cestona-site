-- Amplía "simulations" para soportar tipo (capital propio / fondeo), carpetas
-- y color de acento, y agrega una tabla de carpetas por usuario.
--
-- Seguro de correr aunque ya exista algo — usa IF NOT EXISTS / DROP POLICY IF EXISTS.
-- Ejecutar en el SQL Editor de Supabase una sola vez.

-- Carpetas para organizar simulaciones
create table if not exists simulation_folders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  nombre text not null,
  created_at timestamptz default now()
);

alter table simulation_folders enable row level security;

drop policy if exists "own folders" on simulation_folders;
create policy "own folders" on simulation_folders
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Extender simulations: tipo (capital_propio | fondeo), estrategia/activo usado
-- (solo aplica a fondeo), resultado del reto, color de acento y carpeta.
-- Todo nullable o con default para no romper las filas existentes (todas
-- las que ya hay vienen de la calculadora → capital_propio).
alter table simulations add column if not exists tipo text not null default 'capital_propio';
alter table simulations add column if not exists estrategia text;
alter table simulations add column if not exists resultado_reto text;
alter table simulations add column if not exists color text;
alter table simulations add column if not exists folder_id uuid references simulation_folders(id) on delete set null;
