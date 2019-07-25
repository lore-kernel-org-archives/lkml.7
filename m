Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17800C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FFB22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rVIwfSO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfGYV2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:28:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfGYV2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:28:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vlgV4rQ9z9s3l;
        Fri, 26 Jul 2019 07:28:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564090087;
        bh=i+cAneGXEGF8WwZ6SmlWloU5c5Zw3pZlDd4oY8i1KeA=;
        h=Date:From:To:Cc:Subject:From;
        b=rVIwfSO/VQBA84m1bHv4xQmE14Hfs7MmEtGE8RyMgWt0IOWfcQ9b0mdmV88BxHHZE
         TBQRG9BLQS11bjf+JkyE+ED8awwInMxh3k08N5s+NPouKRJhT12rgC5s0DdNGLkc8V
         hA08iLXHtNX+4wMf9On4NlGgyMwnH8dLrSFZrjubn0iIoKIY1QKUHI2QhvNOHqm3nf
         nJGUcMY75wqEPkHsGtyhC1tpe76BVmbSdbpke3ZlwWz3dPPamboJqAMWWnEFN/foyj
         PZP7oX3X3HZ6ymQY1OkgNKmu25qlyR5BIUEKLlfc19kwCEDKHQnOOflLdG15yOc5yi
         mKvzcm4uF+WFQ==
Date:   Fri, 26 Jul 2019 07:27:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190726072752.2acb2149@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4zdjEVdAjRhMGFGzLasb8QI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4zdjEVdAjRhMGFGzLasb8QI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9fcf9139a2fd ("ASoC: ti: davinci-mcasp: Fix clk PDIR handling for i2s mas=
ter mode")

Fixes tag

  Fixes: 2302be4126f52 ("ASoC: davinci-mcasp: Update PDIR (pin direction) r=
egister handling")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: ca3d9433349e ("ASoC: davinci-mcasp: Update PDIR (pin direction) regi=
ster handling")

--=20
Cheers,
Stephen Rothwell

--Sig_/4zdjEVdAjRhMGFGzLasb8QI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl06HtgACgkQAVBC80lX
0Gyfcwf+LoYdbQ+26c/u1g01vmV2TkRDuNWj2h7t8K6H6CniKCdZD9/NM+5maIEM
Jymn6kNzr2iO6SJBj0Xhzcm4QEnbgA9f/vWziStok4iRHIU0LUFJTBV8KNz2ITk8
+Bqs7M7vp3B5XDsP2LiT7dP4BiHbcy4r5k3LPCNxb+5bL4hvzZ8qNsVVktpe48Bb
9i7fG74WRuyeWnWaZrSKgdu7dv5Ia6t+oc+qSOGt64MIG1FkSexCByaosE3GI3S9
vMU+rA6Ms1YKUTzkGh78YZiQbSml8nAUUsl7ydhAYKswTwqg4LuqtCCYOxyPv0Gh
QYIgA/pjQ4i6py/1FTQ9eqUfSkRZNA==
=jize
-----END PGP SIGNATURE-----

--Sig_/4zdjEVdAjRhMGFGzLasb8QI--
