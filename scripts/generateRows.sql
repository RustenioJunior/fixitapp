create table company (
  id bigint primary key generated always as identity,
  name varchar(150) not null,
  nif bigint not null,
  address varchar(150),
  email varchar(150),
  phone varchar(25),
  active boolean,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table client (
  id bigint primary key generated always as identity,
  company_id bigint references company (id),
  name varchar(150) not null,
  verified boolean default false,
  active boolean default true,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table machine_type (
  id bigint primary key generated always as identity,
  description varchar(150) not null,
  active boolean default true,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table machine_model (
  id bigint primary key generated always as identity,
  machine_type_id bigint references machine_type (id),
  model varchar(150) not null,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table machine (
  id bigint primary key generated always as identity,
  company_id bigint references company (id),
  machine_model_id bigint references machine_model (id),
  serial_number varchar(150) not null,
  number_hours int,
  mantence_date timestamp with time zone,
  active boolean default true,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table status (
  id bigint primary key generated always as identity,
  description varchar(150),
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table appointment (
  id bigint primary key generated always as identity,
  client_id bigint references client (id),
  machine_id bigint references machine (id),
  status_id bigint references status (id),
  date_appointment date not null,
  date_conclusion date,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table role (
  id bigint primary key generated always as identity,
  permission varchar(150),
  description varchar(150),
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table worker (
  id bigint primary key generated always as identity,
  role_id bigint references role (id),
  name varchar(150) not null,
  admission_date date,
  machine_type varchar(150),
  verified boolean default false,
  active boolean default true,
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table service (
  id bigint primary key generated always as identity,
  worker_id bigint references worker (id),
  appointment_id bigint references appointment (id),
  date_start date not null,
  date_conclusion date,
  parts varchar(150),
  client_signature varchar(150),
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table review (
  id bigint primary key generated always as identity,
  review_star int,
  description varchar(150),
  create_date timestamp with time zone default now(),
  modify_date timestamp with time zone default now()
);

create table login (
  id bigint primary key generated always as identity,
  client_id bigint references client (id),
  worker_id bigint references worker (id),
  email varchar(150) not null,
  password varchar(150) not null,
  last_login timestamp with time zone default now()
);