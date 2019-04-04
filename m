Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3207C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8795E206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h/38xDja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfDDUs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:48:56 -0400
Received: from ozlabs.org ([203.11.71.1]:34959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfDDUs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:48:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Zw5w1jkCz9sPC;
        Fri,  5 Apr 2019 07:48:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554410933;
        bh=yd6rCAh+snFqXAl01FYbMulUE+yVw8Jd/3VfRfa0jVI=;
        h=Date:From:To:Cc:Subject:From;
        b=h/38xDjaojZK6kSXZw1BLcURRWEUKVfqaqwtl3n568/n2aomnNLfb3a+kcA3ynWZu
         lb15paESKkIz6H50+hKBmNQKK8WbV/qjaC1ga/GVi1U86n4yub+JxHxfg/4lvhHYIc
         t0J4O27+E5cUbHueXNi4pogoFjw3fbBEjM6V6bWngvsczDB2cns1q4oPCFHy3N3jlK
         5frmqFG2Jqh+NjCCkmYWeAVdktFKUJ0ccEP/2Dr0zdGlG0Sbvibka4SGYqSve+5ZuI
         VUGz/+ixyTpTaZiTuO1TtFgq8SrqmFXsGXj6Ohhddc+51VFm+bwOew6Y9xtCZ9UHgk
         A9lVsaKirRoYw==
Date:   Fri, 5 Apr 2019 07:48:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: linux-next: Fixes tag needs some work in the mfd-fixes tree
Message-ID: <20190405074843.7f0013db@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Yv_EBHyDNOCLiHfipzYdhRa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yv_EBHyDNOCLiHfipzYdhRa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

In commit

  20bb907f7dc8 ("mfd: twl-core: Disable IRQ while suspended")

Fixes tag

  Fixes: 6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle dev=
ice for suspend")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: c6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle devi=
ce for suspend")

--=20
Cheers,
Stephen Rothwell

--Sig_/Yv_EBHyDNOCLiHfipzYdhRa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlymbasACgkQAVBC80lX
0GzFBgf+JL+7RAKtMeJRxKzgELc6PmZ0JOyU10LGmWDEYOiALYxjQAQmap5MeW6Y
dMKZkpHRsKk3UsBC1dLuhCCsaWTCqOKtYMrfwe71ZSNB4b2umsgyZhaprQIUOAnf
8jp4XBLaaljS2LyY1Q1dv+L+y8pyq/sQcC6uqvyBl3K++9uQfM8kre9W05VIS1AX
GEwhi8d35rIEKMvLJZW3AFW/g038hQonqlBSVk6LbocXkH1Jyc8YRgtsvtWq+xuL
xoaqU5VWncfwjf4SvXEc0dHyjV0Wq/NXVSmXF23roWBBoad/ODfdHdmFbH3qDDhK
chBjJZCR5/GsWIbsgAdFrfU9B0Hf+g==
=PBKK
-----END PGP SIGNATURE-----

--Sig_/Yv_EBHyDNOCLiHfipzYdhRa--
