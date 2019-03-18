Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37CE20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rd5dHQE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfCRKpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:45:25 -0400
Received: from ozlabs.org ([203.11.71.1]:50073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfCRKpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:45:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NCWP70lpz9s9N;
        Mon, 18 Mar 2019 21:45:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552905922;
        bh=CiaFxxJueRuz60y1+o2fRS3llzxa3DraBISteo0zXq8=;
        h=Date:From:To:Cc:Subject:From;
        b=rd5dHQE96VdLTmOFT8fkgMavJqL/j5KZXFPrpctxeF3hX5ITMyaoghE4pLAugHtei
         LnppG7ZGDLlF8QTaldhmX1YEZGxsql2tUD9LsLivuSPSI0PWY7lWlk+Wx6lsZQSHK6
         ZSIAx/d0dvse8DAnJGvY4oRbLfotTnLzeHQm1QRCESoG0QhzBvgd+/ombUGbtSUDhY
         QYgHSOM4lZYmMHQW272Kf+Yt2onxFEewCgxUowbwgPbR0/zQ/wKzw9K4+kK/yii0JD
         7hqWLdezr3WxG0frtz9EmrEVcxiFcKoD+TqLUN5Q1UoiKWG3JgfLCPwJovBkWqMEbW
         bhTTHFzH5eITA==
Date:   Mon, 18 Mar 2019 21:45:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jiada Wang <jiada_wang@mentor.com>
Subject: linux-next: Fixes tags need some work in the sound-asoc-fixes tree
Message-ID: <20190318214506.03f6da24@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/drJHZdp+RxL3r7WN58u7e1s"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/drJHZdp+RxL3r7WN58u7e1s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2b13bee38849 ("ASoC: samsung: odroid: Fix clock configuration for 44100 s=
ample rate")

Fixes tag

  Fixes: fbeec965b8d1c ("ASoC: samsung: odroid: Fix 32000 sample rate handl=
ing")

has these problem(s):

  - Target SHA1 does not exist

Did you mean:

  1d22c337dc8f ("ASoC: samsung: odroid: Fix 32000 sample rate handling")

In commit

  399706df420e ("ASoC: rsnd: src: fix compiler warnings")

Fixes tag

  Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR h=
andling")

has these problem(s):

  - 'linux-next commit' was unexpected.

In commit

  ba164a49f8f7 ("ASoC: rsnd: src: Avoid a potential deadlock")

Fixes tag

  Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR h=
andling")

has these problem(s):

  - 'linux-next commit' was unexpected.

--=20
Cheers,
Stephen Rothwell

--Sig_/drJHZdp+RxL3r7WN58u7e1s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyPdrIACgkQAVBC80lX
0Gxc+gf/VLDJ5p9X1fbStVZTtCGuK66G8XCpVtGCGgXc14vSP98qn7dqXl9bUWIz
iq1Lsbcf9WRQNMWTBkJskEiAgE85SqOBmgNbt++zmN/5NQh+1q/S1rG5tOaJfDLI
KkIuiIXugTdPANccXMFZh6SzQdWcoDrUchCfwE/EDBMk6evgXg6+wAfIF9QBf9y0
PT3qhwbCsVv7gKIbMiUMj0qZVZA4OqC0S9EkwECR4bfOSkwO1y+Or0bCBlGptdng
Z6uuMvuhjba42l2dylVIklW4a0r/NKDiYMuJ0cI+NOemgecaWn1Sd4peOxy15PvD
YPXl7LgASK3yduAoMCJGkRb+V/cwTg==
=aGn2
-----END PGP SIGNATURE-----

--Sig_/drJHZdp+RxL3r7WN58u7e1s--
