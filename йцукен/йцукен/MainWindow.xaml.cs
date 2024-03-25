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

namespace йцукен
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
        private void Button_Click_Registration(object sender, RoutedEventArgs e)
        {
            this.Hide();
            Registration RegistrationForm = new Registration();
            RegistrationForm.Show();
        }
        private void Button_Click_Close(object sender, RoutedEventArgs e)
        {
            this.Hide();
        }
        private void Button_Click_Client(object sender, RoutedEventArgs e)
        {
            this.Hide();
            Client ClientForm = new Client();
            ClientForm.Show();
        }
        private void Button_Click_Repair(object sender, RoutedEventArgs e)
        {
            this.Hide();
            RepairRequest Repair = new RepairRequest();
            Repair.Show();
        }
    }
}
