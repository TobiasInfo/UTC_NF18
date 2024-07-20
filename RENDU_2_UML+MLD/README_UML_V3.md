# Explication rendu 1

Dans notre modèle UML, nous avons modifié l'héritage associé à la classe abstraite "Personne" pour indiquer qu'il est bien exclusif. Nous avons aussi indiquer que la classe "Personne" est bien une classe abstraite car elle ne peut pas être directement instanciée dans notre cas, une personne est forcément un client ou un membre du personnel. Dans le MLD, nous avons donc décidé d'effectuer un héritage par les classes filles.

Nous avons décidé d’instancier une classe véto même si nous pouvons définir un vétérinaire dans la classe Personnel  car nous avons décidé de faire la distinction entre les anciens vétérinaires (potentiellement dans une autre clinique) d’un animal actuellement suivit dans la clinique et les vétérinaires travaillant actuellement dans la clinique.

De même, nous avons décidé d’instancier deux tables “Client” et “Propriétaire” car nous avons choisi de faire la distinction entre le client qui est le propriétaire actuel de l’animal et la liste des anciens propriétaires de l’animal.

Nous avons aussi décidé de rassembler les tables “Animaux_domestiques” et “Espece” car la table “Animaux_domestiques” ne possédait aucune relation avec d'autres tables.

Nous avons les attributs  taille, poids, resultat_analyse, observation, véto_observation, procedure, description_procedure dans les tables “Entrée” et “Dossier” car la table “Entrée” permet de savoir quel attribut a été modifié dans la table “Dossier”. En effet, la table Entrée permet de connaire la date et l'heure de modification d'un attribut précis.


 Nous avons remarqué que le nom de la table traitement faisais en fait référence aux noms des médicaments qui pouvaient être attribuées. Nous avons donc choisis de le supprimer et utiliserons une clef artificiel lors de l'élaboration du MLD.
