DROP TABLE IF EXISTS Document;
DROP TABLE IF EXISTS Stated;
DROP TABLE IF EXISTS DocPossesses;
DROP TABLE IF EXISTS RevPossesses;
DROP TABLE IF EXISTS Modified;
DROP TABLE IF EXISTS Belongs;
DROP TABLE IF EXISTS Request;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS Language;
DROP TABLE IF EXISTS File;
DROP TABLE IF EXISTS DocAttribute;
DROP TABLE IF EXISTS CompanyRole;
DROP TABLE IF EXISTS Revision;
DROP TABLE IF EXISTS RevisionAttribute;
DROP TABLE IF EXISTS DocumentRoleWorker;
DROP TABLE IF EXISTS ProjectRole;
DROP TABLE IF EXISTS CheckOut;
DROP TABLE IF EXISTS Type;
DROP TABLE IF EXISTS Status;
DROP TABLE IF EXISTS Worker;

CREATE TABLE Company (
	CID			INTEGER,
	Cname 		TEXT NOT NULL,
	NIF			INTEGER UNIQUE NOT NULL,
	address		TEXT NOT NULL,
	CONSTRAINT company_pk PRIMARY KEY (CID)
);
CREATE TABLE Document (
	docID		INTEGER PRIMARY KEY,
	dNAME		TEXT,
	date_ini	DATE,
	date_fin	DATE,
	type		TEXT,
	ownerID		INTEGER,
	CONSTRAINT document_type_fk FOREIGN KEY (type) REFERENCES Type(TID) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT document_owner_fk FOREIGN KEY (ownerID) REFERENCES Worker(WID) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT checkDiDf CHECK (date_ini<date_fin OR date_fin=NULL)
);
CREATE TABLE Language (
	LID			INTEGER,
	Lname		TEXT UNIQUE NOT NULL,
	CONSTRAINT language_pk PRIMARY KEY (LID)
);
CREATE TABLE File (
	FID			INTEGER,
	docID		INTEGER NOT NULL,
	Fname		TEXT UNIQUE NOT NULL,
	size		INTEGER NOT NULL,
	extension	TEXT,
	CONSTRAINT file_pk PRIMARY KEY (FID), 
	CONSTRAINT file_doc_fk FOREIGN KEY (docID) REFERENCES Document(docID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT checkFSize CHECK (size >=0)
);
CREATE TABLE DocAttribute (
	DAID		INTEGER,
	DAname		TEXT UNIQUE NOT NULL,
	DAvalue		TEXT UNIQUE NOT NULL,
	CONSTRAINT docAttribute_pk PRIMARY KEY (DAID) 
);
CREATE TABLE Type (
	TID			INTEGER,
	Tname		TEXT NOT NULL,
	last_mod_date	DATE,
	status		INTEGER NOT NULL,
	remarks		TEXT UNIQUE NOT NULL,
	CONSTRAINT type_pk PRIMARY KEY (TID),
	CONSTRAINT status_bool CHECK (status=0 OR status=1)
);
CREATE TABLE Worker (
	WID			INTEGER PRIMARY KEY,
	Wname		TEXT NOT NULL
);
CREATE TABLE CompanyRole (
	CRID		INTEGER,
	CRname		TEXT UNIQUE NOT NULL,
	CONSTRAINT companyRole_pk PRIMARY KEY (CRID)
);
CREATE TABLE Revision (
	docID		INTEGER NOT NULL,
	revID		INTEGER PRIMARY KEY,
	authorID	INTEGER NOT NULL,
	version		TEXT,
	date		DATE NOT NULL,
	CONSTRAINT revision_author_fk FOREIGN KEY (authorID) REFERENCES Worker(WID) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT revision_doc_fk FOREIGN KEY (docID) REFERENCES Document(docID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE RevisionAttribute (
	RAID		INTEGER,
	RAname		TEXT UNIQUE NOT NULL,
	RAvalue		TEXT UNIQUE NOT NULL,
	CONSTRAINT revisionAttribute_pk PRIMARY KEY (RAID)
);
CREATE TABLE Stated (
	LID			INTEGER,
	docID		INTEGER,
	CONSTRAINT stated_fk1 FOREIGN KEY (LID) REFERENCES Language(LID) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT stated_fk2 FOREIGN KEY (docID) REFERENCES Document(docID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT stated_pk PRIMARY KEY(LID,docID)
);
CREATE TABLE DocPossesses (
	DAID		INTEGER,
	docID		INTEGER,
	CONSTRAINT docPossesses_fk1 FOREIGN KEY (DAID) REFERENCES DocAttribute(DAID) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT docPossesses_fk2 FOREIGN KEY (docID) REFERENCES Document(docID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT docPossesses_pk PRIMARY KEY(DAID,docID)
);
CREATE TABLE RevPossesses (
	RAID 		INTEGER,
	revID		INTEGER,
	CONSTRAINT revPossesses_fk1 FOREIGN KEY (RAID) REFERENCES RevisionAttribute(RAID) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT revPossesses_fk2 FOREIGN KEY (revID) REFERENCES Revision(revID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT revPossesses_pk PRIMARY KEY(revID,RAID)
);
CREATE TABLE Belongs (
	WID			INTEGER,
	CRID		INTEGER,
	CONSTRAINT belongs_fk1 FOREIGN KEY (WID) REFERENCES Worker(WID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT belongs_fk2 FOREIGN KEY (CRID) REFERENCES CompanyRole(CRID) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT belongs_pk PRIMARY KEY(WID,CRID)
);
CREATE TABLE Modified (
	TID			INTEGER,
	WID			INTEGER,
	CONSTRAINT modified_fk1 FOREIGN KEY (TID) REFERENCES Type(TID) ON DELETE RESTRICT ON UPDATE CASCADE ON UPDATE CASCADE,
	CONSTRAINT modified_fk2 FOREIGN KEY (WID) REFERENCES Worker(WID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT modified_pk PRIMARY KEY(TID,WID)
);
CREATE TABLE Request (
	requestID	INTEGER,
	docID		INTEGER UNIQUE,
	CID			INTEGER NOT NULL,
	SID			INTEGER NOT NULL,
	propose_date	DATE NOT NULL,
	CONSTRAINT request_fk1 FOREIGN KEY (docID) REFERENCES Document(docID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT request_fk2 FOREIGN KEY (CID) REFERENCES Company(CID) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT request_fk3 FOREIGN KEY (SID) REFERENCES Status(SID) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT request_pk PRIMARY KEY(requestID)
);
CREATE TABLE ProjectRole (
	PRID		INTEGER,
	PRname		TEXT UNIQUE NOT NULL,
	CONSTRAINT projectRole_pk PRIMARY KEY(PRID)
);
CREATE TABLE DocumentRoleWorker (
	docID		INTEGER,
	WID			INTEGER,
	PRID		INTEGER,
	CONSTRAINT drw_document_fk FOREIGN KEY (docID) REFERENCES Document(docID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT drw_role_fk FOREIGN KEY (WID) REFERENCES Worker(WID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT drw_worker_fk FOREIGN KEY (PRID) REFERENCES ProjectRole(PRID) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT drw_pk PRIMARY KEY (docID, WID, PRID)
);
CREATE TABLE CheckOut (
	revID		INTEGER,
	WID			INTEGER,
	COdate		DATE NOT NULL,
	CONSTRAINT checkOut_fk1 FOREIGN KEY (revID) REFERENCES Revision(revID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT checkOut_fk2 FOREIGN KEY (WID) REFERENCES Worker(WID) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT checkOut_pk PRIMARY KEY(revID)
);
CREATE TABLE Status (
	SID			INTEGER,
	sDescription	TEXT UNIQUE NOT NULL,
	CONSTRAINT status_pk PRIMARY KEY (SID)
);