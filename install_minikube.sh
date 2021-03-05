#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    x_minikube_install                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: xvan-ham <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/29 19:17:47 by xvan-ham          #+#    #+#              #
#    Updated: 2020/10/29 19:17:47 by xvan-ham         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#  Colors
green=$'\e[0;92;40m'
cyan=$'\e[0;1;36;40m'
reset=$'\e[0m'

echo -e "${green}Installing ${cyan}minikube${green}.${reset}"
brew install minikube
echo -e "${cyan}Minikube ${green}installation done.${reset}"