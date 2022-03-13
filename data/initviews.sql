CREATE OR REPLACE VIEW angajat_detaliat AS
    SELECT 
        a.id_angajat AS id_angajat,
        a.nume AS nume,
        a.prenume AS prenume,
        a.nr_telefon AS nr_telefon,
        a.email AS email,
        a.data_nasterii AS data_nasterii,
        f.denumire AS functie,
        f.cod_functie AS cod_functie,
        aer.nume AS aeroport,
        aer.id_aeroport AS id_aeroport,
        aer.oras AS oras,
        aer.tara AS tara
    FROM
        angajat a
            JOIN
        functie f ON a.cod_functie = f.cod_functie
            JOIN
        aeroport aer ON a.id_aeroport = aer.id_aeroport;

CREATE OR REPLACE VIEW angajati_per_aeroport AS
    SELECT 
        aer.id_aeroport,
        aer.nume,
        COUNT(a.id_angajat) AS nr_angajati
    FROM
        aeroport aer
            LEFT JOIN
        angajat a ON a.id_aeroport = aer.id_aeroport
    GROUP BY id_aeroport;