Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5675EC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295C720868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfEQIGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:06:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59463 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfEQIGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:06:41 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 819D88038F; Fri, 17 May 2019 10:06:28 +0200 (CEST)
Date:   Fri, 17 May 2019 10:06:37 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 4.4 180/266] x86: stop exporting msr-index.h to userland
Message-ID: <20190517080637.GA17012@amd>
References: <20190515090722.696531131@linuxfoundation.org>
 <20190515090729.016771030@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20190515090729.016771030@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 25dc1d6cc3082aab293e5dad47623b550f7ddd2a upstream.
>=20
> Even if this file was not in an uapi directory, it was exported because
> it was listed in the Kbuild file.
>=20

While good idea for mainline, I don't think this belongs to stable.

Dropping it should not result in problems.

								Pavel


stable.> +++ b/arch/x86/include/uapi/asm/Kbuild
> @@ -27,7 +27,6 @@ header-y +=3D ldt.h
>  header-y +=3D mce.h
>  header-y +=3D mman.h
>  header-y +=3D msgbuf.h
> -header-y +=3D msr-index.h
>  header-y +=3D msr.h
>  header-y +=3D mtrr.h
>  header-y +=3D param.h
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzea40ACgkQMOfwapXb+vLsvwCeKsv7cwL4hdbV7NDsqZlSC8F0
6AcAn2H1ly/ZDGf5qcCYZ5Xe0/wNYlsR
=dQl2
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
