{ pkgs, config, withGUI }: {
  enable = withGUI;

  mutableExtensionsDir = true;

  profiles.default = {
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
      mshr-h.veriloghdl
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
      saoudrizwan.claude-dev
      shardulm94.trailing-spaces
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
        sha256 = "Ye2W0uDe2/XQF+kg3FSItWbyqIbjCtsUxfO7zvr6boQ=";
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
        name = "gti-vscode";
        publisher = "graphite";
        version = "latest";
        sha256 = "gGpWj1iVz6nYgMk7RuYgvIf9E8Yq0lt9PZnhLLDO7So=";
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
        sha256 = "Q6wfbm3FMNe0VB29QOf5ulTelGVmZVHUnmK17vbrqWc=";
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
        sha256 = "tCNkC7qa59oL9TXA+OKN0Tq5wl0TOLJhHpiKRLmMlgo=";
      }
      {
        name = "remote-server";
        publisher = "ms-vscode";
        version = "latest";
        sha256 = "m9P8WFb3qYGF/oL4f6kHQSwd+YCc4vsx1XFhkiQE1B8=";
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
        sha256 = "RxOA6xQ29JuB0NzEqMDkF9W1U+AsvgAOzGbtIUw0WyM=";
      }
    ];


    userSettings = {
      application.shellEnvironmentResolutionTimeout = 30;
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
        trimTrailingWhitespace = true;
      };

      git = {
        autofetch = true;
        openRepositoryInParentFolders = "never";
      };

      github.copilot = {
        editor.enableAutoCompletions = true;
        nextEditSuggestions.enabled = true;
        chat.scopeSelection = true;
      };

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
            "christian-kohler.npm-intellisense"
            "christian-kohler.path-intellisense"
            "coolbear.systemd-unit-file"
            "cschlosser.doxdocgen"
            "dawhite.mustache"
            "davidanson.vscode-markdownlint"
            "dbaeumer.vscode-eslint"
            "dracula-theme.theme-dracula"
            "eamodio.gitlens"
            "editorconfig.editorconfig"
            "esbenp.prettier-vscode"
            "github.copilot"
            "go2sh.tcl-language-support"
            "graphite.gti-vscode"
            "jeff-hykin.better-cpp-syntax"
            "liviuschera.noctis"
            "mhutchie.git-graph"
            "ms-python.black-formatter"
            "ms-python.debugpy"
            "ms-python.flake8"
            "ms-python.isort"
            "ms-python.mypy-type-checker"
            "ms-python.pylint"
            "ms-python.python"
            "ms-python.vscode-pylance"
            "ms-vscode.cmake-tools"
            "ms-vscode.cpptools"
            "ms-vscode.cpptools-extension-pack"
            "ms-vscode.cpptools-themes"
            "ms-vscode.makefile-tools"
            "ms-vscode.test-adapter-converter"
            "mshr-h.veriloghdl"
            "naco-siren.gradle-language"
            "nwgh.bandit"
            "orta.vscode-jest"
            "redhat.vscode-yaml"
            "rubymaniac.vscode-direnv"
            "saoudrizwan.claude-dev"
            "shardulm94.trailing-spaces"
            "sleutho.tcl"
            "timonwong.shellcheck"
            "twxs.cmake"
            "usernamehw.errorlens"
            "visualstudioexptteam.vscodeintellicode"
            "vscode-icons-team.vscode-icons"
            "vscjava.vscode-gradle"
            "vscjava.vscode-java-debug"
            "vscjava.vscode-java-dependency"
            "vscjava.vscode-java-pack"
            "vscjava.vscode-java-test"
            "vscodevim.vim"
            "wakatime.vscode-wakatime"
            "yoavbls.pretty-ts-errors"
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

      vim.handleKeys = {
          "<C-p>" = false;
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
  };
}
