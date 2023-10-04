//#
//
//# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
//# Run `pod lib lint pdf_text.podspec' to validate before publishing.
//#
//
//Pod::Spec.new do |s|
//s.
//name = 'pdf_text'
//s.
//version = '0.0.1'
//s.
//summary = 'A new flutter plugin project.'
//s.
//description =
//<<-
//DESC
//        A
//new
//flutter plugin
//project.
//DESC
//        s
//.
//homepage = 'http://example.com'
//s.
//license = {:file => '../LICENSE'}
//s.
//author = {'Your Company' => 'email@example.com'}
//s.
//source = {:path => '.'}
//s.
//source_files = 'Classes/**/*'
//s.dependency 'Flutter'
//s.
//platform =
//:ios, '11.0'
//
//# Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
//s.
//pod_target_xcconfig = {'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64'}
//s.
//swift_version = '5.0'
//end
#include <iostream>
#include <vector>

struct Podspec {
    std::string name;
    std::string version;
    std::string summary;
    std::string description;
    std::string homepage;
    std::string licenseFile;
    std::string authorName;
    std::string authorEmail;
    std::string sourcePath;
    std::vector<std::string> sourceFiles;
    std::vector<std::string> dependencies;
    std::string platformName;
    std::string platformVersion;
    std::string podTargetXcconfig;
    std::string swiftVersion;
};

int main() {
    Podspec podspec;
    podspec.name = "pdf_text";
    podspec.version = "0.0.1";
    podspec.summary = "A new flutter plugin project.";
    podspec.description = "A new flutter plugin project.";
    podspec.homepage = "http://example.com";
    podspec.licenseFile = "../LICENSE";
    podspec.authorName = "Your Company";
    podspec.authorEmail = "email@example.com";
    podspec.sourcePath = ".";
    podspec.sourceFiles = {"Classes/**/*"};
    podspec.dependencies = {"Flutter"};
    podspec.platformName = "ios";
    podspec.platformVersion = "11.0";
    podspec.podTargetXcconfig = "{'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64'}";
    podspec.swiftVersion = "5.0";
    // Now you can use 'podspec' to generate or process the C++ equivalent of the Podspec.
    return 0;
}
