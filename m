Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21584C48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31962082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f5D9YQ8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfFTLIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:08:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60803 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfFTLIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:08:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TzZr1GXjz9s00;
        Thu, 20 Jun 2019 21:08:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561028916;
        bh=1vRGmwPCkpWKGX62qsREf0TDCdeBQ57O0Ojp2YTUVK8=;
        h=Date:From:To:Cc:Subject:From;
        b=f5D9YQ8zN8PRHEEnn80c72pf6NgryiR9ECanUIL9rhmLEydEVoBQEewdYMN7jU/HI
         xY3dqvL23W1IzHd9MCJ6nHoLS1oeXYZhG1gj4DmKW/+4K1sPmN+okF6GggjzelZ8GE
         piOEjVRfJL7oOCDIn2plFMePTpYC4fNMD7B1uYAvjHDHmYF5n7uJ+XrQ/Q053a03Zl
         c+i9mLudvT0VteRNwySvjZ2IzuMkHzaID/MX/Dsnlef8yGxKri498QXPqioyCcgxSt
         KVPIoCFImOZZAlhHbFkJ1ui3Qc/x6VS/5yo9f2jUb7wqT4zJAPTEIQBpzdbRi8qXpo
         Obq2YyfbuFXmQ==
Date:   Thu, 20 Jun 2019 21:08:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Phil Reid <preid@electromag.com.au>
Subject: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20190620210834.7f952c18@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/..wPVWPdTY0W87LBipDGUOG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/..wPVWPdTY0W87LBipDGUOG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  905dade66268 ("pinctrl: mcp23s08: Fix add_data and irqchip_add_nested cal=
l order")

Fixes tag

  Fixes: 02e389e63 ("pinctrl: mcp23s08: fix irq setup order")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/..wPVWPdTY0W87LBipDGUOG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LaTIACgkQAVBC80lX
0GwG1Qf+Jnrq2/Rd4cfjGHvupfIZ7VOq8lVbXgonSKdxG5x+hvlXUz0j8K+Z0oIs
ojaBpXqTg3YqDRtAd38+QI+qbmeWnYKx5tJhadWM1LnPqaOdi7XM8QcbAG0srlsj
HaOrtvlbWWynPj0R5uCuMt8Ia0ax+FpRFkyd3BjfNM1KQ3yHnsWs5zV2L65fI6iW
Qd9nUJ4NJCZoA1h9m62k4UyhjXMCSCdyTz3VDnJtpB3XQ/rdYPxiyoQSCAf5kUd7
AImPAoBv07YIu59kkl9eAcxr8QKzemBf87MB0gody9/kOxQxorKuLXTnTtcF8299
3TjDFtxD7GH0Rq9Mvau9eI6TKh7+bg==
=H9Jj
-----END PGP SIGNATURE-----

--Sig_/..wPVWPdTY0W87LBipDGUOG--
