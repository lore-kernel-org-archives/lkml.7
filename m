Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1859C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80FC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfC0P3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:29:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42511 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfC0P3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:29:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DA4478050F; Wed, 27 Mar 2019 16:29:13 +0100 (CET)
Date:   Wed, 27 Mar 2019 16:29:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Linux 5.0-ad1: -march=native support
Message-ID: <20190327152922.GA14937@amd>
References: <20190304171916.GA1694@avx2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20190304171916.GA1694@avx2>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-04 20:19:16, Alexey Dobriyan wrote:
> -ad1 patchset adds support for compiling kernel with "-march=3Dnative"
> compiler option optimizing kernel for the specific CPU. "-march=3Dnative"
> has been available in userspace for a long time and is trivial to enable
> in Gentoo specifically.
>=20
> "-march=3Dnative" can be used for folks like me who compile kernels on
> their home machines and never share binaries.
>=20
> See the link for more information:
>=20
>     https://www.shlomifish.org/humour/by-others/funroll-loops/Gentoo-is-R=
ice.html
>=20
> Requirements:
>=20
> 	Intel CPU
> 	x86_64 arch
>=20
> Usage:
>=20
> 	# apply -ad1 patchset
>=20
> 	# copy regular kernel .config
>=20
> 	# enable "-march=3Dnative" support in
> 	#	"Processor type and features"
> 	#	"Processor family"
>=20
> 	# ensure CONFIG_MARCH_NATIVE is enabled
> 	$ grep -e CONFIG_MARCH_NATIVE .config
>=20
> 	# workaround kbuild race condition if "-j" is used
> 	$ make syncconfig

Linus is unlikely to take this directly; you may want to Cc X86
MAINTAINERS.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlybltIACgkQMOfwapXb+vJTmgCeO8kFNKzAVXGy6uNa/qS/YdS0
x50AmwcA6vyqSCi8lqa0k9O7C6Lhvh+k
=WeDm
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
