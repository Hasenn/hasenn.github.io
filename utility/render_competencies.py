competencies = {
    "Méthodologies" : "UML;Agile",
    "Languages / Scripting" : "Python;C#;C/C++;F#;Caml;JavaScript;WebGL;GLSL",
    "Markdown / Web" : "Xml;Html5;Css3;Json;Yaml;Toml",
    "Bases de données" : "MariaDB;PostgreSQL",
    "Outils et technologies" : "Git;Unity;Godot 3;Discord API"
}

def render_competencies(cmp):
    ans = ""
    for label, items in cmp.items():
        ans += label + " : "
        for item in items.split(';'):
            ans += "<mark>" + item + "</mark>" + " "
        ans += "\n"
    return ans

print(render_competencies(competencies))
