## TP 0 : Prise en main de CUDA

### Installation
Si vous avez un ordinateur avec un carte graphique nvidia, pour installer CUDA :
1. [Guide d'installation de CUDA pour Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#abstract)
2. [Guide d'installation de CUDA pour windows](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/index.html)
3. [Installer CUDA Toolkit](https://developer.nvidia.com/cuda-downloads)

### Acceder a un serveur GPU
Sinon, il y à trois machine a luminy equipées d'une Nvidia Tesla P100.
Pour y acceder :
1. Se connecter au sas: ssh -p 8012 -o PreferredAuthentications=password -o PubkeyAuthentication=no [USER@sas.luminy.univ-amu.fr](mailto:USER@sas.luminy.univ-amu.fr)
    **Attention : IP banni après trois échecs de connexion**
1. Se connecter à un des 3 serveurs ayant une Nvidia P100 : ssh -p 8012 gt-X (X allant de 0 à 3)

### A propos du code
Le répertoire comporte 2 fichiers exercice01.cu et exercice02.cu. Ces deux fichiers comporte les instructions que vous devez suivre pour finir le TP.
Un makefile est fourni avec le code vous permettant de le compiler et de l'executer. 

Pour compiler un exercice, il vous suffit de changer la ligne suivante par le nom du fichier correspondant:
```bash
EXAMPLE=exercise01
```

### Exercice 1
Vous travaillerez sur le fichier exercice01.cu
Le but de cet exercice est double. 
1. Implementer les concepts de base de CUDA vue en CM. 
2. Avoir un aperçsu de la puissance de calcul du GPU comparés au CPU.

Pour cet exercice, vous allez devoir implementer un opésration de multiplication entre deux matrices.

![figure.jpeg]

Vous travaillerez avec des matrices carréses, n = p = w = q.

#### 1ere Partie
Les matrices sont de taille NxM ou N = M = 16 (definit dans le main)
Le nombre de threads par blocs est défini à 256, donc les blocs sont de dimensions 16x16. La grille est de dimension N/block_with x M/block_with = 1x1.

1. Completer la partie Host de programme (main)
2. Pour les dimensions des grilles et blocs
3. Completer la fonction MatMuLKernel permettant de multiplier deux matrices entre-elles sur le GPU
4. Completer la fonction MatMulCPU permettant de multiplier deux matrices entre-elles sur CPU
5. Executer le programme

Une fonction **validate** est implementé permettant de verifier que la sortie du kernel soit la même que la sortie de las fonction CPU sont les mêmesss.

### 2eme partie

Mesure des temps d'execution.

Une structure permettant de mesurer le temps d'execution d'une partie de code a été implementer dans utils.h

```c
struct event_pair{
 cudaEvent_t start;
 cudaEvent_t end;
};
```

1. Creer la variable **event_pair timer** dans la fonction main.

Voici un exemple de comment mesurer le temps d'execution d'une partie de code :
```c
start_timer(&timer);
Kernel << <blocksPerGrid, threadsPerBlock >> >(d_a, d_b, d_c);
checkCUDAError("CUDA kernel");
stop_timer(&timer,"Matrix multiplication on GPU");
```

Stop timer affichera en sortie le temps d'execution du kernel.

2. Mesurer le temps d'execution de MatMulKernel et MatMulCPU.

Le GPU est-il plus rapide ? A votre avis pourquoi n'y a t-il pas un grand ecart de temps d'execution entre le CPU et le GPU ?

3. Essayer à nouveau en modifiant un peu le code :
	1. Changez les valeurs de N et M a 2048

Que se passe t'il ?

## Exercice 2

Un fichier texte a ete encrypte en utilisant l'encryption affine.
![[form1.png]]

La fonction de decryption affine est defini comme suit :
![[form2.png]]

Dans le code, les valeurs de a sont donnee, A = 15, B = 27, M = 128, $A^{-1}$ = 111
x est un element de notre fichier encrypte.

Il suffit d'appliquer D(x) pour chaque charactere du fichier (liste de 1024 charactere).
Une fonction est deja ecrite permettant de recuperer le contenu du fichier dans **h_input**.

1. Completer la fonction main en utilisant un seul bloc de N (1024) threads
	1. Les etapes a effectuer sont ecrit dans le code.
2. Completer le kernel **affine_decrypt**
3. Modifier la fonction main afin d'utiliser 8 bloc
4. Completer le kernel **affine_decrypt_multiblock**



