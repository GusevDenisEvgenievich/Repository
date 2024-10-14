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

namespace pro
{
    /// <summary>
    /// Логика взаимодействия для Realization.xaml
    /// </summary>
    public partial class Realization : Window
    {
        public Realization()
        {
            InitializeComponent();
        }
        private void Logout_Click(object sender, RoutedEventArgs e)
        {
            // Выводим сообщение пользователю о выходе
            MessageBoxResult result = MessageBox.Show(
                "Вы уверены, что хотите выйти?",
                "Подтверждение выхода",
                MessageBoxButton.YesNo,
                MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                // Здесь можно добавить код для очистки данных пользователя, если это необходимо

                // Создание и открытие окна MainWindow
                MainWindow mainWindow = new MainWindow();
                mainWindow.Show();

                // Закрытие текущего окна (выход из приложения)
                this.Close();
            }
        }
    }
}
