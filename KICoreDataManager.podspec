Pod::Spec.new do |s|
  s.name         = "KICoreDataManager"
  s.version      = "0.0.1"
  s.summary      = "KICoreDataManager."

  s.description  = <<-DESC
                   KICoreDataManager
                    =================

                    一个用于快速集成CoreData的工具库


                    集成步骤:


                    1、创建DataModel（用默认名称Model就好，如果需要用特殊的名称，需要调用KICoreDataManager里面的setupWithModelName:dbSavePath方法进行配置），并添加Entity（比如 User）

                    2、根据Entity创建NSManagedObject subclass

                    3、如果需要用到NSFetchedResultsController，则需要为每个NSManagedObject subclass添加一个类方法+ (NSString *)defaultSortAttribute （可选）

                    4、在需要操作的地方导入KICoreDataManager.h文件


                    添加一条数据

                    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];

                    User *user = [User objectsWithContext:context]

                    user.age = ..

                    user.name = ...

                    ...

                    [context commitUpdate];


                    详见Sample Code

                   DESC

  s.homepage     = "https://github.com/smartwalle/KICoreDataManager"
  s.license      = "MIT"
  s.author       = { "SmartWalle" => "smartwalle@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/smartwalle/KICoreDataManager.git", :tag => "#{s.version}" }
  s.source_files  = "KICoreDataManager/KICoreDataManager/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.framework     = "CoreData"
  s.requires_arc  = true
end
