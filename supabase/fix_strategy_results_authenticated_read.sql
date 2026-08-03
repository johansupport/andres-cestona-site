-- Fix: los usuarios logueados (no admin) no podían leer strategy_results.
-- La política original solo daba SELECT al rol "anon", dejando a "authenticated"
-- sin ninguna política de lectura -> RLS devolvía 0 filas sin error para
-- cualquier usuario logueado que no fuera el admin (calculadora.html y el
-- simulador de fondeo del dashboard se veían "vacíos" para esos usuarios).
-- Ejecutar en el SQL Editor de Supabase.

drop policy if exists "public read strategy_results" on strategy_results;
create policy "public read strategy_results" on strategy_results
  for select to anon, authenticated using (true);
