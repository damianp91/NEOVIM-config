return  {
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
        base_package = "com.edu.ignis";
      end
      -- Define paths and names
      local package_name = base_package .. "." .. project_name
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      local main_class = "Main"
      local package_path = package_name:gsub("%.", "/")  -- Convert package name to directory path
      -- Create project directories
      vim.fn.mkdir(project_path .. "/src/main/java/" .. package_path, "p")
      vim.fn.mkdir(project_path .. "/src/test/java", "p") -- Test folder
      -- Create build.gradle file
      local build_gradle = [[
plugins {
  id 'application'
  id 'java'
}
group = ']] .. package_name .. [['
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
]]
      local build_gradle_path = project_path .. "/build.gradle"
      local build_gradle_file = io.open(build_gradle_path, "w")
      if build_gradle_file then
        build_gradle_file:write(build_gradle)
        build_gradle_file:close()
        vim.notify("Created build.gradle", vim.log.levels.INFO)
      else
        vim.notify("Error: Could not create build.gradle", vim.log.levels.ERROR)
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
      end
      -- Open Main.java and set the project directory
      vim.cmd("edit " .. main_java_path)
      vim.cmd("cd " .. project_path)
      vim.notify("Created project in: " .. project_path, vim.log.levels.INFO)
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
        base_package = "com.edu.ignis";
      end
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      local package_name = base_package .. "." .. project_name
      vim.fn.mkdir(project_path .. "/src/main/java/" .. package_name:gsub("%.", "/"), "p")
      vim.fn.mkdir(project_path .. "/src/main/resources", "p")
      vim.fn.mkdir(project_path .. "/src/test/java", "p")
      vim.fn.mkdir(project_path .. "/src/test/resources", "p")
      -- Create pom.xml
      local pom_xml = [[
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>]] .. package_name .. [[</groupId>
  <artifactId>]] .. project_name .. [[</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>testMaven</name>
  <url>http://maven.apache.org</url>
  <properties>
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
      end
      vim.cmd("edit " .. main_java_path)     -- Open Main.java in Neovim
      vim.cmd("cd " .. project_path)         -- Move to project directory
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
        base_package = "com.edu.ignis";
      end
      local cwd = vim.fn.getcwd()
      local project_path = cwd .. "/" .. project_name
      local package_name = base_package .. "." .. project_name
      local src_path = "src/main/java/" .. package_name:gsub("%.", "/")
      -- Directory estructure
      vim.fn.mkdir(project_path .. "/" .. src_path, "p")
      vim.fn.mkdir(project_path .. "/build", "p")
      -- build.xml
      local build_xml = [[
<project name="]] .. project_name .. [[" default="run" basedir=".">
  <property name="src" location="src/main/java"/>
  <property name="build" location="build"/>

  <target name="clean">
    <delete dir="${build}"/>
  </target>

  <target name="compile">
    <mkdir dir="${build}"/>
    <javac srcdir="${src}" destdir="${build}" includeantruntime="false" source="21" target="21"/>
  </target>

  <target name="run" depends="compile">
    <java classname="]] .. package_name .. [[.Main" classpath="${build}"/>
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
      vim.cmd("edit " .. main_java_path)
      vim.cmd("cd " .. project_path)
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
        base_package = "com.edu.ignis";
      end
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      local package_name = base_package .. "." .. project_name
      vim.fn.mkdir(project_path .. "/src/main/java/" .. package_name:gsub("%.", "/"), "p")
      vim.fn.mkdir(project_path .. "/src/main/resources", "p")
      vim.fn.mkdir(project_path .. "/src/test/java", "p")
      vim.fn.mkdir(project_path .. "/src/test/resources", "p")
      -- Create pom.xml
      local pom_xml = [[
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>]] .. package_name .. [[</groupId>
  <artifactId>]] .. project_name .. [[</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>testMaven</name>
  <url>http://maven.apache.org</url>
  <properties>
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
    <!-- JavaFX Dependencies -->
    <dependency>
      <groupId>org.openjfx</groupId>
      <artifactId>javafx-controls</artifactId>
      <version>21</version>
    </dependency>
    <dependency>
      <groupId>org.openjfx</groupId>
      <artifactId>javafx-fxml</artifactId>
      <version>21</version>
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
          <platform>linux</platform>
          <modules>
            <module>javafx.controls</module>
            <module>javafx.fxml</module>
          </modules>
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
      end
      -- Create Main.java
      local main_java = [[
package ]] .. package_name .. [[;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;

public class Main extends Application {
  public static void main(String[] args) {
    launch(args);
  }

  @Override
  public void start(Stage stage) {
    Label label = new Label("¡Hello world from JavaFX!");
    Scene scene = new Scene(label, 400, 200);
    stage.setScene(scene);
    stage.setTitle("JavaFX Project:]] .. project_name .. [[");
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
      end
      vim.cmd("edit " .. main_java_path)     -- Open Main.java in Neovim
      vim.cmd("cd " .. project_path)         -- Move to project directory
      vim.notify("Created Maven project in: " .. project_path, vim.log.levels.INFO)
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
      vim.fn.mkdir(project_path, "p")

      -- commands of npm
      -- vim.fn.system("cd " .. project_path .. " && npm init -y")
      -- vim.fn.system("cd " .. project_path .. " && npm install eslint eslint_d --save-dev")
      vim.fn.system("cd " .. project_path .. " && npm init -y && npm install eslint eslint_d --save-dev")

      local main_js_path = project_path .. "/index.js"
      local f = io.open(main_js_path, "w")
      if f then
        f:write([[console.log("Hello world from JavaScript project!");]])
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
  "rules": {}
}
]]
      local eslint_path = project_path .. "/.eslintrc.json"
      local e = io.open(eslint_path, "w")
      if e then
        e:write(eslint_conf)
        e:close()
      end

      -- package.json configuration
      local pkg_path = project_path .. "/package.json"
      local f_pkg = io.open(pkg_path, "r")
      if not f_pkg then
        vim.notify("Could not read package.json", vim.log.levels.ERROR)
        return
      end
      local pkg_content = f_pkg:read("*a")
      f_pkg:close()
      local pkg = vim.json.decode(pkg_content)
      pkg.scripts = pkg.scripts or {}
      pkg.scripts.lint = "eslint . --ext .js"
      pkg.scripts["lint:fix"] = "eslint . --ext .js --fix"
      local f2 = io.open(pkg_path, "w")
      if f2 then
        f2:write(vim.json.encode(pkg))
        f2:close()
      end

      -- chcange to index.js
      vim.loop.chdir(project_path)
      vim.cmd("edit " .. main_js_path)

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

      -- Execute npm init -y
      vim.fn.system("cd " .. project_path .. " && npm init -y")
      -- Install dependencies TS
      vim.fn.system("cd " .. project_path .. " && npm install typescript ts-node " +
        "@types/node eslint eslint_d @typescript-eslint/parser " +
        "@typescript-eslint/eslint-plugin --save-dev")
      -- Generate tsconfig.json
      vim.fn.system("cd " .. project_path .. " && npx tsc --init")

      -- Create index.ts
      local main_ts = [[
console.log("Hello world from TypeScript project!");
]]
      local main_ts_path = project_path .. "/src/index.ts"
      local f = io.open(main_ts_path, "w")
      if f then
        f:write(main_ts)
        f:close()
      end

      -- Create .eslintrc file
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
    "sourceType": "module"
  },
  "rules": {}
}
]]
      local eslint_path = project_path .. "/.eslintrc.json"
      local e = io.open(eslint_path, "w")
      if not e then
        vim.notify("Cannot create .eslintrc.json", vim.log.levels.ERROR)
        return
      end
      e:write(eslint_conf)
      e:close()


      local pkg_path = project_path .. "/package.json"
      local f_pkg = io.open(pkg_path, "r")
      if not f_pkg then
        vim.notify("Cannot open package.json for reading", vim.log.levels.ERROR)
        return
      end
      local pkg_content = f_pkg:read("*a")
      f_pkg:close()

      local pkg = vim.json.decode(pkg_content)
      pkg.scripts = pkg.scripts or {}
      pkg.scripts.lint = "eslint . --ext .ts"
      pkg.scripts["lint:fix"] = "eslint . --ext .ts --fix"

      local f2 = io.open(pkg_path, "w")
      if not f2 then
        vim.notify("Cannot write package.json", vim.log.levels.ERROR)
        return
      end
      f2:write(vim.json.encode(pkg))
      f2:close()

      vim.loop.chdir(project_path)
      vim.cmd("edit " .. main_ts_path)
      vim.notify("Created TypeScript project with ESLint in: " .. project_path, vim.log.levels.INFO)
    end,
  },
  -- INFO: Projects Python
  python = {},
  -- INFO: Projects C
  c = {},
  -- INFO: Projects Rust
  rust = {},
}
