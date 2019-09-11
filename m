Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD78ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3393B21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nmuFZKWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfIKKs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:48:57 -0400
Received: from ozlabs.org ([203.11.71.1]:51407 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfIKKs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:48:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46SzCm676Pz9s00;
        Wed, 11 Sep 2019 20:48:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1568198934;
        bh=yJ5Q6YhnC8J2au2Q5c8U6tpMW4JSLJXthExyIaHfoN0=;
        h=Date:From:To:Cc:Subject:From;
        b=nmuFZKWqvVafbjwwjXPX8ihaKq1fuj1iaQ231a2cyqrhtDnb7VxQPdD6Fg1fZR8hg
         3D1KRVLf7TS/3xye8SUEUFw/mtQYN6XJgS8yADCEDpxB/cbJo1k/sXYvT6/kFis2Pz
         WvcOFP0a2leAgBgId8JjjemPblb6k2RnaMAgOaR+3XPzczV6QDxsc7H554N7rGtbbQ
         0XgHyUiFnDS7tUNE3ZMCoZYpdxAXOSuGVah445eA8vjMlwctw//GS/dG8O0ZVJVzHH
         D9DKaok7odw+xpS49nBFpJdyFrwdfhtOIURWPNxDDuoKAqrxta5DDkbKrmbJh+XttD
         hBF6ok1LZfMpQ==
Date:   Wed, 11 Sep 2019 20:48:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pinctrl tree
Message-ID: <20190911204853.7e6aad26@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VONq.M_gGblEsm0NMKdIE1w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VONq.M_gGblEsm0NMKdIE1w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cc3abdb73df4 ("pinctrl: iproc: Add 'get_direction' support")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/VONq.M_gGblEsm0NMKdIE1w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl140RYACgkQAVBC80lX
0GwdKggAoOEArS9e4P9QhdoiQ+LU/UHT8p0f0oeyfCfv5ArqHNuuio+Tlaf9BFzw
xKeV2YrZptiNBgGoMmqhyerK6qnuj9ik5OJImckrsuXJ1i64EeqIkkisrHOFXayF
Ud9CSnpZdpZS2KPChhYz5Gv3fm+1MDgce67Si0OQ2bB8VS0UUbRGQD5dyqKGRWpU
YmE/OgCu5G6fBEtqFpq8ndi8dTQJGNDkgFvPZchs9vPuUcmRkmjhoqOwdHcx6wnF
lpEJF/M4IT88dkHg0cb5LrWoDzgtp3X5E5ApSrSI4X3BUGSpddXux4XXp/WMgkDZ
vg6sSGWvQzRg+soMj86fS0xcVnIKKg==
=8jqs
-----END PGP SIGNATURE-----

--Sig_/VONq.M_gGblEsm0NMKdIE1w--
