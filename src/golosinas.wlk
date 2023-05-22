/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */

class Golosina {
	var peso
	var precio
	var sabor
	var libreDeGluten
	
	method peso() { return peso }
	method precio() { return precio }
	method sabor() { return sabor }
	method libreGluten() { return libreDeGluten }
	
}

class Bombon inherits Golosina {
	
	method initialize() {
		peso = 15
		precio = 5
		sabor = frutilla
		libreDeGluten = true
	}
	method mordisco() { peso = peso * 0.8 - 1 }
}


class Alfajor inherits Golosina {
	
	method initialize() {
		peso = 15
		precio = 12
		sabor = chocolate
		libreDeGluten = false
	}
	method mordisco() { peso = peso * 0.8 }
}

class Caramelo inherits Golosina {
	var gusto 
	
	method initialize() {
		peso = 5
		precio = 12
		sabor = gusto
		libreDeGluten = true
	}
	
	method mordisco() { peso = peso - 1 }
}


class Chupetin inherits Golosina {
	
	method initialize() {
		peso = 7
		precio = 2
		sabor = naranja
		libreDeGluten = true
	}
	
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
}

class Oblea inherits Golosina {
	
	method initialize() {
		peso = 250
		precio = 5
		sabor = vainilla
		libreDeGluten = false
	}
	
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
}

class Chocolatin {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }
	method peso() { return (pesoInicial - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
	method libreGluten() { return false }

}

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}

class BombonDuro inherits Bombon {
	override method mordisco() {
		peso = peso - 1
	}
	method gradoDeDuro() {
		if (peso > 12) {
			return 3
		}
		else if (peso >= 8) {
			return 2
		}
		else return 1
	}
}

class CarameloRelleno inherits Caramelo {
	override method precio() = 13
	
	override method mordisco() {
		sabor(chocolate)
		peso = peso - 1
	}
}

class ObleasCrujientes inherits Oblea{
	var cantMordiscos = 0
	override method mordisco() {
		cantMordiscos += 1
		if (cantMordiscos < 3) {
			peso = peso - ((peso * 0.25) - 3)
		}
		else peso = peso - (peso * 0.25)
	}
}
