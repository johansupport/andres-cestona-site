-- Agrega andrescestona8@gmail.com como segundo admin (puede escribir en
-- strategy_results, igual que johantrading2021@gmail.com).
-- Nota: la tabla strategy_status no existe todavía en este proyecto,
-- así que su política se deja fuera de esta migración (tema aparte).
-- Seguro de correr aunque ya exista la política — solo la reemplaza.
-- Ejecutar en el SQL Editor de Supabase una sola vez.

drop policy if exists "admin write strategy_results" on strategy_results;
create policy "admin write strategy_results" on strategy_results
  for all to authenticated
  using (auth.jwt() ->> 'email' in ('johantrading2021@gmail.com', 'andrescestona8@gmail.com'))
  with check (auth.jwt() ->> 'email' in ('johantrading2021@gmail.com', 'andrescestona8@gmail.com'));
