BOOK_CODE_PATH = "E:/book-code"
THIRD_PARTY = "E:/book-code/3rdparty"
WORK_PATH = os.getcwd()
includeexternal (BOOK_CODE_PATH .. "/premake-vs-include.lua")




workspace(path.getname(os.realpath(".")))
    language "C++"
    location "build/%{_ACTION}/%{wks.name}"    
    if _ACTION == "vs2015" then
        toolset "v140_xp"
    elseif _ACTION == "vs2013" then
        toolset "v120_xp"
    end

    --include (BOOK_CODE_PATH .. "/common.lua")    
    


    function create_example_project(name, dir)        
        project(name)          
        kind "ConsoleApp"                                             
        files
        {                                  
            dir .. "/%{prj.name}/**.h",
            dir .. "/%{prj.name}/**.cpp", 
            dir .. "/%{prj.name}/**.c", 
            dir .. "/%{prj.name}/**.rc",
            "3rdparty/scheduler/**"
        }
        removefiles
        {               
        }
        includedirs
        {               
            "3rdparty",          
        }         
        has_stdafx(name, dir)               
    end    
    

    group "sdl-examples"    

        matches = os.matchdirs("src/example*")
        for i = #matches, 1, -1 do           
            create_example_project(path.getname(matches[i]), "src")                
        end


        