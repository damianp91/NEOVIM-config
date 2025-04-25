return {
  java = {
    -- To make a new project Java with Gradle
    -- vim.keymap.set('n', '<leader>ng', function()
    gradle = function()
      vim.cmd("echo 'Create a Gradle proyect'")
      local project_name = vim.fn.input("Name of project (Gradle): ")
      if project_name == "" then
        print("Error: You must provide a name for the project.")
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
        print("Created build.gradle")
      else
        print("Error: Could not create build.gradle")
      end
      -- Create settings.gradle file
      local settings_gradle = "rootProject.name = '" .. project_name .. "'"
      local settings_gradle_path = project_path .. "/settings.gradle"
      local settings_gradle_file = io.open(settings_gradle_path, "w")
      if settings_gradle_file then
        settings_gradle_file:write(settings_gradle)
        settings_gradle_file:close()
        print("Created settings.gradle")
      else
        print("Error: Could not create settings.gradle")
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
        print("Created Main.java")
      else
        print("Error: Could not create file Main.java")
      end
      -- Open Main.java and set the project directory
      vim.cmd("edit " .. main_java_path)
      vim.cmd("cd " .. project_path)
      print("Created project in: " .. project_path)
    end,

    -- Keymap for creating a Maven project
    maven = function()
      vim.cmd("echo 'Create Maven proyect'")
      local project_name = vim.fn.input("Name of project (Maven): ")
      if project_name == "" then
        print("Error: You must provide a name for the project.")
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
        print("Created pom.xml")
      else
        print("Error: Could not create pom.xml")
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
        print("Created Main.java")
      else
        print("Error: Could not create Main.java")
      end
      vim.cmd("edit " .. main_java_path)     -- Open Main.java in Neovim
      vim.cmd("cd " .. project_path)         -- Move to project directory
      print("Created Maven project in: " .. project_path)
    end,
  },

  -- More language

}
