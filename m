Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1DAECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C1421A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S0XyS+Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfJAW3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:29:07 -0400
Received: from ozlabs.org ([203.11.71.1]:37911 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfJAW3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:29:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46jYpS5LW0z9sPc;
        Wed,  2 Oct 2019 08:29:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1569968945;
        bh=usJg1r0Zs+lz/t189a4Z4/qDI/3oA8sjybfAXfcJeDg=;
        h=Date:From:To:Cc:Subject:From;
        b=S0XyS+Lz+uoAGzZS/FP89FfNQMFhKIv+e8WGEACbhsSNBull1zyWMsBllMtFdDLsz
         8OQ6vzs6/nFBiod5a2tQFM6OVV9AqiAlBqeDYpY3vBUt8T6oSMybXqfpDQ3axCLR0L
         gFnVgKDP6nXMuid60ShCgfSc3bAJoqTta2B0nBcrwxBJRS8wjVvkZ+Ufuuxef7ilht
         BWnjuf4MsDL6GxQHCXOhPskZEt4k4VDM+380AATCHR5WhOlxXX8ioe8WOWV1g3NEJy
         CryYuEeRDyMVmMfhn3PXjVwRmqnADGK92w1q1eXOcybb8VUs/u+DcVFHO/6vE6YEYB
         w64S0W08kR2Zg==
Date:   Wed, 2 Oct 2019 08:29:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20191002082904.4eef7f15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SNTMeSBNh1=ZcjfHd6YToBQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SNTMeSBNh1=ZcjfHd6YToBQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e66e52c5b742 ("ASoC: SOF: pcm: fix resource leak in hw_free")

Fixes tag

  Fixes: c29d96c3b9b4 ("ASoC: SOF: reset DMA state in prepare")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: 04c8027764bc ("ASoC: SOF: reset DMA state in prepare")

--=20
Cheers,
Stephen Rothwell

--Sig_/SNTMeSBNh1=ZcjfHd6YToBQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2T0zAACgkQAVBC80lX
0GyCIQgAnPGjji+k5tzcRPM7+6L0NoDPu+Kn8Fa1Jx/FshBjZpP3bczPG2mazuqs
Q2/RB8o9QX9uNnHwrWtLS52//5gQhFTFE9ASMS5IXqaFR83zzD5yRvTjsJahS6JA
rYa0J8IEJuhEcklI5lK3FiuDz/mOaexuDGi2eckwP7sMP6VWTVwojtAMg0ezlK8s
fEZwaVvPEih+Ik5/2fjgGkzLFvuV8A61QkVhGYdtTef8uSQH3ormnLJEZdw440bH
CI0ymM72MdOZiRW99TP3Ekz346kMiokXSW0LkK1GLbkL55m1vxNlTfmc4i+E4FPz
SlvxHe60lE5utAHKQvgH2GMXGyeGQg==
=u0Fc
-----END PGP SIGNATURE-----

--Sig_/SNTMeSBNh1=ZcjfHd6YToBQ--
