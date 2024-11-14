{ pkgs, config, withGUI }: {
  enable = withGUI;

  extensions = (with pkgs.vscode-extensions; [
    alefragnani.project-manager
    bbenoist.nix
    coder.coder-remote
    coolbear.systemd-unit-file
    christian-kohler.path-intellisense
    christian-kohler.npm-intellisense
    davidanson.vscode-markdownlint
    dbaeumer.vscode-eslint
    dracula-theme.theme-dracula
    eamodio.gitlens
    editorconfig.editorconfig
    esbenp.prettier-vscode
    github.copilot
    #github.copilot-chat
    #hbenl.vscode-test-explorer
    #mesonbuild.mesonbuild
    mhutchie.git-graph
    ms-azuretools.vscode-docker
    #mshr-h.veriloghdl
    ms-python.black-formatter
    ms-python.debugpy
    ms-python.flake8
    ms-python.isort
    ms-python.pylint
    ms-python.python
    ms-python.vscode-pylance
    ms-vscode.cmake-tools
    ms-vscode.cpptools-extension-pack
    ms-vscode.makefile-tools
    ms-vscode.test-adapter-converter
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-wsl
    redhat.java
    redhat.vscode-yaml
    shardulm94.trailing-spaces
    streetsidesoftware.code-spell-checker
    #suoto.hdl-checker-client
    timonwong.shellcheck
    twxs.cmake
    usernamehw.errorlens
    visualstudioexptteam.vscodeintellicode
    vscjava.vscode-java-debug
    vscjava.vscode-java-dependency
    vscjava.vscode-gradle
    vscjava.vscode-java-pack
    vscjava.vscode-java-test
    vscode-icons-team.vscode-icons
    vscodevim.vim
    wakatime.vscode-wakatime
    yoavbls.pretty-ts-errors

  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "bandit";
      publisher = "nwgh";
      version = "latest";
      sha256 = "Hx9Fy+HNG9gtkG39iU+CnAj7IwmWImb/c4niiPcL0n0=";
    }
    {
      name = "better-cpp-syntax";
      publisher = "jeff-hykin";
      version = "latest";
      sha256 = "GO/ooq50KLFsiEuimqTbD/mauQYcD/p2keHYo/6L9gw=";
    }
    {
      name = "cpptools";
      publisher = "ms-vscode";
      version = "latest";
      sha256 = "dY9NpeuiweGOIJLrQlH95U1W6KvjneeDUveRj/XIV+I=";
    }
    {
      name = "cpptools-themes";
      publisher = "ms-vscode";
      version = "latest";
      sha256 = "YWA5UsA+cgvI66uB9d9smwghmsqf3vZPFNpSCK+DJxc=";
    }
    {
      name = "doxdocgen";
      publisher = "cschlosser";
      version = "latest";
      sha256 = "InEfF1X7AgtsV47h8WWq5DZh6k/wxYhl2r/pLZz9JbU=";
    }
    {
      name = "gradle-language";
      publisher = "naco-siren";
      version = "latest";
      sha256 = "jns1Es2PMXusE7zFYpdeHGNoPrlhq1OslHRWUP3un5Y=";
    }
    {
      name = "mustache";
      publisher = "dawhite";
      version = "latest";
      sha256 = "PkymMex1icvDN2Df38EIuV1O9TkMNWP2sGOjl1+xGMk=";
    }
    {
      name = "mypy-type-checker";
      publisher = "ms-python";
      version = "latest";
      sha256 = "shOk51jru2xHq+LU3AoMRV4Rp5+nnlYear70FI+8mRQ=";
    }
    {
      name = "noctis";
      publisher = "liviuschera";
      version = "latest";
      sha256 = "RMYeW1J3VNiqYGj+2+WzC5X4Al9k5YWmwOyedFnOc1I=";
    }
    {
      name = "remote-explorer";
      publisher = "ms-vscode";
      version = "latest";
      sha256 = "U7P4GkjIk+WRAY1Ng5AMx2EiCwEsXY0Rt+b+4fBSJms=";
    }
    {
      name = "remote-server";
      publisher = "ms-vscode";
      version = "latest";
      sha256 = "G/o4oev8JhvDVcQ1G+IC6kT8L11G5tqSn2kVzLiIrME=";
    }
    {
      name = "tcl";
      publisher = "sleutho";
      version = "latest";
      sha256 = "R1OgLvengpH8F9AKg9EymzM2YYjPWIlnrDDMvzJapuo=";
    }
    {
      name = "tcl-language-support";
      publisher = "go2sh";
      version = "latest";
      sha256 = "SfgbBL2DY32NLtTpkohisDh9Vd+R5g/r35NK1xTmlHo=";
    }
    {
      name = "vscode-direnv";
      publisher = "rubymaniac";
      version = "latest";
      sha256 = "TVvjKdKXeExpnyUh+fDPl+eSdlQzh7lt8xSfw1YgtL4=";
    }
    {
      name = "vscode-jest";
      publisher = "orta";
      version = "latest";
      sha256 = "RB+V7MzoEfEx8ANwDbmsCOQltKp2+e6/eBgIzLx4Uis=";
    }
    {
      name = "vscode-pets";
      publisher = "tonybaloney";
      version = "latest";
      sha256 = "ZWJW5Y2jzJlTgnys2GF+5tDBEsn3yZUqlGeYwwBf9zo=";
    }
  ];


  userSettings = {
    breadcrumbs.enabled = true;

    "[c]" = {
      editor.defaultFormatter = "ms-vscode.cpptools";
    };

    cmake = {
      configureOnOpen = true;
      showOptionsMovedNotification = false;
      pinnedCommands = [
        "workbench.action.tasks.configureTaskRunner"
        "workbench.action.tasks.runTask"
      ];
    };

    coder = {
      tlsCertFile = "${config.home.homeDirectory}/.metatron/certificates/client.crt";
      tlsKeyFile = "${config.home.homeDirectory}/.metatron/certificates/client.key";
    };

    cSpell = {
      enabled = true;
      language = "en";
      maxNumberOfProblems = 100;
      showStatus = true;
      showStatusWithCount = true;
      showSuggestions = true;
      spellCheckDelayMs = 50;
      suggestCompoundWords = true;
      words = [
        "agelter"
        "avtnt"
        "bitfile"
        "bitstream"
        "dockerregistery"
        "elevenmax"
        "metatron"
        "petalinux"
        "vivado"
        "vitis"
        "xsct"
        "xilinx"
      ];
    };

    C_Cpp = {
      codeAnalysis = {
        clangTidy = {
          enabled = true;
          path = "${config.home.homeDirectory}/.nix-profile/bin/clang-tidy";
          clang_format_path = "${config.home.homeDirectory}/.nix-profile/bin/clang-format";
        };
      };
    };

    editor = {
      bracketPairColorization.enabled = true;
      cursorStyle = "line";
      formatOnSave = false;
      guides.bracketPairs = "active";
      inlineSuggest.enabled = true;
      lineNumbers = "on";
      minimap.enabled = false;
      renderWhitespace = "none";
      suggestSelection = "first";
      wordSeparators = "/\\()\"':,.;<>~!@#$%^&*|+=[]{}`?-";
      wordWrap = "off";
    };

    explorer.confirmDragAndDrop = false;

    files = {
      associations = {
        rules = "makefile";
      };
      autoSave = "afterDelay";
      eol = "\n";
      exclude = {
        "**/.git" = true;
        "**/.svn" = true;
        "**/.hg" = true;
        "**/CVS" = true;
        "**/.DS_Store" = true;
        "**/*.pyc" = true;
        "**/__pycache__" = true;
      };
    };

    git = {
      autofetch = true;
      openRepositoryInParentFolders = "never";
    };

    github.copilot.editor.enableAutoCompletions = true;
    gitlens.hovers.currentLine.over = "line";

    java.semanticHighlighting.enabled = true;
    javascript.updateImportsOnFileMove.enabled = "always";

    "[javascript]" = {
      editor.defaultFormatter = "vscode.typescript-language-features";
    };

    jenkins.pipeline.linter.connector.url = "https://opseng.builds.test.netflix.net/pipeline-model-converter/validate";

    "[jsonc]" = {
      editor.defaultFormatter = "vscode.json-language-features";
    };

    makefile.configureOnOpen = true;
    mesonbuild.configureOnOpen = true;
    npm.keybindingsChangedWarningShown = true;

    projectManager = {
      git.baseFolders = [
        "${config.home.homeDirectory}/src/"
      ];
      sortList = "Recent";
    };

    python = {
      analysis = {
        stubPath = "stubs";
        typeCheckingMode = "strict";
      };
      languageServer = "Pylance";
    };

    "[python]" = {
      editor = {
        formatOnType = true;
        defaultFormatter = "ms-python.black-formatter";
      };
    };

    remote = {
      SSH = {
        connectTimeout = 1800;
        defaultExtensions = [
          "coolbear.systemd-unit-file"
          "christian-kohler.path-intellisense"
          "christian-kohler.npm-intellisense"
          "davidanson.vscode-markdownlint"
          "dbaeumer.vscode-eslint"
          "dracula-theme.theme-dracula"
          "eamodio.gitlens"
          "editorconfig.editorconfig"
          "esbenp.prettier-vscode"
          "github.copilot"
          "mhutchie.git-graph"
          "ms-python.black-formatter"
          "ms-python.debugpy"
          "ms-python.flake8"
          "ms-python.isort"
          "ms-python.pylint"
          "ms-python.python"
          "ms-python.vscode-pylance"
          "ms-vscode.cmake-tools"
          "ms-vscode.cpptools-extension-pack"
          "ms-vscode.makefile-tools"
          "ms-vscode.test-adapter-converter"
          "redhat.vscode-yaml"
          "shardulm94.trailing-spaces"
          "streetsidesoftware.code-spell-checker"
          "timonwong.shellcheck"
          "twxs.cmake"
          "usernamehw.errorlens"
          "visualstudioexptteam.vscodeintellicode"
          "vscjava.vscode-java-debug"
          "vscjava.vscode-java-dependency"
          "vscjava.vscode-gradle"
          "vscjava.vscode-java-pack"
          "vscjava.vscode-java-test"
          "vscode-icons-team.vscode-icons"
          "vscodevim.vim"
          "wakatime.vscode-wakatime"
          "yoavbls.pretty-ts-errors"
          "nwgh.bandit"
          "jeff-hykin.better-cpp-syntax"
          "ms-vscode.cpptools"
          "ms-vscode.cpptools-themes"
          "cschlosser.doxdocgen"
          "naco-siren.gradle-language"
          "dawhite.mustache"
          "ms-python.mypy-type-checker"
          "liviuschera.noctis"
          "sleutho.tcl"
          "go2sh.tcl-language-support"
          "rubymaniac.vscode-direnv"
          "orta.vscode-jest"
        ];
      };
    };

    security.workspace.trust.untrustedFiles = "open";

    shellcheck = {
      executablePath = "${config.home.homeDirectory}/.nix-profile/bin/shellcheck";
      customArgs = ["-x"];
      exclude = ["SC1090"];
    };

    terminal = {
      integrated = {
        fontFamily = "'Source Code Pro for Powerline', 'Hack Nerd Font'";
        rendererType = "dom";
        shellIntegration.enabled = true;
      };
    };

    vsicons.dontShowNewVersionMessage = true;

    workbench = {
      colorTheme = "Noctis Obscuro";
      iconTheme = "vscode-icons";
      editor = {
        decorations = {
          badges = true;
          colors = true;
        };
      };
    };
  };
}