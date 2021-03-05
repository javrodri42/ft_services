#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    x_minikube_setup                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: xvan-ham <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/29 19:25:14 by xvan-ham          #+#    #+#              #
#    Updated: 2020/10/29 19:25:14 by xvan-ham         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#  Colors
green=$'\e[0;92;40m'
cyan=$'\e[0;1;36;40m'
reset=$'\e[0m'

echo -e "${green}Setting up ${cyan}minikube${green} in ${cyan}goinfre.${reset}"
mkdir -p /goinfre/$USER
mkdir -p /goinfre/$USER/.minikube
ln -s /goinfre/$USER/.minikube ~/.minikube
echo -e "${cyan}Minikube ${green}is correctly linked to goinfre.${reset}"