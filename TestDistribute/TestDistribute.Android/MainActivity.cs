using System;

using Android.App;
using Android.Content.PM;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;
using Microsoft.AppCenter;
using Microsoft.AppCenter.Distribute;

namespace TestDistribute.Droid
{
    [Activity(Icon = "@mipmap/icon",
        Theme = "@style/MainTheme",
        MainLauncher = true,
        ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation)]
    public class MainActivity : global::Xamarin.Forms.Platform.Android.FormsAppCompatActivity
    {
        protected override void OnCreate(Bundle savedInstanceState)
        {
            TabLayoutResource = Resource.Layout.Tabbar;
            ToolbarResource = Resource.Layout.Toolbar;

            base.OnCreate(savedInstanceState);
            global::Xamarin.Forms.Forms.Init(this, savedInstanceState);

            var token = PackageManager.GetApplicationInfo(PackageName, PackageInfoFlags.MetaData).MetaData.GetString("APPCENTER_TOKEN");

            Console.WriteLine($"-----{token}");

            AppCenter.Start(token, typeof(Distribute));

            LoadApplication(new App());
        }
    }
}