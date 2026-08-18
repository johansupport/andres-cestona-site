-- Separa las carpetas de simulaciones por tipo (capital propio vs fondeo),
-- para que al cambiar de pestaña en "Mis simulaciones" no se mezclen las
-- carpetas de un tipo con las del otro.
--
-- Seguro de correr aunque ya exista — usa IF NOT EXISTS.
-- Ejecutar en el SQL Editor de Supabase una sola vez.

alter table simulation_folders add column if not exists tipo text not null default 'capital_propio';
