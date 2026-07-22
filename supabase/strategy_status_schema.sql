-- Estado en vivo por estrategia (Corriendo / TP / SL) para el panel del dashboard.
-- Solo XAUUSD (swing) y TESLA tienen datos reales hoy; BTC y XAUAUD se muestran
-- como "Próximamente" directamente en el HTML, sin fila en esta tabla.
-- Ejecutar este script completo en el SQL Editor de Supabase (una sola vez).

create table if not exists strategy_status (
  estrategia text primary key check (estrategia in ('swing','tesla')),
  status text not null default 'running' check (status in ('running','tp','sl')),
  entry_price numeric,
  tp_price numeric,
  sl_price numeric,
  updated_at timestamptz not null default now()
);

alter table strategy_status enable row level security;

-- Lectura pública: el panel del dashboard la necesita para todos los usuarios logueados.
drop policy if exists "public read strategy_status" on strategy_status;
create policy "public read strategy_status" on strategy_status
  for select to anon, authenticated using (true);

-- Escritura solo para el admin (mismo email que ya usa admin.html).
drop policy if exists "admin write strategy_status" on strategy_status;
create policy "admin write strategy_status" on strategy_status
  for all to authenticated
  using (auth.jwt() ->> 'email' = 'johantrading2021@gmail.com')
  with check (auth.jwt() ->> 'email' = 'johantrading2021@gmail.com');

insert into strategy_status (estrategia, status) values
  ('swing', 'running'),
  ('tesla', 'running')
on conflict (estrategia) do nothing;
