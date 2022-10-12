git_current_branch () {
    local ref
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]
    then
        [[ $ret == 128 ]] && return
        ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return
    fi
    echo ${ref#refs/heads/}
}

ldapuser() {
    ldapsearch -H ldap://xldap.cern.ch -x -b "OU=Users,OU=Organic Units,DC=cern,DC=ch" "CN=$1"
}

ldapuserf() {
     ldapsearch -H ldap://xldap.cern.ch -x -b "OU=Users,OU=Organic Units,DC=cern,DC=ch" "$1"
} 

ldaplw() {
    ldapsearch -H ldap://xldap.cern.ch -x -b "OU=Externals,DC=cern,DC=ch" "mail=$1"
}

ldapgroup() {
    ldapsearch -H ldap://xldap.cern.ch -x -b "OU=Workgroups,DC=cern,DC=ch" "CN=$1"
}

sshdel() {
    if  [ -z "$1" ]
    then
	   echo "Usage: sshdel [host]"
    else 
           sed -i /$1/d ~/.ssh/known_hosts
    fi
}

