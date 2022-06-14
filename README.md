# Testing-Proyecto-2

Link a producción: https://testing-proyecto2.herokuapp.com/

Versión de Ruby: ``3.0.0``

Versión de Rails: ``7.0.3``

Para correr el proyecto: 
1. Clonar el repositorio
2. Entrar a la carpeta del repositorio ``cd Testing-Proyecto-2``
3. ``bundle install``
4. ``bin/rails db:create`` (Es probable que se requiera tener un rol con superuser creado anteriormente es postgres)
5. ``bin/rails db:migrate`` 
6. ``bin/rails server``

Para correr los test unitarios y Capybara:
``bundle exec rspec``
