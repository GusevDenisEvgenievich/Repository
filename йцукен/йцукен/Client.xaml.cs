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
using System.Windows.Shapes;

namespace йцукен
{
    /// <summary>
    /// Логика взаимодействия для Client.xaml
    /// </summary>
    public partial class Client : Window
    {
        public Client()
        {
            InitializeComponent();
        }
        private void Button_Click_Back(object sender, RoutedEventArgs e)
        {
            this.Hide();
            MainWindow Authorization = new MainWindow();
            Authorization.Show();
        }
        private void Button_Click_Profile(object sender, RoutedEventArgs e)
        {
            Registration RegistrationForm = new Registration();
            RegistrationForm.Show();
        }
        private void Button_Click_Exit(object sender, RoutedEventArgs e)
        {
            this.Hide();
            MainWindow Authorization = new MainWindow();
            Authorization.Show();
        }
    }
}
