BEGIN;

CREATE TABLE Snacks (
    sid serial PRIMARY KEY, 
    name text NOT NULL, 
    origin text, 
    description text,
    weight numeric NOT NULL,
    bags numeric NOT NULL,
    weight_per_item numeric NOT NULL,
    barcode integer NOT NULL,
    cost numeric NOT NULL,
    inventory integer NOT NULL,
    threshold integer NOT NULL
);


CREATE TABLE Customers (
    cid serial PRIMARY KEY, 
    name text NOT NULL, 
    address text NOT NULL
);

CREATE TABLE Staff (
    eid serial PRIMARY KEY, 
    name text NOT NULL, 
    capacity text NOT NULL
);

CREATE TABLE Suppliers (
    spid serial PRIMARY KEY, 
    name text NOT NULL, 
    address text NOT NULL, 
    status text NOT NULL,
    maintainer integer NOT NULL,
    FOREIGN KEY (maintainer) REFERENCES Staff (eid)  ON DELETE NO ACTION
);


CREATE TABLE Availabilities (
	avid serial PRIMARY KEY,
	sid integer NOT NULL,
	spid integer NOT NULL,
    cost REAL NOT NULL,
    UNIQUE (sid, spid),
    FOREIGN KEY (sid) REFERENCES Snacks (sid)
    ON DELETE CASCADE,
    FOREIGN KEY (spid) REFERENCES Suppliers (spid)
        ON DELETE CASCADE
);

CREATE TABLE CustomerOrders (
	oid serial PRIMARY KEY,
	cid integer,
	date DATE,
	status text,
	eid integer,
    FOREIGN KEY (cid) REFERENCES Customers (cid)
	ON DELETE CASCADE,
    FOREIGN KEY (eid) REFERENCES Staff (eid)
	ON DELETE NO ACTION
);



CREATE TABLE CustomerSubOrders (
	csoid serial PRIMARY KEY,
	oid integer NOT NULL,
	sid integer NOT NULL,
	quantity integer NOT NULL,
    date DATE,
    FOREIGN KEY (oid) REFERENCES CustomerOrders (oid)
        ON DELETE CASCADE,
    FOREIGN KEY (sid) REFERENCES Snacks (sid)
        ON DELETE CASCADE
);

CREATE TABLE SupplierOrders (
	soid serial PRIMARY KEY,
	spid integer NOT NULL,
	date DATE NOT NULL,
	status text,
	eid integer,
    FOREIGN KEY (spid) REFERENCES Suppliers (spid)
        ON DELETE NO ACTION,
    FOREIGN KEY (eid) REFERENCES Staff (eid)
        ON DELETE NO ACTION
);

CREATE TABLE SupplierSubOrders (
	ssoid serial PRIMARY KEY,
	soid integer NOT NULL,
	avid integer NOT NULL,
	quantity integer NOT NULL,
    date DATE,
    FOREIGN KEY (soid) REFERENCES SupplierOrders (soid)
        ON DELETE CASCADE,
    FOREIGN KEY (avid) REFERENCES Availabilities (avid)
        ON DELETE CASCADE

);
 

COMMIT;
