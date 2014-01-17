: .. Copyright (C) 2012-2013 Bryan A. Jones.
:
:    This file is part of CodeChat.
:
:    CodeChat is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
:
:    CodeChat is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
:
:    You should have received a copy of the GNU General Public License along with CodeChat.  If not, see <http://www.gnu.org/licenses/>.
:
:
: .. highlight:: bat
:
: ******************************************************************************
: build_exe.bat - Build a self-contained executable for the CodeChat application
: ******************************************************************************
: This file creates a Windows executable using `Pyinstaller <http://www.pyinstaller.org/>`_. This is the first step in the :ref:`build system <build_system>`.
:
: Convert CodeChat to an executable
: =================================
: .. toctree::
:    :hidden:
:
:    rthook_pyqt4.py
:    hook-CodeChat.py
:
: `Options <http://htmlpreview.github.io/?https://github.com/pyinstaller/pyinstaller/blob/develop/doc/Manual.html#options>`_ are:
:
: -y
:   Replace an existing executable folder or file without warning.
:
: --additional-hooks-dir=hook-path
: 	Additional path to search for hook files. The root directory contains :doc:`hook-CodeChat.py <hook-CodeChat.py>`, which is needed to correctly bulid CodeChat.
:
: --runtime-hook=path-to-hook-file
:   Specify a file with a custom runtime hook. Here, :doc:`rthook_pyqt4.py <rthook_pyqt4.py>` overrides the SIP API as needed by :ref:`CodeChat <sip_api_2>`.
:
: --noconsole
:   On Windows and Mac OS X, do not create a console window
:   at run time for standard input/output.
:
: ``code_chat.py``
:   CodeChat entry point, from which Pyinstaller builds the application.
..\pyinstaller-git\pyinstaller.py -y --additional-hooks-dir=. --runtime-hook=rthook_pyqt4.py --noconsole code_chat.py
:
: Copy template files
: ===================
: Copy over template files which CodeChat uses for creating a new project and delete junk (which shouldn't be copied when crating a new project). **Note:** the first copy is really a kludgy symbolic link. I haven't found a better way to do this.
copy /Y default.css template
xcopy /E /I template dist\code_chat\template
del dist\code_chat\template\conf.py.rst
:
: Run the resulting binary
: ========================
: Finally, run the application to make sure it works. This also updates the generated documentation for packaging, assuming this directory is selected as CodeChat's project directory.
dist\code_chat\code_chat
