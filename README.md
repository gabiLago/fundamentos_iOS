#  Práctica de Fundamentos iOS

### Obligatorio

1.  Season y Episode
* clase Season que representa una temporada:  nombre y  fecha (Date). **Done**
* Cada episodio está representado por una instancia de Episode. Episode: título y  fecha de emisión. **Done**
* Todo episodio tiene una referencia a la Season de la que es parte. ¡Mucho cuidado con crear referencias circulares! **Done** 
2. Implementa los siguientes protocolos en Episode y Season con sus correspondientes tests unitarios:
* CustomStringConvertible **Done**
* Equatable **Done**
* Hashable **Done**
* Comparable **Done**
* IMPORTANTE: ¡No te olvides de escribir los tests! **Done** 
3. Crea una propiedad calculada en tu Repository.local, llamada seasons (similar a houses). Devuelve las primeras 7 temporadas, ordenadas, con sus episodios. **Done**
4. Crea una función en tu Repository.local llamada seasons(filteredBy:) -> [Season] que acepta una clausura (similar a lo que hicimos para houses) y te permite recibir un [Season] filtrado. **Done**
5. Crea un SeasonListViewController. Al hacer clic sobre una celda, se debe hacer un push de un SeasonDetailViewController. **Done**
6. Crea un EpisodeListViewController. Al hacer clic sobre una celda, se debe de hacer un push de un EpisodeDetailViewController. **Done**
7. Nueva Interfaz gráfica:
* Crea un HouseListViewController empaquetado dentro de un UINavigationController. **Done - con WrappedInNavigation()**
* Crea un SeasonListViewController empaquetado dentro de un UINavigationViewController Mete a ambos dentro de un UITabBarController **Done**
* Usa éste como masterViewController del UISplitViewController. Asegúrate de poder cambiar de uno a otro y poder navegar de House a Person y de Season a Episode. **Done**
* Pista: UITabBarControllerDelegate
* Pista 2: Guarda como propiedades todos aquellos objetos que necesites utilizar en varios métodos de la misma clase.
8. Crea una función house(:named), similar a la que acepta un String, pero que sea type safe y funcione el autocompletado. ¿Se te ocurre qué tipo de datos podemos utilizar? Haz el test correspondiente. **Done - con Enum**

9. Arreglar en iPad MembersViewController para que responda al cambio en la lista igual que WikiVC. Arréglalo. También para que al seleccionar otra Season se actualiza su detalle y su lista de capítulos. 
10. Crea un MemberDetailViewController. Cuando se haga click en una celda de MemberListViewController, hacer un push a MemberDetailViewController. **Done**

### Opcional 
11. En nuestra clase Repository, cuando creamos un personaje, le pasamos por parámetro la casa a la que pertenece:
Sin embargo, para que el personaje pertenezca a la casa debemos añadirlo manualmente:
¿No os resulta esto un poco redundante? ¿Cómo podríamos hacer para que al crear un nuevo personaje y asignarle la casa, se actualice su propiedad _members     ? Impleméntalo.
1
arya = Person(name: "Arya", house: starkHouse)
1
starkHouse.add(person: arya) **#warning("toDo")**

En el siguiente módulo veréis que, utilizando CoreData, se actualiza automágicamente 

12. Cuando utilizamos el UISplitViewController en iPhone, nos damos cuenta de varias cosas: por una parte, el UISplitViewController parece haberse transformado en un UINavigationController; por otra, parece que ya se ha hecho un push a HouseDetailViewController.
Cuando volvemos hacia atrás y seleccionamos de nuevo algún House, no se produce la navegación. Arréglalo   .**Done**
