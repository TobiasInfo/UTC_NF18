# Projet Véto : MLD

## Noms : SAVARY Tobias, SCHENTEN William, ASSAF Nora, BLONDY Marie-Herminie, CHESNAIS Zoe
 

***Proprio*** (#nom:string,
            periode_debut:date, 
            periode_fin:date,
            #id_animal=>Animal
            )
        **AVEC** id_animal **NOT NULL** et 
        **PROJECTION**(Animal, id_animal) = **PROJECTION**(Proprio, id_animal) 

***Veto***( #nom:string, 
        periode_debut:date, 
        periode_fin: date,
        #id_animal=>Animal
        ) 
        **AVEC** id_animal **NOT NULL** et 
        **PROJECTION**(Animal, id_animal) = **PROJECTION**(Veto, id_animal) 

***Client***(#id_client : int, 
        nom : string,
        prenom : string,
        date de naissance : date,
        adresse : string,
        numero de telephone : string)
        **AVEC** 
        **INTERSECTION** (**PROJECTION**(client, id_client), **PROJECTION**(personnel, id_personnel)) == {}

***Animal***(#id_animal:int,
        nom:string, 
        date_de_naissance:date, 
        num_puce: int, 
        passeport: int,
        #type => Espece,
        #id_client => Client
        )
        **AVEC** date_de_naissance peut être année ou **NULL**,
        type **NOT NULL**,
        **PROJECTION**(Animal, type) = **PROJECTION**(Espece, type),
        id_client **NOT NULL** et 
        **PROJECTION**(Animal, id_client) = **PROJECTION**(client, id_client) 


***Espece***( #type : {félins, canidés, reptiles, rongeurs, oiseaux, autres} )

***Personnel***(#id_personnel : int, 
            nom : string,
            prenom : string,
            date de naissance : date,
            adresse : string,
            numero de telephone : string
            poste : {vétérinaire, assistant})
            **AVEC** 
            **INTERSECTION** (**PROJECTION**(client, id_client), **PROJECTION**(personnel, id_personnel)) == {}


***Medicament***(#nom_molecule:string,                      description_effet:string )

***Traitement***(#id:int,
            datedebut:date, 
            duree:date, 
            quantité:int,
            personnel=>Personnel,
            #id_dossier=>Dossier)
            **AVEC** personnel **UNIQUE**, id_dossier **NOT NULL** et **PROJECTION**(Traitement, id_dossier) = **PROJECTION**(Dossier, id_dossier) 

***Dossier***(
        #id_dossier : int,
        taille:int, 
        poids:int, 
        resultat_analyse:string, 
        observation: string, 
        véto_observation:string, 
        procedure: string,              description_procedure:string,
        id_animal=>Animal)
        **AVEC** animal **UNIQUE**

***Entree***(#heure_saisie : time, 
        #id_dossier=>Dossier,
        date_saisie : date,
        type : {taille, poids, resultat_analyse, observation, véto_observation, procedure, description_procedure} 
        )
        **AVEC** id_donner **NOT NULL** et **PROJECTION**(Entree, id_dossier) = **PROJECTION**(Dossier, id_dossier) 

***AssocMedicamentEspece***(#nom_molécule=>Medicament,#type=>Espece)
**AVEC** **PROJECTION**(Medicament, nom_molécule) = **PROJECTION**(AssocMedicamentEspece, nom_molécule) **AND**  **PROJECTION**(Espece, type) = **PROJECTION**(AssocMedicamentEspece, type)

***AssocPersonnelEspece***(#id_personnel=>Personnel,#type=>Espece)
**AVEC** **PROJECTION**(Personnel, id_personnel) = **PROJECTION**(AssocPersonnelEspece, id_personnel) **AND**  **PROJECTION**(Espece, type) = **PROJECTION**(AssocPersonnelEspece, type)


***AssocTraitementMedicament***(#nom_molécule=>Médicaments,#traitement=>Traitement)
**AVEC** **PROJECTION**(Medicament, nom_molécule) = **PROJECTION**(AssocTraitementMedicament, nom_molécule) **AND**  **PROJECTION**(Traitement, id) = **PROJECTION**(AssocTraitementMedicament, traitement)
