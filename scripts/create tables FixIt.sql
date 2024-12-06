create table company (
  id bigint primary key generated always as identity,
  name text not null,
  nif text not null,
  address text,
  email text,
  phone text,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now(),
  ocation_reference text, 
  postal_code text
);

create table client (
  id bigint primary key generated always as identity,
  company_id bigint references company (id),
  role_id bigint references role (id),
  name text not null,
  email text,
  phone text,
  active boolean default true,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table machine_type (
  id bigint primary key generated always as identity,
  description text not null,
  active boolean default true,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table machine_model (
  id bigint primary key generated always as identity,
  model text not null,
  machine_type_id bigint references machine_type (id),
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table machine (
  id bigint primary key generated always as identity,
  company_id bigint references company (id),
  machine_model_id bigint references machine_model (id),
  serial_number text not null,
  number_hours int,
  active boolean default true,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);
create table status (
  id bigint primary key generated always as identity,
  description text not null,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table appointment (
  id bigint primary key generated always as identity,
  client_id bigint references client (id),
  machine_id bigint references machine (id),
  status_id  bigint references status (id),
  date_appointment date not null,
  date_conclusion date,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table role (
  id bigint primary key generated always as identity,
  name text not null,
  permission text,
  description text,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table worker (
  id bigint primary key generated always as identity,
  role_id bigint references role (id),
  name text not null,
  admission_date date,
  verified boolean default false,
  active boolean default true,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table parts (
  id bigint primary key generated always as identity,
  description text not null,
);

create table service (
  id bigint primary key generated always as identity,
  appointment_id bigint references appointment (id),
  worker_id bigint references worker (id),
  parts_id bigint references parts (id),
  date_start date not null,
  date_conclusion date,
  motive_reschedule text,
  client_signature text,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table review (
  id bigint primary key generated always as identity,
  service_id bigint references service (id),
  review_star int,
  description text,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table login (
  id bigint primary key generated always as identity,
  email text not null,
  password text not null,
  remember boolean default false,
  client_id bigint references client (id),
  worker_id bigint references worker (id),
  last_login timestamp with time zone,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);