# Projet Véto : MLD

## Noms : SAVARY Tobias, SCHENTEN William, ASSAF Nora, BLONDY Marie-Herminie, CHESNAIS Zoe
 



***Client***(
        #id_client : int, 
        nom : string,
        prenom : string,
        date de naissance : date,
        adresse : string,
        numero de telephone : string)  
        **AVEC**  
        **INTERSECTION** (**PROJECTION**(Client, id_client), **PROJECTION**(Personnel, id_personnel)) == {}  
On utilise un héritage par classe fille car la classe mère Personne est abstraite. 



***Veterinaire***(
    #id_personnel=>Personnel
    )  
    **AVEC**  
    **INTERSECTION** (**PROJECTION**(Veterinaire, id_personnel), **PROJECTION**(Assistant, id_personnel)) == {}
On utilise un héritage par référence car la classe mère Personnel n'est pas abstraite et l'héritage est exclusif.  


***Assistant***(
        #id_personnel=>Personnel)  
        **AVEC**  
        **INTERSECTION** (**PROJECTION**(Veterinaire, id_personnel), **PROJECTION**(Assistant, id_personnel)) == {}  
On utilise un héritage par référence car la classe mère Personnel n'est pas abstraite et l'héritage est exclusif.  


***Personnel***(
    #id_personnel : int, 
    nom : string,
    prenom : string,
    date de naissance : date,
    adresse : string,
    numero de telephone : string)  
    **AVEC**  
    **INTERSECTION** (**PROJECTION**(Personnel, id_personnel), **PROJECTION**(Client, id_client)) == {}  
On utilise un héritage par classe fille car la classe mère Personne est abstraite. 


***Animal***(
        #id_animal:int,
        nom:string, 
        date_de_naissance:date, 
        num_puce: int, 
        passeport: int,
        type => Espece,
        )  
        **AVEC**   
        date_de_naissance peut être année ou **NULL**,  
        type **NOT NULL**,  
        **PROJECTION**(Animal, type) = **PROJECTION**(Espece, type)  


***AssocAnimalClient***(
        #id_client=> Client,
        #id_animal=>Animal,
        date_debut : date,
        date_fin : date)  
        **AVEC**   
        **PROJECTION**(Client, id_client) = **PROJECTION**(AssocAnimalClient,  id_client) **AND**  
        **PROJECTION**(Animal, id_animal) =**PROJECTION**(AssocAnimalClient,  id_animal)  


***AssocAnimalVeterinaire***(
        #id_personnel=> Veterinaire,
        #id_animal=>Animal,
        date_debut : date,
        date_fin : date)  
        **AVEC**   
        **PROJECTION**(Veterinaire, id_personnel) = **PROJECTION**(AssocAnimalClient,  id_client) **AND**  
        **PROJECTION**(Animal, id_animal) =**PROJECTION**(AssocAnimalClient,  id_animal)  


***Entree***(
        #saisie : timestamp,
        #id_animal=>Animal,
        taille:float, 
        poids:float, 
        resultat_analyse:string, 
        procedure: string,  
        description_procedure:string
        id_observation => Observation
        )  
        **AVEC**  
        id_observation **UNIQUE**  
        **PROJECTION**(Entree, id_animal) = **PROJECTION**(Animal, id_animal) 


***Observation***(
    #id_observation : int,
    observation : string,
    id_personnel => Personnel
    )  
    **AVEC**  
     id_personnel **NOT NULL** **AND**  
    **Projection**(Personnel, id_personnel) = **PROJECTION**(Observation, id_personnel) 


***Traitement***(
            #id_traitement : int,
            date_debut : date, 
            date_fin : date)  

***Medicament***(
        #nom_molecule:string,
        description_effet:string )

***AssocTraitementMedicament***(
    #nom_molecule=>Medicament,
    #id_traitement=>Traitement,  
    quantite : int)  
    **AVEC**  
    **PROJECTION**(Medicament, nom_molecule) = **PROJECTION**(AssocTraitementMedicament, nom_molecule) **AND**  **PROJECTION**(Traitement, id_traitement) = **PROJECTION**(AssocTraitementMedicament, id_traitement) **AND**  
    nom_molecule **NOT NULL**  

***AssocTraitementEntree***(
    #saisie => Entree,
    #id_animal=>Entree
    #id_traitement=>Traitement)  
    **AVEC**  
    **PROJECTION**(Entree, saisie) = **PROJECTION**(AssocTraitementEntree, saisie) **AND**  
    **PROJECTION**(Entree, id_animal) = **PROJECTION**(AssocTraitementEntree, id_animal) **AND**  
    **PROJECTION**(Traitement, id_traitement) = **PROJECTION**(AssocTraitementEntree, id_traitement)   

***AssocTraitementVeterinaire***(
    #id_personnel=>Veterinaire,
    #id_traitement=>Traitement)  
    **AVEC**  
    **PROJECTION**(Veterinaire, id_personnel) = **PROJECTION**(AssocTraitementVeterinaire, id_personnel) **AND**   
    **PROJECTION**(Traitement, id_traitement) = **PROJECTION**(AssocTraitementVeterinaire, id_traitement)   


***Espece***( #type : {félins, canidés, reptiles, rongeurs, oiseaux, autres} )

***AssocEspecePersonnel***(
    #id_personnel=>Personnel,
    #type=>Espece)
    **AVEC**  
    **PROJECTION**(Peronnel, id_personnel) = **PROJECTION**(AssocEspecePersonnel, id_personnel) **AND**  
     **PROJECTION**(Espece, type) = **PROJECTION**(AssocEspecePersonnel, type)  


***AssocEspeceMedicament***(
    #nom_molecule=>Medicament,
    #type=>Espece)
    **AVEC**  
    **PROJECTION**(Medicament, nom_molecule) = **PROJECTION**(AssocEspeceMedicament, nom_molecule) **AND**   
    **PROJECTION**(Espece, type) = **PROJECTION**(AssocEspeceMedicament, type)  