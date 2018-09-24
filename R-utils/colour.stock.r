#==========================================================================================#
#==========================================================================================#
#     This function creates a vector with colours for plots that are mostly CB friendly.   #
#  The quality decays as the number of lines increases.                                    #
#------------------------------------------------------------------------------------------#
colour.stock <<- function(n,alt=FALSE,shf=alt,pvf=3){
   #----- Build the colour stock.  Add pale and dark versions of the default colours. -----#
   if (alt){
      cstock = c("#332288","#6699CC","#88CCEE","#44AA99"
                ,"#117733","#999933","#DDCC77","#661100"
                ,"#CC6677","#AA4466","#882255","#AA4499"
                )#end c
   }else{
      cstock = c("#811F9E","#2BD2DB","#F87856"
                ,"#880D32","#0E6E81","#1BA2F7"
                ,"#CCCA3D","#A3F888","#F9E5C0"
                )#end c
   }#end if (alt)
   nstock.base = length(cstock)



   #---------------------------------------------------------------------------------------#
   #    Make sure does not exceed the maximum number of colours.                           #
   #---------------------------------------------------------------------------------------#
   if (n > (6 * nstock.base)){
      cat("-----------------------------------------","\n",sep="")
      cat(" Provided n      = ",n                    ,"\n",sep="")
      cat(" Maximum allowed = ",6*nstock.base        ,"\n",sep="")
      cat("-----------------------------------------","\n",sep="")
      stop("Either reduce n or add more colours to the colour stock")
   }#end if (n > (6 * length(cstock)))
   #---------------------------------------------------------------------------------------#


   #---------------------------------------------------------------------------------------#
   #    Make pvf is valid.                                                                 #
   #---------------------------------------------------------------------------------------#
   if (pvf < 1.01){
      cat("-----------------------------------------","\n",sep="")
      cat(" Provided pvf    = ",pvf                  ,"\n",sep="")
      cat(" Minimum allowed = ",1.01                 ,"\n",sep="")
      cat("-----------------------------------------","\n",sep="")
      stop("Increase pvf")
   }#end if (pvf < 1.01)
   #---------------------------------------------------------------------------------------#


   #---------------------------------------------------------------------------------------#
   #       Large number of colours, interpolate base.                                      #
   #---------------------------------------------------------------------------------------#
   if (n > (3 * nstock.base)){
      midst        = col2hsv(cstock)
      o            = order(midst[1,])
      midst        = midst[,o]
      lastcol      = midst[,1,drop=FALSE]
      lastcol[1,]  = lastcol[1,] + 1.0
      morecols     = t(apply(X=cbind(midst,lastcol),MARGIN=1,FUN=mid.points))
      morecols[1,] = morecols[1,] %% 1.
      morecols     = hsv(h=morecols[1,],s=morecols[2,],v=morecols[3,])
      cstock       = sample(c(cstock,morecols))
   }else if (shf){
      cstock       = sample(cstock)
   }#end if 
   #---------------------------------------------------------------------------------------#
   
   #---------------------------------------------------------------------------------------#
   #    Find factors to push closer to zero or one.                                        #
   #---------------------------------------------------------------------------------------#
   cwgt  = (pvf - 1.0) / pvf
   czero = 0.
   cone  = 1.0 / pvf
   #---------------------------------------------------------------------------------------#



   #---------------------------------------------------------------------------------------#
   #    Expand data to include pale and darker colours.                                    #
   #---------------------------------------------------------------------------------------#
   pale     = col2hsv(cstock)
   pale[2,] = czero + cwgt * pale[2,]
   pale[3,] = cone  + cwgt * pale[3,]
   pale     = hsv(h=pale[1,],s=pale[2,],v=pale[3,])
   vibr     = col2hsv(cstock)
   vibr[2,] = cone  + cwgt * vibr[2,]
   vibr[3,] = czero + cwgt * vibr[3,]
   vibr     = hsv(h=vibr[1,],s=vibr[2,],v=vibr[3,])
   cstock   = c(cstock,vibr,pale)
   #---------------------------------------------------------------------------------------#

   #---------------------------------------------------------------------------------------#
   #    Make sure does not exceed the maximum number of colours.                           #
   #---------------------------------------------------------------------------------------#
   ans = cstock[sequence(n)]
   return(ans)
   #---------------------------------------------------------------------------------------#
}#end colour.stock
#==========================================================================================#
#==========================================================================================#





#==========================================================================================#
#==========================================================================================#
#     This function creates a vector with pch for plots to make it easier for CB folks.    #
#  The quality decays as the number of lines increases.                                    #
#------------------------------------------------------------------------------------------#
pch.stock <<- function(n){
   #----- Build the colour stock.  Add pale and dark versions of the default colours. -----#
   pstock = c(16, 4,13,17, 6, 7, 0, 5, 2
             , 3, 1,14,10,18, 9, 8,12,15
             ,11, 6,16, 5,13, 4,17, 3, 0
             )#end c

   #---------------------------------------------------------------------------------------#
   #    Make sure does not exceed the maximum number of colours.                           #
   #---------------------------------------------------------------------------------------#
   if (n > length(pstock)){
      cat("-----------------------------------------","\n",sep="")
      cat(" Provided n      = ",n                    ,"\n",sep="")
      cat(" Maximum allowed = ",length(cstock)       ,"\n",sep="")
      cat("-----------------------------------------","\n",sep="")
      stop("Either reduce n or add more pch types to the pch stock")
   }else{
      ans = pstock[sequence(n)]
      return(ans)
   }#end if
   #---------------------------------------------------------------------------------------#
}#end pch.stock
#==========================================================================================#
#==========================================================================================#





#==========================================================================================#
#==========================================================================================#
#     This function creates a vector with pch for plots to make it easier for CB folks.    #
#  The quality decays as the number of lines increases.                                    #
#------------------------------------------------------------------------------------------#
lty.stock <<- function(n){
   #----- Build the line type stock. ------------------------------------------------------#
   lstock = c("solid","longdash","dotdash","dotted","twodash","dashed")
   #---------------------------------------------------------------------------------------#

   #---------------------------------------------------------------------------------------#
   #    Repeat line patterns until the sought size is reached.                             #
   #---------------------------------------------------------------------------------------#
   ans = rep(x=lstock,times= ceiling(n/length(lstock)))
   ans = ans[sequence(n)]
   return(ans)
   #---------------------------------------------------------------------------------------#
}#end lty.stock
#==========================================================================================#
#==========================================================================================#
