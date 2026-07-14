-- Cuentas de trading (fondeo / capital propio) — panel "Cuentas" del dashboard
-- Ejecutar este script completo en el SQL Editor de Supabase (una sola vez).

create table if not exists trading_accounts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  kind text not null check (kind in ('fondeo','capital_propio')),
  name text not null,
  number text not null,
  step text check (step in ('1-Step','2-Step')),
  firm text,
  balance numeric not null default 0,
  platform text,
  account_type text,
  start_date date not null default current_date,
  end_date date,
  profit_target_percent numeric,
  max_daily_loss_percent numeric,
  max_loss_percent numeric,
  status text not null default 'active' check (status in ('active','closed')),
  result text check (result in ('passing','not_passing')),
  closed_at timestamptz,
  visible boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists account_trades (
  id uuid primary key default gen_random_uuid(),
  account_id uuid not null references trading_accounts(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null,
  pnl numeric not null,
  lots numeric,
  notes text,
  created_at timestamptz not null default now()
);

alter table trading_accounts enable row level security;
alter table account_trades enable row level security;

drop policy if exists "own trading_accounts" on trading_accounts;
create policy "own trading_accounts" on trading_accounts
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "own account_trades" on account_trades;
create policy "own account_trades" on account_trades
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create index if not exists account_trades_account_id_idx on account_trades(account_id);
create index if not exists account_trades_date_idx on account_trades(date);
