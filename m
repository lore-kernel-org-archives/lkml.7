Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB9C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0812021655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gzz1vEL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfD2Vkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:40:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53359 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbfD2Vkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:40:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tJ451Vd2z9sBV;
        Tue, 30 Apr 2019 07:40:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556574037;
        bh=nSuTSmQ4WhyowarfUioiQlZCzwTOgiF+9bVbpcklH+I=;
        h=Date:From:To:Cc:Subject:From;
        b=gzz1vEL6zOMn3Rg4FG+nm1o3SLMnHgxDI2q2HBRLiXOoujK0fH7KBRIXKPsuVJA9I
         ZbgWNTeg1o1LJoQc0cz+cDGCy63h6rZ3pyN9RPjq1WHDjReWJ6ouQJvgeWKNhgQzUO
         1ifqKS17M62t5iDd0g5CQksg7GWareJN0ZM6r+zJu1NI2+C+4pvHEWvICckc47LNxl
         EN66Z1W3ellTQp9QXRZ2fW5GbFlCR0WQ6bO4v3KCo50Bx6J1apQp0JKagvFYVMfK5I
         wh6x+zBE7ZY1coxILW/huymvsMGF7E9HnM0ij7UGLEJ326hsFuksxL9KfnCRHP/t78
         cGwIHFJgoa5AQ==
Date:   Tue, 30 Apr 2019 07:40:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the clk tree
Message-ID: <20190430074024.40bf4c99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sBmbiR/G7ppATPAZ=rc/_zU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sBmbiR/G7ppATPAZ=rc/_zU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  01d0a541ff4b ("clk: imx: correct i.MX7D AV PLL num/denom offset")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/sBmbiR/G7ppATPAZ=rc/_zU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHb0gACgkQAVBC80lX
0GwEXQgAi5ofR/8JCHxb95Bf6OedrtZbAaZxx6vup6H5pFus+C0tg5RWX6j65mpM
/eIlZJRwJWtFrRxew8knNo6X32x8VSHEQQrwe4RQTY5k84KoSgTgO87330qBEclp
j3yBWVAvyrc3K2nbDUTXbQMqTp0a1XVVYI51Pqs7yGm2TKhT7bvIRw0oHod/lDbF
BA4xiMNfd0E91vQynY7VBq1uyDCysq8dbjN3eaE+rxSs4E/3jsBaeStfv9x2RDoP
TsUXJu91wbhtHjCaerWkMhBsQnOuKl/MvVrOtmaXUxoZVxWPI/cBYove0LZDcI5P
XJ3QlCyc5hNbtUlwFyDUUc7IATq7aA==
=wDRd
-----END PGP SIGNATURE-----

--Sig_/sBmbiR/G7ppATPAZ=rc/_zU--
