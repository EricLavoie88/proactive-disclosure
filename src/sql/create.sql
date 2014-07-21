DROP TABLE IF EXISTS GovernmentOrganization CASCADE;
DROP TABLE IF EXISTS GovernmentOrganizationTranslation CASCADE;

DROP TABLE IF EXISTS ContractDisclosure CASCADE;
DROP TABLE IF EXISTS ContractDisclosureTranslation CASCADE;

DROP TABLE IF EXISTS ReclassificationDisclosure CASCADE;
DROP TABLE IF EXISTS ReclassificationDisclosureTranslation CASCADE;

DROP TABLE IF EXISTS WrongdoingDisclosure CASCADE;
DROP TABLE IF EXISTS WrongdoingDisclosureTranslation CASCADE;

DROP TABLE IF EXISTS PostalAddress CASCADE;
DROP TABLE IF EXISTS PostalAddressTranslation CASCADE;

DROP TABLE IF EXISTS AwardDisclosure CASCADE;
DROP TABLE IF EXISTS AwardDisclosureTranslation CASCADE;

DROP TABLE IF EXISTS Person CASCADE;

DROP TABLE IF EXISTS TravelDisclosure CASCADE;
DROP TABLE IF EXISTS TravelDisclosureTranslation CASCADE;

DROP TABLE IF EXISTS TravelAddress CASCADE;

DROP TABLE IF EXISTS HospitalityDisclosure CASCADE;
DROP TABLE IF EXISTS HospitalityDisclosureTranslation CASCADE;

CREATE TABLE GovernmentOrganization (
	id SERIAL PRIMARY KEY,
	memberOf integer REFERENCES GovernmentOrganization (id)
);

CREATE TABLE GovernmentOrganizationTranslation (
	id integer REFERENCES GovernmentOrganization (id) NOT NULL,
	lang char(2) NOT NULL,
	legalName text NOT NULL,
	PRIMARY KEY (id, lang)
);

CREATE TABLE ContractDisclosure (
	id SERIAL PRIMARY KEY,
	organization integer REFERENCES GovernmentOrganization (id) NOT NULL,
	vendor text NOT NULL,
	reference text NOT NULL,
	contractDate date NOT NULL,
	startDate date NOT NULL,
	endDate date NOT NULL,
	originalTotal numeric(12,2),
	total money NOT NULL,
	expiryDate date NOT NULL
);

CREATE TABLE ContractDisclosureTranslation (
	id integer REFERENCES ContractDisclosure (id) NOT NULL,
	lang char(2) NOT NULL,
	workDescription text NOT NULL,
	comments text NOT NULL,
	detailDescription text NOT NULL,
	PRIMARY KEY (id, lang)
);

CREATE TABLE ReclassificationDisclosure (
	id SERIAL PRIMARY KEY,
	organization integer REFERENCES GovernmentOrganization (id) NOT NULL,
	positionNumber varchar(50) NOT NULL,
	reclassificationYear date NOT NULL,
	quarter numeric(1) CHECK (quarter > 0 AND quarter <= 4),
	previousClassification char(10) NOT NULL,
	newClassification char(10) NOT NULL,
	recordNumber integer,
	jobNumber varchar(50),
	previousDifferential varchar(50),
	newDifferential varchar(50),
	expiryDate date NOT NULL
);

CREATE TABLE ReclassificationDisclosureTranslation (
	id integer REFERENCES ReclassificationDisclosure (id) NOT NULL,
	lang char(2) NOT NULL,
	jobTitle text NOT NULL,
	reason text NOT NULL,
	PRIMARY KEY (id, lang)
);

CREATE TABLE WrongdoingDisclosure (
	id SERIAL PRIMARY KEY,
	organization integer REFERENCES GovernmentOrganization (id) NOT NULL,
	wrongdoingYear date NOT NULL,
	quarter numeric(1) CHECK (quarter > 0 AND quarter <= 4),
	expiryDate date NOT NULL
);

CREATE TABLE WrongdoingDisclosureTranslation (
	id integer REFERENCES WrongdoingDisclosure (id) NOT NULL,
	lang char(2) NOT NULL,
	description text NOT NULL,
	actions text NOT NULL,
	recomendations text NOT NULL,
	measuresTaken text NOT NULL,
	PRIMARY KEY (id, lang)
);

CREATE TABLE PostalAddress (
	id SERIAL PRIMARY KEY
);

CREATE TABLE PostalAddressTranslation (
	id integer REFERENCES PostalAddress (id) NOT NULL,
	lang char(2) NOT NULL,
	addressLocality text,
	addressRegion text,
	addressCountry text,
	PRIMARY KEY (id, lang)
);

CREATE TABLE AwardDisclosure (
	id SERIAL PRIMARY KEY,
	organization integer REFERENCES GovernmentOrganization (id) NOT NULL,
	awardDate date NOT NULL,
	location integer REFERENCES PostalAddress (id) NOT NULL,
	total money NOT NULL,
	expiryDate date NOT NULL
);

CREATE TABLE AwardDisclosureTranslation (
	id integer REFERENCES AwardDisclosure (id) NOT NULL,
	lang char(2) NOT NULL,
	recipient text NOT NULL,
	awardType text NOT NULL,
	purpose text NOT NULL,
	comments text NOT NULL,
	PRIMARY KEY (id, lang)
);

CREATE TABLE Person (
	id SERIAL PRIMARY KEY,
	worksFor integer REFERENCES GovernmentOrganization (id) NOT NULL,
	givenName text NOT NULL,
	additionalName text,
	familyName text NOT NULL,
	jobTitle text NOT NULL,
	currentEmployee boolean NOT NULL,
	ministerialEmployee boolean NOT NULL
);

CREATE TABLE TravelDisclosure (
	id SERIAL PRIMARY KEY,
	startDate date NOT NULL,
	endDate date NOT NULL,
	airFare money NOT NULL,
	otherTransportation money NOT NULL,
	accomodations money NOT NULL,
	mealsIncidentals money NOT NULL,
	other money NOT NULL,
	total money NOT NULL,
	expiryDate date NOT NULL
);

CREATE TABLE TravelDisclosureTranslation (
	id integer REFERENCES TravelDisclosure (id) NOT NULL,
	lang char(2) NOT NULL,
	purpose text NOT NULL,
	PRIMARY KEY (id, lang)
);

CREATE TABLE TravelAddress (
	travel integer REFERENCES TravelDisclosure (id) NOT NULL,
	address integer REFERENCES PostalAddress (id) NOT NULL,
	PRIMARY KEY (travel, address)
);

CREATE TABLE HospitalityDisclosure (
	id SERIAL PRIMARY KEY,
	startDate date NOT NULL,
	endDate date NOT NULL,
	employees integer NOT NULL,
	guests integer NOT NULL,
	location integer REFERENCES PostalAddress (id),
	total money NOT NULL,
	expiryDate date NOT NULL
);

CREATE TABLE HospitalityDisclosureTranslation (
	id integer REFERENCES HospitalityDisclosure (id) NOT NULL,
	lang char(2) NOT NULL,
	description text NOT NULL,
	PRIMARY KEY (id, lang)
);
