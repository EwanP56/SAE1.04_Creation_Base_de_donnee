----- Initialisation du la base de données

drop schema if exists transmusicales cascade;
create schema transmusicales;
set schema 'transmusicales';

----- Table _groupe_artiste

CREATE TABLE _groupe_artiste(
    id_grp_art VARCHAR(10)             NOT NULL,
    nom_grp_art VARCHAR(30)         NOT NULL,
    site_web VARCHAR(255)           NOT NULL,
    sort_disco INTEGER              NOT NULL,
    debut INTEGER                   NOT NULL,
    a_pour_origine VARCHAR(30)      NOT NULL,
    CONSTRAINT _groupe_artiste_pk PRIMARY KEY(id_groupe_artiste)
);


----- Table _annee

CREATE TABLE _annee (
    an INTEGER                      NOT NULL,
    CONSTRAINT _annee_pk PRIMARY KEY(an)
);


----- Table _pays

CREATE TABLE _pays (
    nom_p VARCHAR(50)               NOT NULL,
    CONSTRAINT _pays_pk PRIMARY KEY(nom_p)
);


----- Table _ville

CREATE TABLE _ville (
    nom_v VARCHAR(50)               NOT NULL,
    se_situe VARCHAR(50)            NOT NULL,
    CONSTRAINT _ville_pk PRIMARY KEY(nom_v)
);


----- Table _edition

CREATE TABLE _edition (
    nom_edit VARCHAR(50)            NOT NULL,
    an_edit INTEGER                 NOT NULL,
    CONSTRAINT _edition_pk PRIMARY KEY(nom_edition)
);


----- Table _formation

CREATE TABLE _formation (
    libelle_formation VARCHAR(50)   NOT NULL,
    CONSTRAINT _formation_pk PRIMARY KEY(libelle_formation)
);


----- Table _concert

CREATE TABLE _concert (
    no_concert CHAR(10)             NOT NULL,
    titre VARCHAR(50)               NOT NULL, 
    resume VARCHAR                  NOT NULL,
    duree TIME                      NOT NULL,
    tarif FLOAT                     NOT NULL,
    est_de VARCHAR(20)              NOT NULL,   
    CONSTRAINT _concert_pk PRIMARY KEY(no_concert)
);


----- Table _representation

CREATE TABLE _representation (
    num_rep VARCHAR(10)             NOT NULL,
    heure TIME                      NOT NULL,
    date_rep DATE                   NOT NULL,
    jouee_par VARCHAR(10)           NOT NULL,
    a_lieu_dans VARCHAR(10)         NOT NULL,  
    correspond_a VARCHAR(10)        NOT NULL,
    CONSTRAINT _representation_pk PRIMARY KEY (num_repr)
);


----- Table _lieu

CREATE TABLE _lieu (
    id_lieu VARCHAR(10)             NOT NULL,
    nom_lieu VARCHAR(50)            NOT NULL,
    accesPMR BOOLEAN                NOT NULL,
    capacite_max INTEGER            NOT NULL,
    type_lieu VARCHAR(20)           NOT NULL,
    dans VARCHAR(50)                NOT NULL,
    CONSTRAINT _lieu_pk PRIMARY KEY (id_lieu)

);


----- Table _type_musique

CREATE TABLE _type_musique (
    type_m VARCHAR(20)             NOT NULL,
    CONSTRAINT _type_musique_pk PRIMARY KEY (type_m)
);


-------------------- Multiplicité --------------------


----- a pour >

create table _a_pour (
    id_grp_art VARCHAR(10)          NOT NULL,
    libelle_formation VARCHAR       NOT NULL,
    CONSTRAINT _a_pour_pk PRIMARY KEY (id_grp_art, libelle_formation),
    CONSTRAINT _a_pour_fk_1 FOREIGN KEY (id_grp_art)
    REFERENCES _groupe_artiste(id_grp_art),
    CONSTRAINT _a_pour_fk_2 FOREIGN KEY (libelle_formation)
    REFERENCES _formation(libelle_formation)
) ;


----- se deroule

create table _se_deroule (
    nom_edition VARCHAR(50)         NOT NULL,
    no_concert VARCHAR(10)          NOT NULL,
    CONSTRAINT _se_deroule_pk PRIMARY KEY (nom_edition, no_concert),
    CONSTRAINT _se_deroule_fk_1 FOREIGN KEY (nom_edition)
    REFERENCES _edition(nom_edition),
    CONSTRAINT _se_deroule_fk_2 FOREIGN KEY (no_concert)
    REFERENCES _concert(no_concert)
);


----- type principal

create table _type_principal (
    id_grp_art VARCHAR(10)          NOT NULL,
    type_m VARCHAR(20)              NOT NULL,
    CONSTRAINT _type_principal_pk PRIMARY KEY (id_grp_art, type_m),
    CONSTRAINT _type_principal_fk_1 FOREIGN KEY (id_grp_art)
        REFERENCES _groupe_artiste(id_grp_art),
    CONSTRAINT _type_principal_fk_2 FOREIGN KEY (type_m)
        REFERENCES _type_musique(type_m)
);


----- type principal

create table _type_ponctuel (
    id_grp_art VARCHAR(10)          NOT NULL,
    type_m VARCHAR(20)              NOT NULL,
    CONSTRAINT _type_ponctuel_pk PRIMARY KEY (id_grp_art, type_m),
    CONSTRAINT _type_ponctuel_fk_1 FOREIGN KEY (id_grp_art)
        REFERENCES _groupe_artiste(id_grp_art),
    CONSTRAINT _type_ponctuel_fk_2 FOREIGN KEY (type_m)
        REFERENCES _type_musique(type_m)
);



----- Clé étrangère

CONSTRAINT _groupe_artiste_fk_annee FOREIGN KEY (sort_disco)
    REFERENCES _annee(an),

CONSTRAINT _groupe_artiste_fk_annee FOREIGN KEY (debut)
    REFERENCES _annee(an),

CONSTRAINT _groupe_artiste_fk_pays FOREIGN KEY (a_pour_origine)
    REFERENCES _pays(nom_p),

CONSTRAINT _ville_fk_pays FOREIGN KEY (se_situe)
    REFERENCES _pays(nom_p),

CONSTRAINT _edition_fk_annee FOREIGN KEY (an_edit)
    REFERENCES _annee(an),

CONSTRAINT _concert_fk_type_musique FOREIGN KEY (est_de)
    REFERENCES _type_musique(type_m),

CONSTRAINT _representation_fk_groupe_artiste FOREIGN KEY (jouee_par)
    REFERENCES _groupe_artiste(id_grp_art),

CONSTRAINT _representation_fk_lieu FOREIGN KEY (a_lieu_dans)
    REFERENCES _lieu(id_lieu),

CONSTRAINT _representation_fk_concert FOREIGN KEY (correspond_a)
    REFERENCES _concert(no_concert),

CONSTRAINT _lieu_fk_ville FOREIGN KEY (dans)
    REFERENCES _ville(nom_v);