# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
DESCRIPTION="Code editing. Redefined."
HOMEPAGE="https://code.visualstudio.com/"
SRC_URI="https://update.code.visualstudio.com/${PV}/linux-x64/stable -> ${PN}-${PV}-x64.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	use amd64 && S="${WORKDIR}/VSCode-linux-x64" || die "Arch not supported"
}

src_install() {
	insinto /opt/visual-studio-code
	doins -r .
	doicon resources/app/resources/linux/code.png

	dosym /opt/visual-studio-code/code /usr/bin/code

	fperms +x /opt/visual-studio-code/code
	fperms +x /opt/visual-studio-code/libffmpeg.so
	fperms +x /opt/visual-studio-code/libnode.so
	fperms +x /opt/visual-studio-code/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg

	make_desktop_entry "/usr/bin/code %U" "Visual Studio Code" "code" \
		"TextEditor;Development;"

	pax-mark -m /opt/visual-studio-code/bin/code
}

pkg_postinst(){
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
