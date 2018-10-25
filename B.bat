java org.antlr.v4.Tool our_smoola.g4
javac our_smoola*.java
java org.antlr.v4.runtime.misc.TestRig our_smoola program -gui %*
