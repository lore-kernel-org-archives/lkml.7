Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6CBC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56D720891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kYf8Jbep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfDYVEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:04:01 -0400
Received: from ozlabs.org ([203.11.71.1]:40857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfDYVEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:04:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qqRg1CTpz9s5c;
        Fri, 26 Apr 2019 07:03:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556226239;
        bh=AQqLdTT3EpVs6eV8Yxssaga1dRXPblM6FLeESahrvog=;
        h=Date:From:To:Cc:Subject:From;
        b=kYf8JbepnHp/K3y4+WUtCBia2uQ4IKrRmIIXCBGDo6KO/m0LJwExqx19n0g4D0hHb
         +cUKvYmywc2kYP3OX5KBq1FELtSrJXwFBFf3l7WiuPs3zdf6K/A02gXtN2eCKXYW83
         6C2GdYwMwdEQ4VBNhQc2ma7wUdgoetS+IrkR/reEHjWaWRvgvV6rEvOaDwnjXFaf7L
         spSUZBzq1/cwCCa5hHR9eYYwVQmI7HMlwE3hDxGcUyJwbCM7rFpBxtf6M4hxVyEWVj
         XQI3mS6Iau7N3AdtDa0JPvJ2qXqQnidFZdPzHi3bvxFqq9bWW3tkUNUD+mYNzk27Tt
         m78gaNvQfdMSg==
Date:   Fri, 26 Apr 2019 07:03:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pan Bian <bianpan2016@163.com>
Subject: linux-next: Fixes tag needs some work in the ext4 tree
Message-ID: <20190426070356.12bc948b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DBQp7vhJ5VvQRHA3bRBhE9c"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DBQp7vhJ5VvQRHA3bRBhE9c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8c380ab4b7b5 ("ext4: avoid drop reference to iloc.bh twice")

Fixes tag

  Fixes: fb265c9cb49e("ext4: add ext4_sb_bread() to disambiguate ENOMEM cas=
es")

has these problem(s):

  - missing space between the SHA1 and the subject.

--=20
Cheers,
Stephen Rothwell

--Sig_/DBQp7vhJ5VvQRHA3bRBhE9c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzCILwACgkQAVBC80lX
0GwkMgf/REGx9yNQdztKQVhV6UK7n7NcYd33GssrwvqTCFpjT2TM1YuvRMD7n0Hk
O+c31fER12zqGJpmZI3w3NuRHOQOjevjK99T0Rh6RdIXXimnfGsnvj1VUaFtR1e6
AcfCLm8NLUtsYpmFeb8aN5dMEMMU2n1edvpcnmD9CFAd21K/g7vCejcvvnNHWJNh
iv12G6SogukKAIbmRV1MQTvGQ2UaIxSJuiBfGU8rLFliEsd6Dgaz3sb+d4hGCjQJ
6Ekxdj8gv9a6h7NEjhbybJVIwac96FpP/+mgGCIx+vRCPccZpeeITtkZGvbSm9Rw
VnGDY4AljDgePswRpl/26bK5jQ2tLQ==
=pAF1
-----END PGP SIGNATURE-----

--Sig_/DBQp7vhJ5VvQRHA3bRBhE9c--
