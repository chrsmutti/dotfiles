function use-java
    set -l java_version $argv[1]
    echo "Setting JAVA_HOME to Java $java_version"
    cs java --jvm $java_version --env | source
end