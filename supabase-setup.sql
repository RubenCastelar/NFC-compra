create table if not exists public.shopping_list_items (
  id bigint generated always as identity primary key,
  name text not null check (char_length(trim(name)) > 0),
  week_start date not null,
  created_at timestamptz not null default timezone('utc', now())
);

alter table public.shopping_list_items enable row level security;

grant usage on schema public to anon;
grant select, insert, delete on public.shopping_list_items to anon;
grant usage, select on all sequences in schema public to anon;

drop policy if exists "shopping_list_select" on public.shopping_list_items;
drop policy if exists "shopping_list_insert" on public.shopping_list_items;
drop policy if exists "shopping_list_delete" on public.shopping_list_items;

create policy "shopping_list_select"
on public.shopping_list_items
for select
to anon
using (true);

create policy "shopping_list_insert"
on public.shopping_list_items
for insert
to anon
with check (true);

create policy "shopping_list_delete"
on public.shopping_list_items
for delete
to anon
using (true);
