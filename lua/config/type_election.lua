return  {
  java = {
    -- To make a new project Gradle
    gradle = function()
      vim.cmd("echo 'Create a Gradle proyect'")
      local project_name = vim.fn.input("Name of project (Gradle): ")
      if project_name == "" then
        vim.notify("Error: You must provide a name for the project.", vim.log.levels.ERROR)
        return
      end
      -- Define paths and names
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      local main_class = "Main"
      local package_name = "com.damianp." .. project_name
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
    -- #############################################################################
    -- To make a new project Maven
    maven = function()
      vim.cmd("echo 'Create Maven proyect'")
      local project_name = vim.fn.input("Name of project (Maven): ")
      if project_name == "" then
        vim.notify("Error: You must provide a name for the project.", vim.log.levels.ERROR)
        return
      end
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      --local main_class = "Main"
      local package_name = "com.damianp." .. project_name
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
    -- #############################################################################
    --  To make a new project Ant
    ant = function()
      vim.cmd("echo 'Create Ant project'")
      local project_name = vim.fn.input("Name of project (Ant): ")
      if project_name == "" then
        vim.notify("Error: You must provide a name for the project.", vim.log.levels.ERROR)
        return
      end
      local cwd = vim.fn.getcwd()
      local project_path = cwd .. "/" .. project_name
      local package_name = "com.damianp." .. project_name
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
    end
  },
  python = {},

  c = {},

  rust = {},
}
