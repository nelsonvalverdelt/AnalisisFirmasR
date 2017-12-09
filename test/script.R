library(png)

#setwd("test")
download.file("http://webapidisi.azurewebsites.net/api/Firmas?type=csv", destfile = "Firmas.csv")
Firmas <- read.csv("Firmas.csv")
frameFirmas <- data.frame(Firmas);

class(dim(frameFirmas[8])[1]) # Miramos el tipo de datos que nos retorna 
cantFirmas <- dim(frameFirmas[8])[1] #obtenemos el dato 1 de la columna 8
i <- 1
dnis <- unique(frameFirmas[2]) # eliminamos los dnis repetidos

cantDnis <- dim(dnis)[1]
contadorDnis <- 1

if (!dir.exists("Firmas")) {
    dir.create("Firmas")
}
setwd("Firmas")

while (contadorDnis <= 2) {
        if (!dir.exists(as.character(dnis[contadorDnis, 1]))) {
            dir.create(as.character(dnis[contadorDnis, 1]))
        }
    contadorDnis = contadorDnis  + 1
}
setwd("../")
getwd()

while (i <= cantFirmas) {
    parametrosFirma <- c("Firmas/", frameFirmas[i, 2], "/firma", i, ".png")
    nombreFirma <- paste(parametrosFirma, sep = "", collapse = "")
    if (!file.exists(nombreFirma)) {
        download.file(as.character(frameFirmas[i, 8]), nombreFirma, mode = "wb")
    }

    i = i + 1
}

getwd()

primeraImagen <- readPNG("Firmas/72189432/firma1.png", TRUE);
segundaImagen <- readPNG("Firmas/72189432/firma2.png", TRUE);

dim(primeraImagen)
dim(segundaImagen)

y <- 1
x <- 1


#Reemplazamos los datos NA de las columnas
while (x <= 300) {
    while (y <= 720) {
        primeraImagen[x, y][is.na(primeraImagen[x, y])] <- 0
        segundaImagen[x, y][is.na(segundaImagen[x, y])] <- 0
        y = y + 1
    }
    x = x + 1
    y = 1
}

# Seteamos los valores X y Y a 1 para el loop
y <- 1
x <- 1
coincidencias <- 0
diferentes <- 0


while (x <= 300) {

    while (y <= 720) {
        
        if(primeraImagen[x, y] == 0 && segundaImagen[x, y] == 0) {
            primeraImagen[x,y] <- NA
            segundaImagen[x,y] <- NA
        } else {
                if (primeraImagen[x, y] == segundaImagen[x, y]) {
                    primeraImagen[x, y] <- TRUE
                    segundaImagen[x, y] <- TRUE
                    coincidencias <- coincidencias + 1
                } else {
                    primeraImagen[x, y] <- FALSE
                    segundaImagen[x, y] <- FALSE
                    diferentes <- diferentes + 1
                }
        }
        y = y + 1
    }
    x = x + 1
    y = 1
}
total <- coincidencias + diferentes
porcentajeCoincidencias <- 100 * (coincidencias / total)
porcentajeDiferencias <- 100 * (diferentes / total)
porcentajeCoincidencias
porcentajeDiferencias

diferentes
primeraImagen[300,]
segundaImagen[300,]
#warnings()

