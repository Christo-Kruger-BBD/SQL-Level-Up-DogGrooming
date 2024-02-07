USE pipelines;

CREATE TABLE CustomerData(
  id INT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(name)
);

GO;

INSERT INTO CustomerData (id, name) VALUES
(1, 'John Smith'),
(2, 'Alice Johnson'),
(3, 'Michael Brown'),
(4, 'Emily Davis'),
(5, 'William Wilson'),
(6, 'Sophia Martinez'),
(7, 'James Anderson'),
(8, 'Olivia Taylor'),
(9, 'Daniel Thomas'),
(10, 'Emma Garcia');

GO;
