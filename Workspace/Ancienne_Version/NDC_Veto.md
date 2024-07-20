# Note de Clarification - Exercice Clinique vétérinaire

Gestionnaire de clinique vétérinaire. Ce gestionnaire doit prendre en compte la gestion : 

- Des patients(animaux)
- Des clients
- Du personnel soignant
- Des médicaments

Client + Personnel: -Nom
                    -Prénom 
                    -Date de naissance
                    -Adresse
                    -Numéro de téléphone

Personnel : -Poste {vétérinaire, assistant}
            -Spécialité -> espèces animales les mieux traitées
            -Ne peuvent pas avoir d'animaux de companie suvie dans la clinique

Animaux domestiques : -Taille {petite, moyenne}
                      -Type {félins, canidés, reptiles, rongeurs, oiseaux, Autres}
                        Autres correspond à tous les animaux qui ne sont pas décrits dans type.

Animal : -Nom
         -Espèce
         -Date de naissance (peut être juste une année ou inconnu)
         -Numéro de puce (S'il en a une)
         -Numéro de passeport (S'il en a un)
         -Liste de ses propriétaires
         -Liste des vétérinaires


Liste des propriétaires : -Période avec l'animal 
                          -Nom

Liste des vétérinaires: -Noms
                        -Date/période

Dossier médical : -Animal auxquel il se réfère
                  -Taille
                  -Poids
                  -Traitement
                  -Résultats d'analyse : URL
                  -Observation
                  -Nom de la personne qui a fait l'observation
                  -Description de la procédure réalisée
                  -Date et heure de chaque entrée


Traitement : -Nom
             -Date de début
             -Date de fin
             -durée
             -Quantité par jour / Médicaments prescrits
             -Seul un vétérinaire peut prescrire un traitement

Médicaments : -Nom de la molécule
              -Explication des effets
              -Interdiction sur certaines espèces

Liste des associations:

Medicament est autorise pour Espece (* - *)
proprio a ete proprietaire de Animal (* - 1) 
Personnel est specialise dans Espece (* - *) 
Personnel prescrit Traitement (1 - 1)
veto a suivi Animal (* - 1)
Traitement utilise Medicament (1 - *)
Animal est de type Espece (1 - *)
Animal possède Dossier (1 - 1)
Client  possède Animal (1 - *)
Dossier associe Traitement (1 - *)
Entree compose Dossier (* - 1)

Animaux_domestiques Hérite de  Espece
Client Hérite de  Personne
Personnel Hérite de  Personne

Remarque:
Pour les classes personnes et Entree, nous avons créer des classes abstraite 
car elle contiennent des attributs communs à plusieurs autres classes.
Pour les classes qui ne possèdent pas de clé, nous avons fait le choix d'Utiliser
des clés artificielles lors de l'implémentation.