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
    /// Логика взаимодействия для RepairRequest.xaml
    /// </summary>
    public partial class RepairRequest : Window
    {
        bool check = false;
        public RepairRequest()
        {
            InitializeComponent();
        }
        private void Button_Click_ChBox(object sender, RoutedEventArgs e)
        {
            if (ChBox1.IsChecked == false) { ChBox1.IsChecked = true; }
            else { ChBox1.IsChecked = false; }
        }
    }
}