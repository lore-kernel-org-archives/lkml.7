Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60ECC606B3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6B92064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XEJR8GzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfGHNCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:02:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfGHNB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:01:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45j5FJ17pWz9sPS;
        Mon,  8 Jul 2019 23:01:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562590916;
        bh=fDdW9Uz06uv2LB2MnViQhqTxBldx8MhBuwEGu6tQKXM=;
        h=Date:From:To:Cc:Subject:From;
        b=XEJR8GzP8Nm2T1VRFZ1zd8Y/kD6TiwRaC9QcpquP0mNw1gbZxv3yy1jJ61HCG6UPW
         aEC8Tm4yN/jfOXPRvtDsjgHDK6oLW+F3U4kY/J1yJNTjVJh6hUr2DQ+zNkbqS4GO0x
         HZsFPPbc5lV6RVr9hoNAAntl2FqK0knjxFxoe9h+LyTxXIfxvPZwi1Kw5loxam8Qc1
         5QehsIqeBHFaNRLEKMEKdnKGslyo69CIXM4v4AUmzHStel2M0pZf3j+3P+JWxSqaHK
         cOSgaElEF6ALldO2X79AT1MIjIYWTEEbg+mwgSnr5jdkfx35oIO6Fy4fJ2lLHDNnyF
         eUnacoxUlKPpA==
Date:   Mon, 8 Jul 2019 23:01:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: Fixes tag needs some work in the mmc tree
Message-ID: <20190708230154.0a7bda9c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+yYUygsZOBBze3RBnQ3lPqr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+yYUygsZOBBze3RBnQ3lPqr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  adca963337c7 ("mmc: sdhci_am654: Add dependency on MMC_SDHCI_AM654")

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

--Sig_/+yYUygsZOBBze3RBnQ3lPqr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jPsIACgkQAVBC80lX
0GyXdAf/dAMfqT7kIHMq7LgopHzpQfmjY/SfBJ1BdLa1/K/67Z27uZEWgXvYhRw2
cB+i9x9fmqpE1cuctQwxWxE0ojMzBkpOgzzOq2T9gU/4fzMCFTLECe19BsSe9NfD
ImF1ToPE5sSrfqZu0NsIXeGibjDr9aFDKJ4Y54F3hbsA2EiD1Ov8rV1rO5+Q5vXz
Yys9o3JfNC1jW6+WQrNXwjp7sPzeLVu1vqN/JmS4LGS/zSZ3B6QkQHRYZVosNBYA
+Tb/re6/inD2pfIqZKdj2WBH080vlRFdQ9pTBcqMzXAyx9xg2Trv8Fh0esG5FGpk
Oe7twMKN0ZGHQjkOxNAKJqhEw+e1tg==
=mTDN
-----END PGP SIGNATURE-----

--Sig_/+yYUygsZOBBze3RBnQ3lPqr--
