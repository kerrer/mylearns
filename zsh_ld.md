ld_sdk () {
  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="/home/max/.sdkman"
  [[ -s "/home/max/.sdkman/bin/sdkman-init.sh" ]] && source "/home/max/.sdkman/bin/sdkman-init.sh"
}

ld_gvm () {
  [[ -s "/home/max/.gvm/scripts/gvm" ]] && source "/home/max/.gvm/scripts/gvm"
}

ld_nvm () {
   export NVM_DIR="/home/max/.nvm"
   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

ld_jenv () {
   export PATH="$HOME/.jenv/bin:$PATH"
   eval "$(jenv init -)"
}

ld_perlbrew () {
   source ~/perl5/perlbrew/etc/bashrc
}

ld_rakudobrew () {
   export PATH=~/.rakudobrew/bin:$PATH
   rakudobrew init 
}
