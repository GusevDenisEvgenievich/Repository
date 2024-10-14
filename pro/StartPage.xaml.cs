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
    /// Логика взаимодействия для StartPage.xaml
    /// </summary>
    public partial class StartPage : Window
    {
        private Button _activeButton;

        public StartPage()
        {
            InitializeComponent();
        }

        private void NavigationButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button clickedButton)
            {
                SetActiveButton(clickedButton);

                // Здесь можно добавить логику для открытия соответствующей страницы
                // Например, используя Frame или другие механизмы.
            }
        }

        private void SetActiveButton(Button button)
        {
            if (_activeButton != null)
            {
                _activeButton.Background = Brushes.DarkGray; // Сброс цвета активной кнопки
                _activeButton.Foreground = Brushes.White; // Установка исходного цвета текста
            }

            _activeButton = button; // Установка новой активной кнопки
            _activeButton.Background = Brushes.Gray; // Выделение новой активной кнопки
            _activeButton.Foreground = Brushes.Black; // Установка нового цвета текста
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
