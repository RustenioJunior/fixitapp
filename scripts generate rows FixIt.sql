-- Generate sample data for Company table
INSERT INTO
  company (name, nif, address, email, phone, ative, create_date, modify_date, location_reference, postal_code)
SELECT
  'Company ' || i AS name,
  'NIF' || i AS nif,
  'Address ' || i AS address,
  'email' || i || '@company.com' AS email,
  '123-456-789' AS phone,
  true AS ative,
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date,  -- Datas aleatórias nos últimos 4 anos
  'Reference ' || i AS location_reference,
  '12345-' || LPAD(i::text, 3, '0') AS postal_code
FROM
  generate_series(1, 100000) AS s (i);
  
-- Generate sample data for Client table
INSERT INTO
  client (company_id, role_id, name, verified, active, create_date, modify_date)
SELECT
  (i % 1000) + 1 AS company_id, -- Referência a uma empresa fictícia
  (i % 5) + 1 AS role_id,       -- Referência a um dos 5 roles gerados acima
  'Client ' || i AS name,
  TRUE AS verified,             -- Todos verificados
  TRUE AS active,               -- Todos ativos
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date  -- Datas aleatórias nos últimos 4 anos

FROM
  generate_series(1, 10000) AS s (i);  

-- Generate sample data for Machine_Type table
insert into
  machine_type (description, active, create_date, modify_date)
select
  'Machine Type ' || i
   true AS ative,
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date,  -- Datas aleatórias nos últimos 4 anos
from
  generate_series(1, 10) as s (i);


-- Generate sample data for Machine_Model table
insert into
  machine_model (
    model,
    machine_type_id,
    create_date,
    modify_date
  )
select
  'Model ' || i,
  (i % 10) + 1,
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date  -- Datas aleatórias nos últimos 4 anos
  
from
  generate_series(1, 100) as s (i);  

-- Generate sample data for Machine table
INSERT INTO
  machine (
    company_id,
    machine_model_id,
    serial_number,
    number_hours,
    maintenance_date,
    active,
    create_date,
    modify_date
  )
SELECT
  (i % 1000) + 1 AS company_id,                  -- Referência à empresa, IDs de 1 a 1000
  (i % 100) + 1 AS machine_model_id,             -- Referência ao modelo, IDs de 1 a 100
  'SN' || i AS serial_number,                    -- Número de série único para cada máquina
  (i * 5) % 1000 AS number_hours,                -- Número de horas variando entre 0 e 999
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS maintenance_date,  -- Datas aleatórias nos últimos 5 anos
  (i % 2) = 0 AS active,                         -- Alterna entre TRUE e FALSE 
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date  -- Datas aleatórias nos últimos 4 anos
  
FROM
  generate_series(1, 1000) AS s (i);  

-- Generate sample data for Status table
INSERT INTO status  
  (description, create_date, modify_date)
SELECT
  'Status ' || i, -- Nome fictício para cada status         
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date  -- Datas aleatórias nos últimos 4 anos
FROM    
  generate_series(1, 10) as s (i);  

-- Generate sample data for Appointment table
INSERT INTO
  appointment (
    client_id,
    machine_id,
    status_id,
    date_apointement,
    date_conclusion,
    create_date,
    modify_date
  )
SELECT
  (i % 10000) + 1 AS client_id,                          -- Referência ao cliente, IDs entre 1 e 10.000
  (i % 1000) + 1 AS machine_id,                          -- Referência à máquina, IDs entre 1 e 1.000
  CASE 
    WHEN i % 3 = 0 THEN 'Completed'                      -- Status como texto (ajuste conforme necessário)
    ELSE 'Pending' 
  END AS status_id,
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS date_apointement, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS date_conclusion,  -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date  -- Datas aleatórias nos últimos 4 anos
  
  generate_series(1, 1000) AS s (i);  

  -- Generate sample data for Role table
insert into
  role (name, permission, description, create_date, modify_date)
select
  'Role ' || i,
  'Permission ' || i,
  'Description for role ' || i,
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date  -- Datas aleatórias nos últimos 4 anos
from
  generate_series(1, 5) as s (i);

-- Generate sample data for Worker table
INSERT INTO
  worker (
    role_id,
    name,
    admission_date,
    verified,
    active,
    create_date,
    modify_date
  )
SELECT
  (i % 5) + 1 AS role_id,                             -- IDs de 1 a 5 para os papéis
  'Worker ' || i AS name,                             -- Nome fictício do trabalhador
  CURRENT_DATE - (i % 365) AS admission_date,         -- Data de admissão nos últimos 365 dias
  (i % 2) = 0 AS verified,                            -- Verificado (booleano)
  TRUE AS active,                                     -- Sempre ativo
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date  -- Datas aleatórias nos últimos 4 anos
  
FROM
  generate_series(1, 1000) AS s (i);

-- Generate sample data for Parts table
INSERT INTO
  parts (
    name,
    description
  )
SELECT
  'Part ' || i AS name,                            -- Nome fictício para cada parte
  'Description ' || i AS description             -- Descrição fictícia para cada parte

FROM
  generate_series(1, 200) AS s (i);


-- Generate sample data for Service table
INSERT INTO
  service (
     appointment_id,
     worker_id,
     parts_id,
     date_start,
     date_conclusion,
     motive_reschedule,
     client_signature,
     create_date,
     modify_date
  )
SELECT
  (i % 1000) + 1 AS appointment_id,                -- IDs de 1 a 1000 (referência à tabela `appointment`)
  (i % 500) + 1 AS worker_id,                      -- IDs de 1 a 500 (referência à tabela `worker`)
  (i % 200) + 1 AS parts_id,                       -- IDs de 1 a 200 (referência à tabela `parts`)
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS date_start,           -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS date_conclusion,      -- Datas aleatórias nos últimos 5 anos
  CASE 
    WHEN i % 5 = 0 THEN 'Rescheduled due to parts unavailability'
    WHEN i % 5 = 1 THEN 'Rescheduled due to client request'
    ELSE NULL
  END AS motive_reschedule,                        -- Motivo do reagendamento ou NULL
  'Signature ' || i AS client_signature,           -- Assinatura fictícia para cada serviço
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date  -- Datas aleatórias nos últimos 4 anos
FROM
  generate_series(1, 1000) AS s (i);
-- Generate sample data for Review table
INSERT INTO
  review (
    service_id,
    review_star,
    description,
    create_date,
    modify_date
  )
SELECT
  (i % 1000) + 1 AS service_id,                       -- Referência à tabela `service`, IDs de 1 a 1000
  (i % 5) + 1 AS review_star,                         -- Avaliação de 1 a 5 estrelas
  'Review description ' || i AS description,          -- Descrição única para cada revisão
  CURRENT_DATE - (TRUNC(RANDOM() * 1825)::int) AS create_date, -- Datas aleatórias nos últimos 5 anos
  CURRENT_DATE - (TRUNC(RANDOM() * 1460)::int) AS modify_date  -- Datas aleatórias nos últimos 4 anos
FROM
  generate_series(1, 1000) AS s (i);

-- Generate sample data for Login table
insert into
  login (
    email,
    password,
    remember,
    client_id,
    worker_id,
    last_login,
    create_date,
    modify_date
  )
select
  'login' || i || '@example.com',
  'password' || i,
  (i % 2) = 0,
  (i % 10000) + 1,
  (i % 1000) + 1,
  current_timestamp - (i % 100) * interval '1 day'
from
  generate_series(1, 1000) as s (i);
  
