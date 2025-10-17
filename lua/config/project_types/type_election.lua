---@diagnostic disable: undefined-field
return {
  -- INFO: projects java
  java = {
    -- NOTE: To make a new project Gradle
    gradle = function()
      vim.cmd("echo 'Create a Gradle proyect'")
      local project_name = vim.fn.input("Name of project (Gradle): ")
      if project_name == "" then
        vim.notify("Error: You must provide a name for the project.", vim.log.levels.ERROR)
        return
      end
      local base_package = vim.fn.input("Base package (default: com.edu.ignis): ")
      if base_package == "" then
        base_package = "com.edu.ignis"
      end
      -- Define paths and names
      local package_name = base_package .. "." .. project_name
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      local main_class = "Main"
      local package_path = package_name:gsub("%.", "/")

      -- Create project directories
      vim.fn.mkdir(project_path .. "/src/main/java/" .. package_path, "p")
      vim.fn.mkdir(project_path .. "/src/test/java", "p")
      vim.fn.mkdir(project_path .. "/src/main/resources", "p")

      -- Create build.gradle file
      local build_gradle = [[
plugins {
  id 'application'
  id 'java'
}

group = ']] .. base_package .. [['
version = '1.0-SNAPSHOT'

repositories {
  mavenCentral()
}

dependencies {
  testImplementation 'org.junit.jupiter:junit-jupiter:5.10.0'
}

application {
  mainClass = ']] .. package_name .. "." .. main_class .. [['
}

test {
  useJUnitPlatform()
}

java {
  sourceCompatibility = JavaVersion.VERSION_21
  targetCompatibility = JavaVersion.VERSION_21
}
]]
      local build_gradle_path = project_path .. "/build.gradle"
      local build_gradle_file = io.open(build_gradle_path, "w")
      if build_gradle_file then
        build_gradle_file:write(build_gradle)
        build_gradle_file:close()
        vim.notify("Created build.gradle", vim.log.levels.INFO)
      else
        vim.notify("Error: Could not create build.gradle", vim.log.levels.ERROR)
        return
      end

      -- Create settings.gradle file
      local settings_gradle = "rootProject.name = '" .. project_name .. "'"
      local settings_gradle_path = project_path .. "/settings.gradle"
      local settings_gradle_file = io.open(settings_gradle_path, "w")
      if settings_gradle_file then
        settings_gradle_file:write(settings_gradle)
        settings_gradle_file:close()
        vim.notify("Created settings.gradle", vim.log.levels.INFO)
      else
        vim.notify("Error: Could not create settings.gradle", vim.log.levels.ERROR)
        return
      end

      -- Create .gitignore
      local gitignore = [[
.gradle/
build/
*.class
*.log
.idea/
*.iml
]]
      local gitignore_file = io.open(project_path .. "/.gitignore", "w")
      if gitignore_file then
        gitignore_file:write(gitignore)
        gitignore_file:close()
      end

      -- Create Main.java file
      local main_java = [[
package ]] .. package_name .. [[;

public class Main {
  public static void main(String[] args) {
    System.out.println("¡Hello world from the project ]] .. project_name .. [[!");
  }
}
]]
      local main_java_path = project_path .. "/src/main/java/" .. package_path .. "/Main.java"
      local main_java_file = io.open(main_java_path, "w")
      if main_java_file then
        main_java_file:write(main_java)
        main_java_file:close()
        vim.notify("Created Main.java", vim.log.levels.INFO)
      else
        vim.notify("Error: Could not create file Main.java", vim.log.levels.ERROR)
        return
      end

      -- Open Main.java and set the project directory
      vim.cmd("cd " .. vim.fn.fnameescape(project_path))
      vim.cmd("edit " .. vim.fn.fnameescape(main_java_path))
      vim.notify("Created Gradle project in: " .. project_path, vim.log.levels.INFO)
    end,

    -- NOTE: To make a new project Maven
    maven = function()
      vim.cmd("echo 'Create Maven proyect'")
      local project_name = vim.fn.input("Name of project (Maven): ")
      if project_name == "" then
        vim.notify("Error: You must provide a name for the project.", vim.log.levels.ERROR)
        return
      end
      local base_package = vim.fn.input("Base package (default: com.edu.ignis): ")
      if base_package == "" then
        base_package = "com.edu.ignis"
      end
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      local package_name = base_package .. "." .. project_name

      vim.fn.mkdir(project_path .. "/src/main/java/" .. package_name:gsub("%.", "/"), "p")
      vim.fn.mkdir(project_path .. "/src/main/resources", "p")
      vim.fn.mkdir(project_path .. "/src/test/java", "p")
      vim.fn.mkdir(project_path .. "/src/test/resources", "p")

      -- Create pom.xml
      local pom_xml = [[
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>]] .. base_package .. [[</groupId>
  <artifactId>]] .. project_name .. [[</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>]] .. project_name .. [[</name>
  <url>http://maven.apache.org</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>21</maven.compiler.source>
    <maven.compiler.target>21</maven.compiler.target>
    <junit.version>5.10.0</junit.version>
  </properties>

  <dependencies>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter</artifactId>
      <version>${junit.version}</version>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.11.0</version>
        <configuration>
          <source>${maven.compiler.source}</source>
          <target>${maven.compiler.target}</target>
        </configuration>
      </plugin>
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>exec-maven-plugin</artifactId>
        <version>3.1.0</version>
        <configuration>
          <mainClass>]] .. package_name .. [[.Main</mainClass>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
]]
      local pom_xml_path = project_path .. "/pom.xml"
      local pom_xml_file = io.open(pom_xml_path, "w")
      if pom_xml_file then
        pom_xml_file:write(pom_xml)
        pom_xml_file:close()
        vim.notify("Created pom.xml", vim.log.levels.INFO)
      else
        vim.notify("Error: Could not create pom.xml", vim.log.levels.ERROR)
        return
      end

      -- Create .gitignore
      local gitignore = [[
target/
*.class
*.log
.idea/
*.iml
.classpath
.project
.settings/
]]
      local gitignore_file = io.open(project_path .. "/.gitignore", "w")
      if gitignore_file then
        gitignore_file:write(gitignore)
        gitignore_file:close()
      end

      -- Create Main.java
      local main_java = [[
package ]] .. package_name .. [[;

public class Main {
  public static void main(String[] args) {
    System.out.println("¡Hello world from the Maven project ]] .. project_name .. [[!");
  }
}
]]
      local main_java_path = project_path .. "/src/main/java/" .. package_name:gsub("%.", "/") .. "/Main.java"
      local main_java_file = io.open(main_java_path, "w")
      if main_java_file then
        main_java_file:write(main_java)
        main_java_file:close()
        vim.notify("Created Main.java", vim.log.levels.INFO)
      else
        vim.notify("Error: Could not create Main.java", vim.log.levels.ERROR)
        return
      end

      vim.cmd("cd " .. vim.fn.fnameescape(project_path))
      vim.cmd("edit " .. vim.fn.fnameescape(main_java_path))
      vim.notify("Created Maven project in: " .. project_path, vim.log.levels.INFO)
    end,

    -- NOTE: To make a new project Ant
    ant = function()
      vim.cmd("echo 'Create Ant project'")
      local project_name = vim.fn.input("Name of project (Ant): ")
      if project_name == "" then
        vim.notify("Error: You must provide a name for the project.", vim.log.levels.ERROR)
        return
      end
      local base_package = vim.fn.input("Base package (default: com.edu.ignis): ")
      if base_package == "" then
        base_package = "com.edu.ignis"
      end
      local cwd = vim.fn.getcwd()
      local project_path = cwd .. "/" .. project_name
      local package_name = base_package .. "." .. project_name
      local src_path = "src/main/java/" .. package_name:gsub("%.", "/")

      -- Directory structure
      vim.fn.mkdir(project_path .. "/" .. src_path, "p")
      vim.fn.mkdir(project_path .. "/build", "p")
      vim.fn.mkdir(project_path .. "/lib", "p")

      -- build.xml
      local build_xml = [[
<project name="]] .. project_name .. [[" default="run" basedir=".">
  <property name="src" location="src/main/java"/>
  <property name="build" location="build"/>
  <property name="lib" location="lib"/>

  <target name="clean">
    <delete dir="${build}"/>
  </target>

  <target name="compile">
    <mkdir dir="${build}"/>
    <javac srcdir="${src}" destdir="${build}" includeantruntime="false" 
           source="21" target="21" encoding="UTF-8">
      <classpath>
        <fileset dir="${lib}" includes="**/*.jar"/>
      </classpath>
    </javac>
  </target>

  <target name="jar" depends="compile">
    <jar destfile="${build}/]] .. project_name .. [[.jar" basedir="${build}">
      <manifest>
        <attribute name="Main-Class" value="]] .. package_name .. [[.Main"/>
      </manifest>
    </jar>
  </target>

  <target name="run" depends="compile">
    <java classname="]] .. package_name .. [[.Main" classpath="${build}" fork="true"/>
  </target>
</project>
]]
      local build_file = io.open(project_path .. "/build.xml", "w")
      if build_file then
        build_file:write(build_xml)
        build_file:close()
      end

      -- .project
      local project_file = io.open(project_path .. "/.project", "w")
      if project_file then
        project_file:write([[<?xml version="1.0" encoding="UTF-8"?>
<projectDescription>
  <name>]] .. project_name .. [[</name>
  <natures>
    <nature>org.eclipse.jdt.core.javanature</nature>
  </natures>
  <buildSpec>
    <buildCommand>
      <name>org.eclipse.jdt.core.javabuilder</name>
    </buildCommand>
  </buildSpec>
</projectDescription>]])
        project_file:close()
      end

      -- .classpath with JRE_CONTAINER
      local classpath_file = io.open(project_path .. "/.classpath", "w")
      if classpath_file then
        classpath_file:write([[<?xml version="1.0" encoding="UTF-8"?>
<classpath>
  <classpathentry kind="src" path="src/main/java"/>
  <classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
  <classpathentry kind="lib" path="lib"/>
  <classpathentry kind="output" path="build"/>
</classpath>]])
        classpath_file:close()
      end

      -- Main.java
      local main_java = [[
package ]] .. package_name .. [[;

public class Main {
  public static void main(String[] args) {
    System.out.println("¡Hello world from the Ant project ]] .. project_name .. [[!");
  }
}
]]
      local main_java_path = project_path .. "/" .. src_path .. "/Main.java"
      local main_java_file = io.open(main_java_path, "w")
      if main_java_file then
        main_java_file:write(main_java)
        main_java_file:close()
      end

      -- To open and located at the project
      vim.cmd("cd " .. vim.fn.fnameescape(project_path))
      vim.cmd("edit " .. vim.fn.fnameescape(main_java_path))
      vim.notify("Created Ant project in: " .. project_path, vim.log.levels.INFO)
    end,

    -- NOTE: To make a new project JavaFx
    javafx = function()
      vim.cmd("echo 'Create JavaFx with Maven proyect'")
      local project_name = vim.fn.input("Name of project (JavaFx): ")
      if project_name == "" then
        vim.notify("Error: You must provide a name for the project.", vim.log.levels.ERROR)
        return
      end
      local base_package = vim.fn.input("Base package (default: com.edu.ignis): ")
      if base_package == "" then
        base_package = "com.edu.ignis"
      end
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      local package_name = base_package .. "." .. project_name

      vim.fn.mkdir(project_path .. "/src/main/java/" .. package_name:gsub("%.", "/"), "p")
      vim.fn.mkdir(project_path .. "/src/main/resources", "p")
      vim.fn.mkdir(project_path .. "/src/test/java", "p")
      vim.fn.mkdir(project_path .. "/src/test/resources", "p")

      -- Create pom.xml
      local pom_xml = [[
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>]] .. base_package .. [[</groupId>
  <artifactId>]] .. project_name .. [[</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>]] .. project_name .. [[</name>
  <url>http://maven.apache.org</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>21</maven.compiler.source>
    <maven.compiler.target>21</maven.compiler.target>
    <junit.version>5.10.0</junit.version>
    <javafx.version>21</javafx.version>
  </properties>

  <dependencies>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter</artifactId>
      <version>${junit.version}</version>
      <scope>test</scope>
    </dependency>
    <!-- JavaFX Dependencies -->
    <dependency>
      <groupId>org.openjfx</groupId>
      <artifactId>javafx-controls</artifactId>
      <version>${javafx.version}</version>
    </dependency>
    <dependency>
      <groupId>org.openjfx</groupId>
      <artifactId>javafx-fxml</artifactId>
      <version>${javafx.version}</version>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.11.0</version>
        <configuration>
          <source>${maven.compiler.source}</source>
          <target>${maven.compiler.target}</target>
        </configuration>
      </plugin>
      <plugin>
        <groupId>org.openjfx</groupId>
        <artifactId>javafx-maven-plugin</artifactId>
        <version>0.0.8</version>
        <configuration>
          <mainClass>]] .. package_name .. [[.Main</mainClass>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
]]
      local pom_xml_path = project_path .. "/pom.xml"
      local pom_xml_file = io.open(pom_xml_path, "w")
      if pom_xml_file then
        pom_xml_file:write(pom_xml)
        pom_xml_file:close()
        vim.notify("Created pom.xml", vim.log.levels.INFO)
      else
        vim.notify("Error: Could not create pom.xml", vim.log.levels.ERROR)
        return
      end

      -- Create Main.java
      local main_java = [[
package ]] .. package_name .. [[;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

public class Main extends Application {
  public static void main(String[] args) {
    launch(args);
  }

  @Override
  public void start(Stage stage) {
    Label label = new Label("¡Hello world from JavaFX!");
    label.setStyle("-fx-font-size: 24px; -fx-text-fill: #333;");

    StackPane root = new StackPane(label);
    Scene scene = new Scene(root, 400, 200);

    stage.setScene(scene);
    stage.setTitle("JavaFX Project: ]] .. project_name .. [[");
    stage.show();
  }
}
]]
      local main_java_path = project_path .. "/src/main/java/" .. package_name:gsub("%.", "/") .. "/Main.java"
      local main_java_file = io.open(main_java_path, "w")
      if main_java_file then
        main_java_file:write(main_java)
        main_java_file:close()
        vim.notify("Created Main.java", vim.log.levels.INFO)
      else
        vim.notify("Error: Could not create Main.java", vim.log.levels.ERROR)
        return
      end

      vim.cmd("cd " .. vim.fn.fnameescape(project_path))
      vim.cmd("edit " .. vim.fn.fnameescape(main_java_path))
      vim.notify("Created JavaFX Maven project in: " .. project_path, vim.log.levels.INFO)
    end,

    -- NOTE: Spring Boot project
    springBoot = function()
      vim.notify("Creating Spring Boot project via Spring Initializr is complex.", vim.log.levels.INFO)
      vim.notify("Consider using: https://start.spring.io/ or Spring CLI", vim.log.levels.INFO)
    end,
  },

  -- INFO: Projects JavaScript
  javascript = {
    default = function()
      vim.cmd("echo 'Create JavaScript project'")
      local project_name = vim.fn.input("Name of project (JS): ")
      if project_name == "" then
        vim.notify("Error: You must provide a name", vim.log.levels.ERROR)
        return
      end

      -- Create project folder
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      vim.fn.mkdir(project_path .. "/src", "p")

      -- Execute npm init and install dependencies
      vim.notify("Installing dependencies...", vim.log.levels.INFO)
      vim.fn.system("cd " .. vim.fn.fnameescape(project_path) .. " && npm init -y && npm install eslint eslint_d --save-dev")

      -- Create index.js
      local main_js_path = project_path .. "/src/index.js"
      local f = io.open(main_js_path, "w")
      if f then
        f:write([[console.log("Hello world from JavaScript project!");

// Example function
function greet(name) {
  return `Hello, ${name}!`;
}

console.log(greet("World"));
]])
        f:close()
      end

      -- eslint configuration
      local eslint_conf = [[
{
  "env": {
    "browser": true,
    "es2021": true,
    "node": true
  },
  "extends": "eslint:recommended",
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "rules": {
    "indent": ["error", 2],
    "quotes": ["error", "single"],
    "semi": ["error", "always"]
  }
}
]]
      local eslint_path = project_path .. "/.eslintrc.json"
      local e = io.open(eslint_path, "w")
      if e then
        e:write(eslint_conf)
        e:close()
      end

      -- Create .gitignore
      local gitignore = [[
node_modules/
dist/
*.log
.env
.DS_Store
]]
      local git_file = io.open(project_path .. "/.gitignore", "w")
      if git_file then
        git_file:write(gitignore)
        git_file:close()
      end

      -- Update package.json with scripts
      local pkg_path = project_path .. "/package.json"
      vim.defer_fn(function()
        local f_pkg = io.open(pkg_path, "r")
        if not f_pkg then
          vim.notify("Could not read package.json", vim.log.levels.ERROR)
          return
        end
        local pkg_content = f_pkg:read("*a")
        f_pkg:close()

        local ok, pkg = pcall(vim.json.decode, pkg_content)
        if not ok then
          vim.notify("Error parsing package.json", vim.log.levels.ERROR)
          return
        end

        pkg.type = "module"
        pkg.scripts = pkg.scripts or {}
        pkg.scripts.start = "node src/index.js"
        pkg.scripts.lint = "eslint src/**/*.js"
        pkg.scripts["lint:fix"] = "eslint src/**/*.js --fix"

        local f2 = io.open(pkg_path, "w")
        if f2 then
          f2:write(vim.json.encode(pkg))
          f2:close()
        end
      end, 100)

      -- Change to project directory and open index.js
      vim.cmd("cd " .. vim.fn.fnameescape(project_path))
      vim.cmd("edit " .. vim.fn.fnameescape(main_js_path))

      vim.notify("Created JavaScript project with ESLint in: " .. project_path, vim.log.levels.INFO)
    end,
  },

  -- INFO: Projects TypeScript
  typescript = {
    default = function()
      vim.cmd("echo 'Create TypeScript project'")
      local project_name = vim.fn.input("Name of project (TS): ")
      if project_name == "" then
        vim.notify("Error: You must provide a name", vim.log.levels.ERROR)
        return
      end

      local project_path = vim.fn.getcwd() .. "/" .. project_name
      vim.fn.mkdir(project_path .. "/src", "p")

      -- Execute npm init
      vim.notify("Installing dependencies...", vim.log.levels.INFO)
      vim.fn.system("cd " .. vim.fn.fnameescape(project_path) .. " && npm init -y")

      -- Install dependencies
      vim.fn.system("cd " .. vim.fn.fnameescape(project_path) ..
        " && npm install typescript ts-node @types/node eslint eslint_d " ..
        "@typescript-eslint/parser @typescript-eslint/eslint-plugin --save-dev")

      -- Create tsconfig.json
      local tsconfig = [[
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "commonjs",
    "lib": ["ES2022"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "moduleResolution": "node"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
]]
      local tsconfig_file = io.open(project_path .. "/tsconfig.json", "w")
      if tsconfig_file then
        tsconfig_file:write(tsconfig)
        tsconfig_file:close()
      end

      -- Create index.ts
      local main_ts = [[
console.log("Hello world from TypeScript project!");

// Example function with TypeScript types
function greet(name: string): string {
  return `Hello, ${name}!`;
}

console.log(greet("World"));

// Example interface
interface User {
  id: number;
  name: string;
  email: string;
}

const user: User = {
  id: 1,
  name: "John Doe",
  email: "john@example.com"
};

console.log(user);
]]
      local main_ts_path = project_path .. "/src/index.ts"
      local f = io.open(main_ts_path, "w")
      if f then
        f:write(main_ts)
        f:close()
      end

      -- Create .eslintrc
      local eslint_conf = [[
{
  "env": {
    "es2021": true,
    "node": true
  },
  "parser": "@typescript-eslint/parser",
  "plugins": ["@typescript-eslint"],
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended"
  ],
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module",
    "project": "./tsconfig.json"
  },
  "rules": {
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-unused-vars": ["error", { "argsIgnorePattern": "^_" }]
  }
}
]]
      local eslint_path = project_path .. "/.eslintrc.json"
      local e = io.open(eslint_path, "w")
      if e then
        e:write(eslint_conf)
        e:close()
      end

      -- Create .gitignore
      local gitignore = [[
node_modules/
dist/
*.log
.env
.DS_Store
]]
      local git_file = io.open(project_path .. "/.gitignore", "w")
      if git_file then
        git_file:write(gitignore)
        git_file:close()
      end

      -- Update package.json
      local pkg_path = project_path .. "/package.json"
      vim.defer_fn(function()
        local f_pkg = io.open(pkg_path, "r")
        if not f_pkg then
          vim.notify("Cannot open package.json for reading", vim.log.levels.ERROR)
          return
        end
        local pkg_content = f_pkg:read("*a")
        f_pkg:close()

        local ok, pkg = pcall(vim.json.decode, pkg_content)
        if not ok then
          vim.notify("Error parsing package.json", vim.log.levels.ERROR)
          return
        end

        pkg.scripts = pkg.scripts or {}
        pkg.scripts.build = "tsc"
        pkg.scripts.start = "node dist/index.js"
        pkg.scripts.dev = "ts-node src/index.ts"
        pkg.scripts.lint = "eslint src/**/*.ts"
        pkg.scripts["lint:fix"] = "eslint src/**/*.ts --fix"

        local f2 = io.open(pkg_path, "w")
        if f2 then
          f2:write(vim.json.encode(pkg))
          f2:close()
        end
      end, 100)

      vim.cmd("cd " .. vim.fn.fnameescape(project_path))
      vim.cmd("edit " .. vim.fn.fnameescape(main_ts_path))
      vim.notify("Created TypeScript project with ESLint in: " .. project_path, vim.log.levels.INFO)
    end,
  },

  -- INFO: Projects Python (placeholder para futuras implementaciones)
  python = {},

  -- INFO: Projects C (placeholder para futuras implementaciones)
  c = {},

  -- INFO: Projects Rust (placeholder para futuras implementaciones)
  rust = {},
}
