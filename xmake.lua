add_rules("mode.debug", "mode.release")

set_languages("c++20")


function project(config)
    target(config.projectname)
        set_kind(config.kind)
        set_targetdir(config.targetdir)

        add_files(config.files)
        add_includedirs(config.includedirs)
        add_links(config.links)
        add_linkdirs(config.linkdirs)
        if config.deps ~= nil then 
            add_deps(config.deps)
        end

        if is_mode("release") then 
            set_optimize("fastest")
            if is_plat("windows") then
                set_runtimes("MD")
                add_cxflags("/Zi", "/W0", "/MP", "/Ob2", "/Oi", "/Ot", "/Oy", "/GT", "/GF", "/GS-", "/Gy", "/arch:AVX2",
                    "/fp:precise", "/Gr", "/TP", "/Zc:preprocessor", {
                        force = true
                    })
            end
        else 
            set_optimize("none")
            if is_plat("windows") then
                set_runtimes("MDd")
                add_cxflags("/Zi", "/W0", "/MP", "/Ob0", "/Oy-", "/GF", "/GS", "/arch:AVX2", "/fp:precise", "/Gr", "/TP",
                    "/Zc:preprocessor", {
                    force = true
                })
            end
        end
end

project({
    projectname = "cpp",
    kind = "binary",
    targetdir = "target",
    files = {"src/*.cpp"},
    includedirs = {"ext", "include"},
})

