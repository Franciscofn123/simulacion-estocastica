#######tarea 3


#1
#a
#se definen la posteriori en el informe

#b
set.seed(2022)
x <- rlogis(n = 20, location = 5, scale =6)
#como location=5, entonces la media es 5
# y como scale=6, entonces la desviacion estandar es 6


n <- 20

#c

l <- function(alpha,beta){
  y <- sum(log(dlogis(x, alpha, beta)))
  return(y)
}

f_aux <- function(c0)
{
  return(-l(c0[1], c0[2]))
}
c0 <- c(1,1)
minimo <- optim(c0, f_aux, hessian = T)

x_opt <- minimo$par
H_opt <- -minimo$hessian

#d


library(mvtnorm)


acept_rech <- function(n, me)
{
  m <- matrix(c(me[1], me[2]), nrow = 2)
  V <- matrix(c(1, 1,
                1, 3), byrow = TRUE, nrow = 2)
  S <- solve(solve(V) - H_opt / 2)
  mu <- S %*% (solve(V) %*% m - H_opt %*% (x_opt / 2))
  f <- function(alpha, beta)
  {
    return(exp(l(alpha, beta)) * dmvnorm(c(alpha, beta), m, V))
  }
  
  g <- function(alpha, beta)
  {
    return(dmvnorm(c(alpha, beta), mu, S))
  }
  
  
  h <- function(theta)
  {
    return(f(theta[1], theta[2])/g(theta[1], theta[2]))
  }
  c <- h(x_opt)
  
  aceptados <- 0
  rechazados <- 0
  simulaciones <- matrix(nrow = n, ncol = 2)
  contador <- 0
  
  while(all(is.na(simulaciones[n, ])))
  {
    y <- rmvnorm(1, mu, S)
    u <- runif(1)
    
    if(u <= (1/c) * h(y))
    {
      contador <- contador + 1
      aceptados <- aceptados + 1
      
      simulaciones[contador, ] <- y
    }
    else
    {
      rechazados <- rechazados + 1
    }
  }
  
  #Calculamos la tasa de aprobación
  tasa_aceptados <- aceptados / (aceptados + rechazados)
  
  #Lo pasamos a porcentaje
  porceentaje_aceptados <- paste0(round(tasa_aceptados * 100, 2), "%")
  
  #Mostramos el porcentaje de aceptados:
  print(sprintf("La tasa de aprobación fue de: %s", porceentaje_aceptados))
  
  #Retornamos la lista pedida
  return(list(muestra = simulaciones, tasa_aprobacion = tasa_aceptados))
}





#e
#con mu=(8,8)
me1 <- matrix(c(8,8), nrow = 2)
t8_1 <- Sys.time()
lista_res1 <- acept_rech(10000, me1)$muestra
t8_2 <- Sys.time()
muestra1 <- lista_res1
(t8_2-t8_1)



#con mu=(10,10)


me2 <- matrix(c(10, 10), nrow = 2)
t10_1 <- Sys.time()
lista_res2 <- acept_rech(10000, me2)$muestra
t10_2 <- Sys.time()
muestra2 <- lista_res2
(t10_2-t10_1)
#con mu=(12,12)

me3 <- matrix(c(12, 12), nrow = 2)
t12_1 <- Sys.time()
lista_res3 <- acept_rech(10000, me3)$muestra
t12_2 <- Sys.time()
muestra3 <- lista_res3
(t8_2-t8_1)

#f
par(mfrow=c(2,2))
hist(muestra1,
     main="Muestra con u= (8,8)",
     ylim = c(0,0.4),
     xlim = c(2,15),
     xlab="x",
     ylab="Densidad",
     prob=TRUE,
     breaks=30,
     col="red")

hist(muestra2,
     main="Muestra con u= (10,10)",
     ylim = c(0,0.4),
     xlim = c(4,15),
     xlab="x",
     ylab="Densidad",
     prob=TRUE,
     breaks=30,
     col="blue")

hist(muestra3,
     main="Muestra con u= (12,12)",
     ylim = c(0,0.4),
     xlim = c(5,18),
     xlab="x",
     ylab="densidad",
     prob=TRUE,
     breaks=30,
     col="green")

#2----
#a

theta <- function(x){
  aux <- x/(1+exp(x)) 
  return(aux)
}




cambio_variable <- function(x){
  aux <- (25*x+25)/(1+exp(5*x+5))
  return(aux)
}

a <- runif(10000)
monte <- mean(cambio_variable(a))


#b
v <- integrate(theta,5,10)$value

#c


fy <- function(y){
  return(exp(-1/2) / (1 + y^2))
}

fz <- function(z){
  return(z + 1)
}
#primero tomando como variable de control Y
U <- runif(10^5)
X <- cambio_variable(U)
Y <- fy(U)

c_y <- -cov(X,Y) / var(Y)

z1 <- X + c_y*(Y - mean(Y))

#Calculamos la simulación mediante la variable de control
(est_y <- mean(z1)) 


