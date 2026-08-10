-- Agrega andrescestona8@gmail.com como segundo admin (puede escribir en
-- strategy_results y strategy_status, igual que johantrading2021@gmail.com).
-- Seguro de correr aunque ya existan las políticas — solo las reemplaza.
-- Ejecutar en el SQL Editor de Supabase una sola vez.

drop policy if exists "admin write strategy_results" on strategy_results;
create policy "admin write strategy_results" on strategy_results
  for all to authenticated
  using (auth.jwt() ->> 'email' in ('johantrading2021@gmail.com', 'andrescestona8@gmail.com'))
  with check (auth.jwt() ->> 'email' in ('johantrading2021@gmail.com', 'andrescestona8@gmail.com'));

drop policy if exists "admin write strategy_status" on strategy_status;
create policy "admin write strategy_status" on strategy_status
  for all to authenticated
  using (auth.jwt() ->> 'email' in ('johantrading2021@gmail.com', 'andrescestona8@gmail.com'))
  with check (auth.jwt() ->> 'email' in ('johantrading2021@gmail.com', 'andrescestona8@gmail.com'));
