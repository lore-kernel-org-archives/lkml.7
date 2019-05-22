Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E52C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C708320868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y0QJRsWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfEVVvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:51:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40903 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbfEVVvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:51:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 458RCT5yBpz9s6w;
        Thu, 23 May 2019 07:51:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558561861;
        bh=xyaKNDQ8KV8Iys1hcAlp5RIVJvN3M83u60UsF0JBvIY=;
        h=Date:From:To:Cc:Subject:From;
        b=Y0QJRsWTVfvdMQ/RbdkBAFKYZJr+RLWv7yQ2JU2hBJoCQf3YcozuEyecY4+C1EenP
         T1JKEctNYRsazvprDs6xo4QpjvwR73cOOypWsEb7WpRRhrXH8S1E9QaNxHSrjtGbI8
         AnJPugMxn82Q3h1kRhSPvYQeaUuYuMBhq+VBOlvSkGhpR1QnE3dAsonYjX3bvVV3T9
         Sg/A+J9T0C0NAoYVrG2dYMclFnuEfmw+tPvoWV1QrSXp579lGIynCJlMo7YBHxxmnq
         3mALlLI+HgGuJ+TYIhd+J/+pcYX5Tp6Ex7pyezIzJc2b4gPVUQe4YcFZTXt0oAtJ1G
         sjmc6Zt/pNY2g==
Date:   Thu, 23 May 2019 07:50:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ed Cashin <ed.cashin@acm.org>
Subject: linux-next: Signed-off-by missing for commit in the block tree
Message-ID: <20190523075059.31a2cdc4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LIZWS5j/XxlFzDtoGghY3+j"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LIZWS5j/XxlFzDtoGghY3+j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  04bc2bcccbd5 ("aoe: list new maintainer for aoe driver")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/LIZWS5j/XxlFzDtoGghY3+j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzlxEMACgkQAVBC80lX
0Gz5yQf/ei9KczpoZLw/w1uK4hlvB33M/ZvGbdIF3luqZ2+XvCXcAN44G5f6szO8
/gnR1qTUt0fT+z4NUPb39FtvC4kmLUjsVWyKr7v+RKjPcTrwThVpcoqBuTslhRrD
ZaaXLMjKptvRwHUUEFtZbQMnB453CgVlLS7YwKUqIaq0G3jqKS6fSjchjp4RL19R
0Bd9DZPzBvTsk1BkLRMDcj0jzACl0ukYd1gLskUiD8lxT8sKOMZFe9pBwRGZe12x
PfjJRnhbv0AKays+zIvG5koLxYZbELh9P6EK5S42w7dYKlsuPM0isYVChHs8aTHi
ng9XSAWP6HP5gqcOx6LDQ/WDyy29tA==
=zFN1
-----END PGP SIGNATURE-----

--Sig_/LIZWS5j/XxlFzDtoGghY3+j--