#ahora se prueba con z como variable de control



U <- runif(10^5)
X <- cambio_variable(U)
Z <- fz(U)

c_z <- -cov(X,Z) / var(Z)

z2 <- X + c_z*(Z - mean(Z))

#Calculamos la simulación mediante la variable de control
(est_z <- mean(z2)) 


#reduccion de varianza

r_y <- 100*cor(X,Y)^2
r_z <- 100*cor(X,Z)^2

#con z se reduce mucho mas la varianza, puesto que, esta muy correlacionada con X



#d

(error_monte <- 100 * abs(monte - v) / v)
(error_y <- 100 * abs(est_y - v) / v)
(error_z <- 100 * abs(est_z - v) / v)



#f
m <- NULL

for (i in 1:1000){
  a <- runif(10000)
  monte <- mean(cambio_variable(a))
  m[i] <- monte
}
m

q <- NULL

for (i in 1:1000){
  U <- runif(10^5)
  X <- cambio_variable(U)
  Y <- fy(U)
  
  c_y <- -cov(X,Y) / var(Y)
  
  z1 <- X + c_y*(Y - mean(Y))
  
  #Calculamos la simulación mediante la variable de control
  (est_y <- mean(z1)) 
  q[i] <- est_y
}
q

p <- NULL
for (i in 1:1000){
  U <- runif(10^5)
  X <- cambio_variable(U)
  Z <- fz(U)
  
  c_z <- -cov(X,Z) / var(Z)
  
  z2 <- X + c_z*(Z - mean(Z))
  
  #Calculamos la simulación mediante la variable de control
  (est_z <- mean(z2)) 
  p[i] <- est_z
}
p


par(mfrow=c(2,1))
plot(m, type = "l", col = "skyblue", lwd = 4,
     xlab = "Cantidad de estimaciones", ylab = "Valores theta",
     main = "Monte Carlo vs Variable de Control")

# Agregamos a la figura las estimaciones de theta utilizando la variable de control
lines(q, type = "l", lwd = 3, col = "gold")
# Agregamos una leyenda
legend("topright", legend = c("Monte Carlo", "Variable de Control Y"),
       col = c("skyblue", "gold"), lwd = 4:3, lty = 1:1, cex = 0.7)
plot(m, type = "l", col = "skyblue", lwd = 4,
     xlab = "Cantidad de estimaciones", ylab = "Valores theta",
     main = "Monte Carlo vs Variable de Control")
lines(p, type = "l", lwd = 3, col = "lightsalmon1")
legend("topright", legend = c("Monte Carlo", "Variable de Control Y"),
       col = c("skyblue", "lightsalmon1"), lwd = 4:3, lty = 1:1, cex = 0.7)




#3

#a
f<-function(D,x){
  aux<- (2*pi)^(-D/2)*exp(-sum((x)^2)/2)
  return(aux)
}
valores <- function(n,D){
  mu<-NULL
  for(i in 1:n)
  {
    x<-runif(D,-5,5)
    a<-f(D,x)
    mu[i] <- a
  }
  return(list(muestra = mu,estimacion = mean(mu), desv = sd(mu), 
              coef_variacion = sd(mu) / mean(mu)))
  
}


#b

estimacion1<-valores(1000,1)
estimacion1$estimacion

estimacion2<-valores(2000,1)
estimacion2$estimacion

estimacion3<-valores(3000,1)
estimacion3$estimacion

estimacion4<-valores(4000,1)
estimacion4$estimacion

estimacion5<-valores(5000,1)
estimacion5$estimacion

estimacion6<-valores(6000,1)
estimacion6$estimacion

estimacion7<-valores(7000,1)
estimacion7$estimacion

estimacion8<-valores(8000,1)
estimacion8$estimacion

estimacion9<-valores(9000,1)
estimacion9$estimacion

estimacion10<-valores(10000,1)
estimacion10$estimacion




#c
t<-seq(1000,10000,1000)
estimaciones<-c(estimacion1$estimacion,estimacion2$estimacion,estimacion3$estimacion,estimacion4$estimacion,estimacion5$estimacion,estimacion6$estimacion,estimacion7$estimacion,estimacion8$estimacion,estimacion9$estimacion,estimacion10$estimacion)

                
desviacion_estandar<-c(estimacion1$desv ,estimacion2$desv, estimacion3$desv, estimacion4$desv, estimacion5$desv, estimacion6$desv, estimacion7$desv ,estimacion8$desv, estimacion9$desv ,estimacion10$desv)


coeficiente_de_variacion<-c(estimacion1$coef_variacion, estimacion2$coef_variacion, estimacion3$coef_variacion, estimacion4$coef_variacion, estimacion5$coef_variacion ,estimacion6$coef_variacion, estimacion7$coef_variacion, estimacion8$coef_variacion, estimacion9$coef_variacion, estimacion10$coef_variacion)
                            
cbind(t,estimaciones,desviacion_estandar,coeficiente_de_variacion)












































