# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit autotools cvs eutils python prefix

DESCRIPTION="A 3D framework in C++ with python bindings"
HOMEPAGE="http://panda3d.org"
SRC_URI=""
ECVS_SERVER="panda3d.cvs.sourceforge.net:/cvsroot/panda3d"
ECVS_MODULE="panda3d"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64-linux ~x86"
IUSE="+cg doc ffmpeg fftw fmod +gtk jpeg ode +openal opencv png +python ssl
+threads tiff truetype +xml +zlib"

RDEPEND="cg? ( media-gfx/nvidia-cg-toolkit )
		dev-libs/libtar
		doc? ( dev-python/epydoc )
		ffmpeg? ( media-video/ffmpeg )
		fftw? ( sci-libs/fftw )
		fmod? ( media-libs/fmod )
		gtk? ( x11-libs/gtk+ )
		jpeg? ( media-libs/jpeg )
		ode? ( dev-games/ode )
		openal? ( media-libs/openal )
		opencv? ( media-libs/opencv )
		png? ( media-libs/libpng )
		python? ( dev-lang/python )
		ssl? ( dev-libs/openssl )
		tiff? ( media-libs/tiff )
		truetype? ( media-libs/freetype )
		virtual/opengl
		xml? ( dev-libs/tinyxml[stl] )
		zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
		sys-devel/automake:1.11"

S=${WORKDIR}/${ECVS_MODULE}

use_no() {
	local UWORD="$2"
	if [ -z "${UWORD}" ]; then
		UWORD="$1"
	fi

	if useq $1 ; then
		echo "--use-${UWORD}"
	else
		echo "--no-${UWORD}"
	fi
}

pkg_setup() {
	use python && python_set_active_version 2
}

src_unpack() {
	cvs_src_unpack
}

src_prepare() {
	#epatch "${FILESDIR}"/${PN}-jpegint.patch

	cd ppremake
	eautoreconf
}

src_compile() {
	export PYTHON_IPATH = "${EPREFIX}$(python_get_includedir)"
	$(PYTHON -a) ./makepanda/makepanda.py \
		$(use_no ffmpeg) \
		$(use_no fftw) \
		$(use_no fmod) \
		$(use_no jpeg) \
		$(use_no png) \
		$(use_no openal) \
		$(use_no python) \
		$(use_no ssl openssl) \
		$(use_no tiff) \
		$(use_no truetype freetype) \
		$(use_no zlib) \
		$(use_no gtk gtk2) \
		|| die "build failed"
}

src_install() {
	dodir /opt/panda3d

#	doenvd "${FILESDIR}"/50panda3d
#	sed -i -e "s:lib:$(get_libdir):g" \
#		"${ED}"/etc/env.d/50panda3d \
#		|| die "libdir patching failed"

	if use doc; then
		cp -R "${S}"/samples "${S}"/built
		cp -R "${S}"/direct/src "${S}"/built/direct/src
		cd "${S}"/built
	fi

	if use python ; then
		pythonchop=$(python_get_sitedir)
		pythonchop=${pythonchop:1}

		panda3dpth="${ED}${pythonchop}/panda3d.pth"
		dodir $pythonchop
		cat <<- EOF > $panda3dpth
		# This document sets up paths for python to access the
		# panda3d modules
		EOF
		echo "${EPREFIX}/opt/panda3d" >> $panda3dpth
		echo "${EPREFIX}/opt/panda3d/lib"  >> $panda3dpth
		echo "${EPREFIX}/opt/panda3d/lib/direct" >> $panda3dpth
		echo "${EPREFIX}/opt/panda3d/lib/pandac" >> $panda3dpth
		echo "${EPREFIX}/opt/panda3d/lib/built" >> $panda3dpth
		echo "${EPREFIX}/opt/panda3d/lib/built/$(get_libdir)" >> $panda3dpth
		# python installation
	fi

	cp -R "${S}"/direct/src "${S}"/built/direct/
	cp -R "${S}"/built/* "${ED}"/opt/panda3d
}

pkg_postinst()
{
	elog "Panda3d is installed in ${EPREFIX}/opt/panda3d"
	elog "Use the 'panda3d' wrapper to run the programs. E.g.: 'panda3d pview -h'"
	elog
	if use doc ; then
		elog "Documentation is available in ${EPREFIX}/opt/panda3d/doc"
		elog "Models are available in ${EPREFIX}/opt/panda3d/models"
	fi
	elog "For C++ compiling, the include directory must be set:"
	elog "g++ -I${EPREFIX}/opt/panda3d/include [other flags]"
	if use python ; then
		elog
		elog "ppython is deprecated and panda3d modules are"
		elog "now installed as standard python modules."
		elog "You need to use the 'panda3d' wrapper with the python interpreter."
	fi
	elog
	elog "Tutorials available at http://panda3d.org"
}

