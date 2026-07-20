-- Resultados diarios por estrategia (XAUUSD Swing, XAUUSD Daily, TESLA)
-- Fuente de verdad en vivo para estadisticas.html, calculadora.html y el panel del home.
-- Ejecutar este script completo en el SQL Editor de Supabase (una sola vez).

create table if not exists strategy_results (
  id uuid primary key default gen_random_uuid(),
  estrategia text not null check (estrategia in ('swing','daily','tesla','btc')),
  fecha date not null,
  resultado text not null check (resultado in ('win','loss')),
  porcentaje numeric not null,
  created_at timestamptz not null default now(),
  unique (estrategia, fecha)
);

alter table strategy_results enable row level security;

-- Lectura pública: las páginas de estadísticas/calculadora/home la necesitan sin login.
drop policy if exists "public read strategy_results" on strategy_results;
create policy "public read strategy_results" on strategy_results
  for select to anon using (true);

-- Escritura solo para el admin (mismo email que ya usa admin.html).
drop policy if exists "admin write strategy_results" on strategy_results;
create policy "admin write strategy_results" on strategy_results
  for all to authenticated
  using (auth.jwt() ->> 'email' = 'johantrading2021@gmail.com')
  with check (auth.jwt() ->> 'email' = 'johantrading2021@gmail.com');

create index if not exists strategy_results_estrategia_fecha_idx on strategy_results(estrategia, fecha);
