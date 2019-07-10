Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0AFC606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023422064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M5thVoqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfGJLb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:31:57 -0400
Received: from ozlabs.org ([203.11.71.1]:55879 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJLb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:31:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45kH8T4vd3z9s8m;
        Wed, 10 Jul 2019 21:31:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562758314;
        bh=m5bNgR67y/SQwBaN1hdKZQlFvCWv8aHyXrhC/bU/8YU=;
        h=Date:From:To:Cc:Subject:From;
        b=M5thVoqXJq7eH2BApOIjDZIe47hO3Es5e0UhXrl52VH0MuwgSnUb2YvlB9ZvHPEYy
         Xdku5Rjjj3DzI7ApZDqS5ehakI+TUL+1zWnc4j8fNe2NXNVM4L3pJo6w3eRpmoC9cA
         BdUe84vgI43phAe0Th/Tbx+tkoUuCnwTJPURcjXCWkANUS3yoH/G8mWKQSOToiliJ4
         6UWfFxj/LBI3+9pr9SfQ7Tv/sDRPuzM5kdn2hV/9eQ634MrLJXfjjOObaiw99wFvtn
         jHHgWffRV/h1Mfr0d0up0cJk+RFdRrvWS5CBkjNcofBLwFxhkImSlZufHnT65yEygb
         HtpbnqR8a/7zA==
Date:   Wed, 10 Jul 2019 21:31:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: Fixes tag needs some work in the mmc tree
Message-ID: <20190710213151.20acf4bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zoS3FJeT1XxruqhG7T5mXyz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zoS3FJeT1XxruqhG7T5mXyz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  59592cc1f593 ("mmc: sdhci_am654: Add dependency on MMC_SDHCI_AM654")

Fixes tag

  Fixes: aff88ff23512 ("mmc: sdhci_am654: Add Initial Support for AM654 SDH=
CI driver")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: 41fd4caeb00b ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI=
 driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/zoS3FJeT1XxruqhG7T5mXyz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0lzKcACgkQAVBC80lX
0Gwspgf/TWHYmJV4ST7tzicwdGXNf19V4wK1fN2ZolyYoDIxehXEZLWGk8VLZ8a4
eniq72dUmbjRUl9irdbbhZnrSEtaFHlgGWE5qAja8hQQs8TbB9xY8jIvDFeq/99I
FiYuQ7eqdcS7LiZm4Ec3MRK/4d+tzblTr04WD8SFuo21PwRLAA6oa8a7CoW8RFrs
BlK+tmPWNjY43APS8xON/aqKNTjlWWsfCgflLmmZVyaG4uGDe/REKkVd6CAVHbr1
7y6yC/wXKf7lpNK0mo464YpBcAMEtxcpg7ud082Rzn+fj4iC51jwBd1pert4qxZ2
bMnDrDM08ok5u5FsvLjYgbBI9ByJ4A==
=FDNY
-----END PGP SIGNATURE-----

--Sig_/zoS3FJeT1XxruqhG7T5mXyz--
