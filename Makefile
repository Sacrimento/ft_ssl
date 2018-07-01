SRC_NAME = main.c
OBJ_NAME = $(SRC_NAME:.c=.o)
INC_NAME = ft_ssl.h

OBJDIR = ./obj/
INCDIR = ./includes/
SRCDIR = ./src/

NAME = ft_ssl
FLAGS = -Wall -Werror -Wextra #-g -fsanitize=address,undefined
CC = gcc

SRC = $(addprefix $(SRCDIR), $(SRC_NAME))
INC = $(addprefix $(INCDIR), $(INC_NAME))
OBJ = $(addprefix $(OBJDIR), $(OBJ_NAME))

LIBDIR = libft/
LIBFT = libft/libft.a

.PHONY: all, $(NAME), $(LIBFT), clean, fclean, re, norme

all: $(NAME)

$(NAME): $(LIBFT) $(OBJ)
	$(CC) -o $(NAME) $(OBJ) $(LIBFT)

$(OBJDIR)%.o: $(SRCDIR)%.c
	@mkdir -p $(OBJDIR)
	$(CC) -o $@ -c $< $(FLAGS) -I $(INCDIR)

$(LIBFT):
	@make -C $(LIBDIR)

norme:
	@norminette $(SRC) $(INC) | grep "Error\|Warning"
	make -C $(LIBDIR) norme

clean:
	@rm -rf $(OBJDIR)
	@make -C $(LIBDIR) clean

fclean: clean
	@rm -f $(NAME)
	@make -C $(LIBDIR) fclean

re: fclean all