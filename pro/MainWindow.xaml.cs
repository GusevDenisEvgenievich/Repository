using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace pro
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            string login = LoginTextBox.Text;
            string password = PasswordBox.Password;

            // Имитация проверки логина и пароля
            if (AuthenticateUser(login, password))
            {
                // Создаем новую страницу StartPage
                StartPage startPage = new StartPage();
                // Открываем новую страницу в новом окне
                startPage.Show();

                // Закрываем текущее окно авторизации
                this.Close();
            }
            else
            {
                MessageBox.Show("Неверный логин или пароль.");
            }
        }

        private bool AuthenticateUser(string login, string password)
        {
            // Здесь поместите логику проверки логина и пароля
            // Например, проверка на совпадение с заранее определенными значениями
            return login == "user" && password == "password"; // Замените на вашу логику
        }
    }
}