# Explication des choix 

Nous avons choisi de remplacer la table entrée par une table nommée dossier dans laquelle on ajoute un attribut entree de type JSON.  

Cette nouvelle implémentation nous permet de gérer les différentes entrées. En effet, une entrée peut contenir plusieurs types de saisies.  
Cela nous permet d'obtenir plus de flexibilité pour des entrées car celles-ci n'impose pas de compléter l'ensemble des attributs.

Notre JSON sera de la forme :
```json
{
    "saisie" :
    "taille" :
    "poids" :
    "resultat_analyse" :
    "procedure" :
    "description_procedure" :
    "observation" :
}
```

Nous avons donc modifié notre UML en conséquence en supprimant la table Observation qui sera un attribut dans le table Dossier et en reliant Dossier à Personnel, à Animal et à Traitement puisque que Observation était associée à Personnel et Entree était associée à Animal et à Traitement. On obtient donc la table suivante : 

```SQL
CREATE TABLE Dossier(
		entree JSON,
		id_dossier INTEGER,
		id_animal INTEGER,
		id_personnel INTEGER,
		FOREIGN KEY (id_personnel) REFERENCES Personnel(id_personnel),
        FOREIGN KEY (id_animal) REFERENCES Animal(id_animal),
        PRIMARY KEY (id_dossier),
);
```

Voici un exemple d'insertion d'une entrée dans la base : 

```SQL
INSERT INTO Dossier VALUES (
    2, 1, 3,
    '[
        {
            "saisie" : "2023-01-13 14:15:56"
            "taille" : "1.5"
            "poids" : "32"
            "resultat_analyse" : "Aucun probleme particulier"
            "procedure" : "prélèvement sanguin"
            "description_procedure" : "prelevement sanguin a froid et analyse sanguine"
            "observation" : "RAS"
        }
    ]'
);
```

Nous remarquons que le JSON nous permet d'économiser une table et d'obtenir plus de flexibilité dans les insertions des informations d'un dossier, cependant il présente plusieurs désavantages. Par exemple, il n'y a pas de contrôle sur la cohérence des informations saisies (fautes de frappe, informations erronées,...).

