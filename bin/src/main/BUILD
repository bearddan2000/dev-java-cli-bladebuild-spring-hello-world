maven_jar (
  name = 'spring-boot-starter',
  id = 'org.springframework.boot:spring-boot-starter:2.4.2',  # full maven artifact id
)

java_binary(
    name = 'BladeApp',
    main_class = 'example.Main',
    srcs = glob('*.java'),
    deps = [
        ':spring-boot-starter',
    ]
)