-- Agrega soporte para subir una captura de gráfico por cada resultado de
-- estrategia (se usa en la nueva vista "Chart overview" de Trades recientes).
--
-- 1) Columna nueva en strategy_results (nullable, no rompe nada existente).
-- 2) Bucket de Storage público "trade-charts" para alojar las imágenes.
-- 3) Políticas: cualquiera puede leer las imágenes, solo los admins pueden subirlas/borrarlas.
--
-- Seguro de correr aunque ya exista algo — usa IF NOT EXISTS / ON CONFLICT / DROP POLICY IF EXISTS.
-- Ejecutar en el SQL Editor de Supabase una sola vez.

alter table strategy_results add column if not exists chart_image_url text;

insert into storage.buckets (id, name, public)
values ('trade-charts', 'trade-charts', true)
on conflict (id) do nothing;

drop policy if exists "public read trade-charts" on storage.objects;
create policy "public read trade-charts" on storage.objects
  for select to anon, authenticated
  using (bucket_id = 'trade-charts');

drop policy if exists "admin write trade-charts" on storage.objects;
create policy "admin write trade-charts" on storage.objects
  for insert to authenticated
  with check (
    bucket_id = 'trade-charts'
    and auth.jwt() ->> 'email' in ('johantrading2021@gmail.com', 'andrescestona8@gmail.com')
  );

drop policy if exists "admin update trade-charts" on storage.objects;
create policy "admin update trade-charts" on storage.objects
  for update to authenticated
  using (
    bucket_id = 'trade-charts'
    and auth.jwt() ->> 'email' in ('johantrading2021@gmail.com', 'andrescestona8@gmail.com')
  );

drop policy if exists "admin delete trade-charts" on storage.objects;
create policy "admin delete trade-charts" on storage.objects
  for delete to authenticated
  using (
    bucket_id = 'trade-charts'
    and auth.jwt() ->> 'email' in ('johantrading2021@gmail.com', 'andrescestona8@gmail.com')
  );
