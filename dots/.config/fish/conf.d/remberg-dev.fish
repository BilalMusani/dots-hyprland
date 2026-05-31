# Remberg development aliases

alias start-backend="cd ~/remberg && yarn start:backend --hot-reload=off"
alias start-frontend="cd ~/remberg && yarn start:frontend"
alias start-e2e="cd ~/remberg && yarn nx test-e2e @remberg/test/frontend --watch"
alias start-e2e-dev="yarn nx test-e2e @remberg/test/frontend --configuration=dev-backend --watch"
alias start-e2e-staging="yarn nx test-e2e @remberg/test/frontend --configuration=staging-backend --watch"

## killing statically served services
function kill-analytics
    set port_number 8094
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-crm
    set port_number 8095
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-emails
    set port_number 8092
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-field-operations
    set port_number 8091
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-files
    set port_number 8093
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-notifications
    set port_number 8088
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-parts
    set port_number 8102
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-sync
    set port_number 8087
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-tasks
    set port_number 8099
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-tasks-old
    set port_number 8086
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-tenants
    set port_number 8098
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-tickets
    set port_number 8084
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

function kill-users
    set port_number 8097
    set pid (lsof -t -i:$port_number)
    if test -n "$pid"
        echo "Killing process $pid using port $port_number"
        kill -9 $pid
    else
        echo "No process found using port $port_number"
    end
end

## starting dynamically services
alias serve-analytics="kill-analytics && cd ~/remberg && yarn nx run @remberg/services-analytics:serve"
alias serve-crm="kill-crm && cd ~/remberg && yarn nx run @remberg/services-crm:serve"
alias serve-emails="kill-emails && cd ~/remberg && yarn nx run @remberg/services-emails:serve"
alias serve-field-operations="kill-field-operations && cd ~/remberg && yarn nx run @remberg/services-field-operations:serve"
alias serve-files="kill-files && cd ~/remberg && yarn nx run @remberg/services-files:serve"
alias serve-notifications="kill-notifications && cd ~/remberg && yarn nx run @remberg/services-notifications:serve"
alias serve-parts="kill-parts && cd ~/remberg && yarn nx run @remberg/services-parts:serve"
alias serve-sync="kill-sync && cd ~/remberg && yarn nx run @remberg/services-sync:serve"
alias serve-tasks="kill-tasks && cd ~/remberg && yarn nx run @remberg/services-tasks:serve"
alias serve-tasks-old="kill-tasks-old && cd ~/remberg && yarn nx run @remberg/services-tasks-old:serve"
alias serve-tenants="kill-tenants && cd ~/remberg && yarn nx run @remberg/services-tenants:serve"
alias serve-tickets="kill-tickets && cd ~/remberg && yarn nx run @remberg/services-tickets:serve"
alias serve-users="kill-users && cd ~/remberg && yarn nx run @remberg/services-users:serve"
function serve-jobs-a
    kill -9 (lsof -t -i:8618) 2>/dev/null; or true
    cd ~/remberg && yarn nx serve @remberg/jobs-job-pool-a
end

function serve-jobs-b
    kill -9 (lsof -t -i:8619) 2>/dev/null; or true
    cd ~/remberg && yarn nx serve @remberg/jobs-job-pool-b
end

function serve-local-jobs
    kill -9 (lsof -t -i:8620) 2>/dev/null; or true
    cd ~/remberg && yarn nx serve @remberg/jobs-local-jobs
end
