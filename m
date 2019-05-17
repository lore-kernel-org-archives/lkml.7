Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668C7C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3795F2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uwkTMEto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfEQLMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:12:06 -0400
Received: from ozlabs.org ([203.11.71.1]:42287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEQLMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:12:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4555GW3Xp9z9s55;
        Fri, 17 May 2019 21:12:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558091523;
        bh=d8fRXOUj9SwS9hWvc+P1fOKoLVVc9GoqL1Yk6d1sFEM=;
        h=Date:From:To:Cc:Subject:From;
        b=uwkTMEtoil4os0xpF7GlD0wr8HDH5fUp6mJC85xNDJ1ZRzd5EuBObK6OT7CoKKMBr
         So4xTV1hx0NRIv1zmyWnJa5gohz0R5d1OUNEZAWH0MXXwuITwDIemtyzgsVSDBOFE7
         EZ/J26XfxVJO/8xiOjZtPktaG48hbKvVxXLky2v+4kaVC6arIPB+vbBr6zClmTt6Di
         AMVa5LYJkpu+jJO1WSPR2x0vTfEKSGTd9q7mxK5mOn8NJelciBrVRF1L9enFLkFEKo
         aISJ7Lkyq2wkkCSzF7Ie3Zzj0Lut+oc4R++2xeIG0jBagZBQcgJ244fvO0WdikJVvF
         oS2ineCWllNGQ==
Date:   Fri, 17 May 2019 21:12:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190517211202.326f8e41@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Bdn_zSOodR4h__UBuliB9D/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Bdn_zSOodR4h__UBuliB9D/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ad6eecbfc01c ("ASoC: cs42xx8: Add regcache mask dirty")

Fixes tag

  Fixes: 0c516b4ff85c ("ASoC: cs42xx8: Add codec driver

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/Bdn_zSOodR4h__UBuliB9D/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzelwIACgkQAVBC80lX
0GwOUQgAoklIJswg5qLO7Xv/luOf1j6IF1NczOa4mI3ci1n2MJLBqmg3jXITWDg8
ZP9uiY+gTJtKGLdD/ab85FpxwtRdzvJ/f1mvORl96J3cHjG2zv2az3gsYdCuKxd3
wALx6QpQh8NN5rVQDiph3DVnAiE6iqvKdFjnosEcux/jgjh8o4craTSGvK36bru7
fL3cnia4BzBnJMLjPZMdnEUG9aEA0KJQAe44KEueJLYpe6WgdmCDVaV5D3zzQxLE
CjRk0rNIry0J4mk5+mdDiPqN5DbzQOLSM3PUDCWX70UfVkbtGud1/jHeyUQ3705d
96er6PiVDJPwLa+k6N2Q12cTxgBMgg==
=Ua67
-----END PGP SIGNATURE-----

--Sig_/Bdn_zSOodR4h__UBuliB9D/--
