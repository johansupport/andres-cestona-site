-- Revertir la importación equivocada de BTC bajo XAUUSD Swing (2026-08-02).
-- El import masivo de btc_2026_daily_pct.json se hizo con "swing" seleccionado en vez de "btc",
-- pisando 213 fechas de 2026 en strategy_results. Diagnóstico completo:
--   - 135 filas nuevas y falsas (fechas donde Swing no tenía trade) -> se borran.
--   - 35 filas de trades reales de Swing que quedaron pisadas -> se restauran usando
--     strategy_results_migration.sql (fuente original hasta 2026-06-19) como referencia.
--   - 33 filas no cambiaron de valor real (coincidencia con el valor de BTC ese día) -> no requieren acción.
--   - 10 trades de julio 2026 (posteriores a la migración) también quedaron pisados pero no
--     hay forma de recuperar su valor original: 2026-07-01, 07-07, 07-10, 07-13, 07-15, 07-16,
--     07-22, 07-27, 07-29, 07-30. Revisalos a mano en admin.html ("Cargar un día") con tus propios
--     registros de esas operaciones.
-- Ejecutar una sola vez en el SQL Editor de Supabase.
--
-- 1) Borra las 135 filas nuevas y falsas que insertó el import (mismo timestamp exacto).
delete from strategy_results where estrategia = 'swing' and created_at = '2026-08-02T15:27:36.135242+00:00';

-- 2) Restaura el resultado/porcentaje original en las filas que SÍ existían y quedaron pisadas.
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-01-06';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-01-09';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-01-16';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-01-21';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-01-23';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-01-28';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-01-29';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-02-04';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-02-11';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-02-13';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-02-17';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-02-20';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-02-26';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-02-27';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-03-03';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-03-06';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-03-12';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-03-13';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-03-24';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-03-27';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-04-07';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-04-24';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-04-27';
update strategy_results set resultado = 'win', porcentaje = 0.8 where estrategia = 'swing' and fecha = '2026-05-04';
update strategy_results set resultado = 'win', porcentaje = 0.8 where estrategia = 'swing' and fecha = '2026-05-07';
update strategy_results set resultado = 'win', porcentaje = 0.8 where estrategia = 'swing' and fecha = '2026-05-14';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-05-21';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-05-22';
update strategy_results set resultado = 'win', porcentaje = 0.8 where estrategia = 'swing' and fecha = '2026-05-28';
update strategy_results set resultado = 'win', porcentaje = 0.8 where estrategia = 'swing' and fecha = '2026-06-02';
update strategy_results set resultado = 'loss', porcentaje = -1.0 where estrategia = 'swing' and fecha = '2026-06-05';
update strategy_results set resultado = 'win', porcentaje = 0.8 where estrategia = 'swing' and fecha = '2026-06-08';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-06-12';
update strategy_results set resultado = 'win', porcentaje = 1.0 where estrategia = 'swing' and fecha = '2026-06-17';
update strategy_results set resultado = 'win', porcentaje = 0.8 where estrategia = 'swing' and fecha = '2026-06-19';
