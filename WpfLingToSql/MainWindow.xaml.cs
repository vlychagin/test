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

namespace WpfLingToSql
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private WheatherReportLVDataContext _db;

        public MainWindow()
        {
            InitializeComponent();
            _db = new WheatherReportLVDataContext();

            // Назначить обработчика событий закрытия окна - закрыть БД
            Closing += (s, e) => _db.Dispose();

            // привязка таблиц к элементам управления
            WheathersGrid.ItemsSource = _db.Wheathers.GetNewBindingList();            // к сетке отображения данных
            PrecipitationsCb.ItemsSource = _db.Precipitations.GetNewBindingList();    // к чек-боксу (ячейке сетке данных)
            RegionsCb.ItemsSource = _db.Regions.GetNewBindingList();                  // к чек-боксу (ячейке сетке данных)

        } // MainWindow

        // обработчик клика по кнопке "Обновить"
        private void Update_Click(object sender, RoutedEventArgs e)
        {
            try {
                // действия по обновлению таблицу
                _db.SubmitChanges();

                // действия по обновлению привязки
                WheathersGrid.ItemsSource = _db.Wheathers.GetNewBindingList();
                // Эти привязки к чек-боксам избыточны
                // PrecipitationsCb.ItemsSource = _db.Precipitations.GetNewBindingList();
                // RegionsCb.ItemsSource = _db.Regions.GetNewBindingList();
            } catch (Exception ex) {
                MessageBox.Show(ex.Message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            } // try-catch
        } // Update_Click

        // обработчик клика по кнопке "Удалить"
        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            try {
                // Если выбранных строк нет - выход
                if (WheathersGrid.SelectedItems.Count == 0) return;

                // Для каждой выбранной строки сетки отображения данных
                // удалить из копии таблицы (т.е. из коллекции в  контексте 
                // т.е. в объекте класса WheatherReportLVDataContext
                foreach (object t in WheathersGrid.SelectedItems) {
                    Wheathers w = t as Wheathers;
                    if (w != null) _db.Wheathers.DeleteOnSubmit(w);
                } // foreach

                // обновить БД  т.е. выполнить удаление
                _db.SubmitChanges();

                // обновить привязку к элементам управления
                WheathersGrid.ItemsSource = _db.Wheathers.GetNewBindingList();
                // Эти привязки к чек-боксам избыточны
                // PrecipitationsCb.ItemsSource = _db.Precipitations.GetNewBindingList();
                // RegionsCb.ItemsSource = _db.Regions.GetNewBindingList();
            } catch (Exception ex) {
                MessageBox.Show(ex.Message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            } // try-catch
        } // Delete_Click
    } // class MainWindow
}
