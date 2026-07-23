-- Suma "xauaud" como estrategia válida en strategy_results (ya creada por strategy_results_schema.sql).
-- Seguro de correr aunque la tabla ya tenga datos — no borra ni modifica ninguna fila existente.
-- Ejecutar en el SQL Editor de Supabase una sola vez.

alter table strategy_results drop constraint if exists strategy_results_estrategia_check;
alter table strategy_results add constraint strategy_results_estrategia_check
  check (estrategia in ('swing','daily','tesla','btc','xauaud'));
