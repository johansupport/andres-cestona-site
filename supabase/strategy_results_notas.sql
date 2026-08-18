-- Agrega notas/descripción a cada resultado de estrategia (strategy_results),
-- para mostrarlas en el detalle de cada trade dentro de "Trades recientes".
--
-- Seguro de correr aunque ya exista — usa IF NOT EXISTS.
-- Ejecutar en el SQL Editor de Supabase una sola vez.

alter table strategy_results add column if not exists notas text;
