Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB817C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A307A208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L0EGHNjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfELXrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 19:47:53 -0400
Received: from ozlabs.org ([203.11.71.1]:51587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfELXrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 19:47:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 452LGs2Wx4z9s4Y;
        Mon, 13 May 2019 09:47:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557704870;
        bh=nyuNwe3VGv4oJ7NbFLXrcOAb+Qca9wJ5PQU7nXdpfFo=;
        h=Date:From:To:Cc:Subject:From;
        b=L0EGHNjwGGFX5Oldq+QeSt04M+Wb0UR7Ta9NxitqDuyc0V3JPYeU4BOmngVv2SEKN
         sGnkotIGwPLtsuowH2V7YhDuZy86D5QJTEznDayBWdfSI1EJlfytZWKUMoFF+gUiod
         b30D4kNX7NpHPHsPXu0Ew+eF/u8iab+gcv4zjsazaahglYVBJ82Rw3KlA4U7RUnyIB
         7W2oYHWAuhZVzgQSfrmyiOgtSA2/SrPM3cfwaIeUd3k3VKalR1tMzdQMTahfr6EwWj
         teh/yBw/eILhawUAoL+SS11gYz9SKML98gtCYHF27XExJ/72IYWyTA3GxtywaoYmVj
         4G67m7Ph/liJQ==
Date:   Mon, 13 May 2019 09:47:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>
Subject: linux-next: manual merge of the mips tree with Linus' tree
Message-ID: <20190513094746.4c020232@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/b15HGX7Ma1.ciZb8hoh892_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b15HGX7Ma1.ciZb8hoh892_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips tree got a conflict in:

  arch/mips/sgi-ip27/ip27-irq.c

between commit:

  e4952b0c2c03 ("MIPS: SGI-IP27: Fix use of unchecked pointer in shutdown_b=
ridge_irq")

from Linus' tree and commit:

  e6308b6d35ea ("MIPS: SGI-IP27: abstract chipset irq from bridge")

from the mips tree.

I fixed it up (the latter removed the code modified by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/b15HGX7Ma1.ciZb8hoh892_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzYsKIACgkQAVBC80lX
0GzEawgAoNys89jCYzgizAgVYHTvqXJawjvo4oTXRLQEUMuL0KW32eC3YZHVMk9t
McUaRASigaGjbD5+2RPq4RZhXxf6P8UkF7mBXdOF9GNwPKfAdM7HuwGuO37/yD6r
JoZnPvuFOC91GMFM3OO/qaqgARtgNoqLNRS/1IPNEd5sE0ytoFkP2lKui4WijVfG
Xe4AMs8OuDh+4FSXx82U35CcO7MIqF0DOjuP5JN4TcOtk1e4mRcweD/TN1QyjeDy
SewU80A7KM0y17aTTyye/GvKaPNaImi8sX07cpc1QeWgyfhxPe2l8yXwCls2VNsl
AebH3I9KZka61orel5USDteVD7yZqg==
=EXxE
-----END PGP SIGNATURE-----

--Sig_/b15HGX7Ma1.ciZb8hoh892_--
