class IdConverter {
  List<String> convertId(genreList) {
    List<String> genreOrId = [];

    for (var i = 0; i < genreList.length; i++) {
      switch (genreList[i]) {
        case 0:
          {
            genreOrId.add("Indisponível");
          }
          break;
        case 12:
          {
            genreOrId.add("Aventura");
          }
          break;
        case 14:
          {
            genreOrId.add("Fantasia");
          }
          break;
        case 16:
          {
            genreOrId.add("Animação");
          }
          break;
        case 18:
          {
            genreOrId.add("Drama");
          }
          break;
        case 27:
          {
            genreOrId.add("Horror");
          }
          break;
        case 28:
          {
            genreOrId.add("Ação");
          }
          break;
        case 35:
          {
            genreOrId.add("Comédia");
          }
          break;
        case 36:
          {
            genreOrId.add("História");
          }
          break;
        case 37:
          {
            genreOrId.add("Faroeste");
          }
          break;
        case 53:
          {
            genreOrId.add("Thriller");
          }
          break;
        case 80:
          {
            genreOrId.add("Crime");
          }
          break;
        case 99:
          {
            genreOrId.add("Documentário");
          }
          break;
        case 878:
          {
            genreOrId.add("Ficção Científica");
          }
          break;
        case 9648:
          {
            genreOrId.add("Mistério");
          }
          break;
        case 10402:
          {
            genreOrId.add("Musical");
          }
          break;
        case 10749:
          {
            genreOrId.add("Romance");
          }
          break;
        case 10751:
          {
            genreOrId.add("Família");
          }
          break;
        case 10752:
          {
            genreOrId.add("Guerra");
          }
          break;

        case 10762:
          {
            genreOrId.add("Infantil");
          }
          break;
        case 10763:
          {
            genreOrId.add("Notícias");
          }
          break;
        case 10764:
          {
            genreOrId.add("Reality");
          }
          break;

        case 10767:
          {
            genreOrId.add("Entrevista");
          }
          break;
        case 10768:
          {
            genreOrId.add("Guerra e Política");
          }
          break;
        case 10766:
          {
            genreOrId.add("Novelas");
          }
          break;
        case 10770:
          {
            genreOrId.add("Séries");
          }
          break;
        case 10765:
          {
            genreOrId.add("Ficção e Fantasia");
          }
          break;
        case 10759:
          {
            genreOrId.add("Ação e Aventura");
          }
          break;

        default:
          {
            genreOrId.add(genreList[i]);
          }
      }
    }
    //This logic solved the problem of printing the [] from my string list
        if (genreOrId.isNotEmpty){
      if (genreOrId.elementAt(0) == "[") {
        genreOrId.removeAt(0);
        genreOrId.removeLast();
      }
    } else {
          genreOrId = ["Gêneros indisponíveis"];
        }
    return genreOrId;
  }
}
