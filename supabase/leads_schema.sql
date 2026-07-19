-- Leads de la clase gratis / aplicación a llamada 1:1 (link.html#clase)
-- Ejecutar este script completo en el SQL Editor de Supabase (una sola vez).

create table if not exists applications (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  phone text,
  availability text,
  experience text,
  motivo text,
  status text not null default 'new' check (status in ('new','contacted','booked','discarded')),
  created_at timestamptz not null default now()
);

alter table applications enable row level security;

-- El formulario público solo puede insertar (nadie puede leer/editar desde el cliente).
drop policy if exists "public insert applications" on applications;
create policy "public insert applications" on applications
  for insert to anon with check (true);

create index if not exists applications_created_at_idx on applications(created_at);
