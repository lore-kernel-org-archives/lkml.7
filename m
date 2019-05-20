Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D716EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEFA2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F4GXlucu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfETVoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:44:46 -0400
Received: from ozlabs.org ([203.11.71.1]:47289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfETVop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:44:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457C965Z0Vz9s9T;
        Tue, 21 May 2019 07:44:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558388683;
        bh=HVxZBFmlkHReoHXPhmJDd/bzuwCJbZjr6MZwdbFJasY=;
        h=Date:From:To:Cc:Subject:From;
        b=F4GXlucuK/N1NHNXw0PDM0KLBk9dDB9yEPts5F4LfkrFTrEBy6pm0KWrnNZ8Rkdqr
         4I8xANJF+UbBK6uSXjH8bmbwFpCEl71Twao4N9wTFpuOmETi+g8rapwCqrCQRS1f+f
         j+OVizMY/czkvpg97XRVUfJUVBOFcNUhC6BYBfUEeGkfgPEajU30Cx3aDQ+ecrmUSS
         UJthsw+7/4V+jhWrdiNNvpuU8nVLVhX6+kdAXOxmoVTLL09LLmS2JJG6f2ysnRjf9t
         ydHCuys7cOwz1oXqHxTbEgv3eje7Mn3W/87ECTevT35vBCMx5xrs/EaSWomzBNWymt
         2HTkkxJS8x6gg==
Date:   Tue, 21 May 2019 07:44:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Eckelmann <sven@narfation.org>
Subject: linux-next: Fixes tag needs some work in the jc_docs tree
Message-ID: <20190521074435.7a277fd6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V4O.sG0YFJXoinnNPT=P0d="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V4O.sG0YFJXoinnNPT=P0d=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9eaa65e8aad5 ("scripts/spdxcheck.py: Add dual license subdirectory")

Fixes tag

  Fixes: 99871f2f9a4d ("scripts/spdxcheck.py: Fix path to deprecated licens=
es")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: e6d319f68d4d ("scripts/spdxcheck.py: Fix path to deprecated licenses=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/V4O.sG0YFJXoinnNPT=P0d=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzjH8MACgkQAVBC80lX
0GzBOgf/QfSfS+HQRpf3I36LDtv+x/5+F5QiUXWyRAx1FTTkCf53Z7QRNu+qhyQn
yBM0eHrOdluiX4DpBKNC2VheMFeSY5Ic8i30fHM2JPvOE8mSpDJ52UIg7qptA1nS
q6Lv+GmOtwNpXFUF35SXGrkllTluTri8hiRU51zq6VOOumBMrZSsnMXfxrs4whck
8kuFTZcL0Lma5ZGx1WaYsTizaj2BdFuIzAWUyvdBVWO7FVMA2xqc6DDyEh1C2U+J
pt5m8Jp1cT2CYT01Z+N2h0Hjxe9WvdJh9zmewSP0Lf0UUsOkxNOYLz+yfW2D9RlR
fCXU6vvYdAbtxaocFlnzfR5TyArCrg==
=FpY+
-----END PGP SIGNATURE-----

--Sig_/V4O.sG0YFJXoinnNPT=P0d=--
