-- Agrega color a las carpetas de simulaciones.
-- El color ahora se asigna a la carpeta (no a cada simulación individual),
-- así todas las simulaciones dentro de una carpeta comparten el mismo color
-- para diferenciarlas visualmente por grupo.
--
-- Seguro de correr aunque ya exista — usa IF NOT EXISTS.
-- Ejecutar en el SQL Editor de Supabase una sola vez.

alter table simulation_folders add column if not exists color text;
