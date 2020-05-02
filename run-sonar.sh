#!/bin/bash
cd $WORKSPACE
#xcodebuild -workspace UITableViewDynamicLayoutCacheHeight.xcworkspace -scheme xxx clean build | tee xcodebuild.log | xcpretty --report json-compilation-database

mv build/reports/compilation_db.json compile_commands.json
oclint-json-compilation-database -exclude Pods -- -report-type pmd -o oclint.xml -max-priority-1 99999 -max-priority-2 99999 -max-priority-3 99999 -rc LONG_LINE=140 -rc LONG_METHOD=80 -rc NCSS_METHOD=50 -rc SHORT_VARIABLE_NAME=1 -rc CYCLOMATIC_COMPLEXITY=13 -rc MINIMUM_CASES_IN_SWITCH=2 -rc NPATH_COMPLEXITY=1500

rm -rf sonar-reports
mkdir sonar-reports

cat oclint.xml  | sed "s#Switch Statements Should Have Default Rule#switch statements should have default#g" \
| sed "s#missing hash method#must override hash with isEqual#g" \
| sed "s#prefer early exits and continue#use early exits and continue#g" \
| sed "s#use boxed expression#replace with boxed expression#g" \
| sed "s#use container literal#replace with container literal#g" \
| sed "s#use number literal#replace with number literal#g" \
| sed "s#use object subscripting#replace with object subscripting#g" \
| sed "s#missing default in switch statements#switch statements should have default#g" \
| sed "s#unnecessary default statement in covered switch statement#switch statements don't need default when fully covered#g" \
| sed "s#covered switch statements dont need default#switch statements don't need default when fully covered#g" > sonar-reports/oclint.xml
rm -f sonar-project.properties

cat > sonar-project.properties <<- EOF
sonar.projectKey=xxx-iOS
sonar.projectName=xxx-iOS
sonar.projectVersion=x.x.x
sonar.language=objectivec
sonar.sources=sources
sonar.sourceEncoding=UTF-8
sonar.objectivec.oclint.reportPath=sonar-reports/oclint.xml
EOF

/bin/sh sonar-scanner -X
