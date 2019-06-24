Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38DCC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1DF20679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QF0oV63M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfFXDXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:23:46 -0400
Received: from ozlabs.org ([203.11.71.1]:37979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFXDXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:23:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XF4Z0wy9z9s4Y;
        Mon, 24 Jun 2019 13:23:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561346623;
        bh=Ld51LDvZP5MLJdlUGJjSgMBhQwTnBRPHw/iDQzFTbA0=;
        h=Date:From:To:Cc:Subject:From;
        b=QF0oV63MZSkWDnakhYVD3xnb7VcUtkw8rAdMkDWwZ8JDMgFSdapMBlpIGx9Dx3oi3
         Ug1Fd1nJwZ9/PkGa6YiLlff1wvvKR2g3d/XcYtmoJAZioJV618+pNBgTpWAA/NPKpW
         gExi8z3D4pIiApU9XFDhB6wJSYcwBar57DT8lcofRXBS/+Gm+hPgYduKuYyN0xs3vt
         rVflnV7pnwc20sT3Ji5+npjFuEeQDO2+nEcN/tyuw6BRAXeLSnnnvYTLIOfVi5Jgan
         VwzYTDZsXoXAjCWx2oVLyAixcSAftd7IeZOJQOUMBNxEtGWvN4BR8LIxFSss3f6zLE
         FT/ctlHrmla6w==
Date:   Mon, 24 Jun 2019 13:23:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: linux-next: manual merge of the spi-nor tree with Linus' tree
Message-ID: <20190624132341.7cdf1214@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CsJE6n9rHzX00k4CQHfkzhe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CsJE6n9rHzX00k4CQHfkzhe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the spi-nor tree got a conflict in:

  drivers/mtd/spi-nor/stm32-quadspi.c

between commit:

  caab277b1de0 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 234")

from Linus' tree and commit:

  df6bd6c002a4 ("mtd: spi-nor: stm32: remove the driver as it was replaced =
by spi-stm32-qspi.c")

from the spi-nor tree.

I fixed it up (I removed the file) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/CsJE6n9rHzX00k4CQHfkzhe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QQj0ACgkQAVBC80lX
0Gyk8Af+KoY3oPRcY/pacom9JBsnThTy4deUQQ/D5Er7/NWm2T6LKFm3kdVPiuzw
TLXULV7BB6iXO01ENcE6joZwKe2BBQHbhIg3LSZv5kCrwak7y1vaFi37SSca0Md9
tGkmG76WSN7Ab2AUKLWKUYxmg20R5So5GB+p0qqUJmENrSTnJYD/fOPRpWc8QSdY
UDTMHuqmakOPP9osBCWGlj5lBFavyMYRwc6HitrHFx8H8smuZcqs9yNsiBQ0a+AZ
mfJyanphRHNBh+h2P0VXwG6AZSJQvXgkfmHbd25t2XTj8jE/dqFeYC0PvU8zxKtA
4YbwbjfiNVNgsqlXGkPjXBS8eM0PIw==
=/yQ1
-----END PGP SIGNATURE-----

--Sig_/CsJE6n9rHzX00k4CQHfkzhe--
