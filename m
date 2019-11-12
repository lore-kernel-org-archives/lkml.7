Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7863C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B299521925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PMNCkg1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKLB0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:26:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfKLB0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:26:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Bqnp5hdDz9sP4;
        Tue, 12 Nov 2019 12:26:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1573521967;
        bh=W3s43Z88oXu9pIzwh9tpxWxTIX0x+AKU7y4WkOJAJLU=;
        h=Date:From:To:Cc:Subject:From;
        b=PMNCkg1dPaIOFB2udaVC1OEaTsXRpJArXHX0cZ06bnoX1VtGSzJQOkByoFk/hqlOg
         +7/S9uONnUGWp4ik3Nq+YVXwSO7zymBCMUXSS+YPOa1QJdYIcIPZM+/q2+OXgKBRwc
         ft+9v923TbQYHD448mj7X/Ok378ffQbeVMbLj670hMXCgNme6hRRgj1cf7NXm/mlqj
         kcC52k1KnPONY7qQ+S/HasGmXeSoiFbOz7P9c4lUGmKCw0Ky2V35QYsck9zie9KfQS
         YwkiupwJYQtTuaK32mZ5JM3mCrMZ/vOSbhjnG5kvNM8fffcn7CWydAUR69VtYTMppt
         ztByroEfEWBOQ==
Date:   Tue, 12 Nov 2019 12:26:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: linux-next: manual merge of the sound-asoc tree with the sound tree
Message-ID: <20191112122600.44c88517@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tbsT14jj.cYO1DXCXtXJWY+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tbsT14jj.cYO1DXCXtXJWY+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got a conflict in:

  sound/soc/codecs/Kconfig

between commit:

  82e8d723e9e6 ("sound: Fix Kconfig indentation")

from the sound tree and commit:

  36da67630d31 ("ASoC: Add DA7213 audio codec as selectable option")

from the sound-asoc tree.

I fixed it up (I just used the latter version which also fixed the
indentation) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/tbsT14jj.cYO1DXCXtXJWY+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3KCigACgkQAVBC80lX
0GygNggAnqffmZmmQ79iQHL1v2XBl3A1VHEMikEKrQ/QDzTms1cGmqYjVaqj7RO8
y+s1SYf5MOCDbIGJF2bp3TgA+RbWal6I/LpfNyXFPazCsNkOhwakwh9T/b+DNGZo
vtBvZ/rit/iCqhXfVNceDk131FCbEPRsJc+rLfx2iB3R7JaLKM5dAfmxmUG6/djz
PM9eFVd6fPmgQ2lDBciN6I8E+7ZkWFfLzhZt2Fhxwgaha24wyBoJqL9d58nE6r1A
daMse50qNfLccFCl4n+hHqy9NrTs3Dvk5b4Jjue/mpQzSv4CHJAyRAxOkGsMHfp+
hHqj0/YV6kAoReE3sanOdRTu2hhPJw==
=r86P
-----END PGP SIGNATURE-----

--Sig_/tbsT14jj.cYO1DXCXtXJWY+--
