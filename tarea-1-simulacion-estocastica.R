#pregunta 1----

#1a----
#install.packages("rgl")
x<-seq(0,3,length=30)
y<-seq(0,2,length=30)
f<-function(x,y) x*y^2*sqrt(x^2+y^3)
library(rgl)
z<-outer(x, y,f)
library(rgl)
ecuacion <- expression(z == x*y^2*sqrt(x^2+y^3))
persp(x,y,z,theta = 45, phi = 0, col = "orange",sub = ecuacion, main = "Gráfico de la expresión",
      col.main="blue")

        

#1b----
#esta en informe

#1c----
#crando funcion
fu <- function(n){
  k <- runif(n,0,1)
  j <- runif(n,0,1)
  m <- NULL
  
  for (i in 1:n){
    m[i] <-72*(k[i])^(2)*j[i]*sqrt((3*j[i])^2+(2*k[i])^3) 
  }
  valor <- mean(m)
  return(valor)
  
}

#install.packages("pracma")
#1d----
library(pracma)
integral2(f,0,3,0,2,sector = FALSE)

#con 10^2
n <- 10^2
fu(n)

#con 10^3
n <- 10^3
fu(n)



#con 10^4
n <- 10^4
fu(n)


#a medida que se se usan mas variables uniformes mejora la aproximación




#######################################################################################
#2----

#2a

#esta en informe

#2b

v <- NULL
montecarlo <- function(u){
  x1 <- log(u/(1-u))
  dx1 <- 1/(u*(1-u))
  v <- exp(-x1^2/2)*(exp(-(x1-3)^2/2)+exp(-(x1-6)^2/2))*dx1/sqrt(2*pi)
  return(v)
}

aprox <- function(n){
  resultado<- NULL
  u <- runif(n,0,1)
  resultado <- mean(montecarlo(u))
  return(resultado)
}
#muestra
estimacion <- function(n) 
{ 
  est <- NULL
  for(i in 1:n)
  {
    est[i] <- aprox(i)
  }
  return(est)
}

#2c

n <- 10^4

x <- seq(1,n)

#Se grafica como se aproxima la estimacion dependiendo de la muestra
plot(x, estimacion(n), type = "l", xlab = "Tamaño de muestra", ylab = "Valor de la estimación", 
     main = "Estimación de E[h(X)] cuando la muestra aumenta")

abline(h= 0.074 , col= "red", lwd=3)
legend(x = "topright",        
       legend = c("y=0.074"), 
       lty = c(1),         
       col = c("red"),       
       lwd = 2,
       box.lty = 0)

#2d
n <- 10^4
real <- rep(0.074,n)
error <- abs(real-estimacion(n))
plot(error, type = "l" , col="blue" ,xlab = "Tamaño de muestra", ylab = "Error", 
     main = "Valor del error cuando aumenta la muestra")

#a medida que aumenta la muestra el error es cada vez menor





##########################################################################################
#3----

# a,b y c estan en documento

#3d
g <- function(n,a,b){
  x <- NULL
  u <- runif(n,0,1)
  for (i in 1:n){
    if (u[i]<0.5){
      c <- 2*a+(b-a)*sqrt(2*u[i])
    }else{
      c <- 2*b+(a-b)*sqrt(2*(1-u[i]))
    }
    x[i] <- c
  }
  return(x)
}


#e
n <- 10^4
b <- 5
a <- 0
x <- g(n,a,b)


hist(x,freq=FALSE, col="darkgoldenrod1", ylim = c(0,0.2),xlab = "Valores",ylab = "Probabilidades", main = "Histograma de frecuencia relativa de X",
)
legend(x = "topright",        
       legend = c("f(x)"), 
       lty = c(1),         
       col = c("blue"),       
       lwd = 2,
       box.lty = 0)
fe2 <- function(x){
  return((x-2*a)/(b-a)^2)}

fe3 <- function(x){
  return((2*b-x)/(b-a)^2)
}


curve(fe2(x),from=0 ,to=5,add = TRUE, col= "blue", lwd = 3)
curve(fe3(x),from=5 ,to=10,add = TRUE , col = "blue", lwd = 3)






























