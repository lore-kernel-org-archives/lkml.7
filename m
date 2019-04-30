Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD9AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5972087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="shTWbIkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfD3WGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:06:12 -0400
Received: from ozlabs.org ([203.11.71.1]:36703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfD3WGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:06:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44twb50TgJz9s9y;
        Wed,  1 May 2019 08:06:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556661969;
        bh=F43uIaJHtzhE1YqoLJxKTd2kj4WqWVqb1/ue09EoLtg=;
        h=Date:From:To:Cc:Subject:From;
        b=shTWbIkOyWlmyEx0nZrZObrLCr+6izxp8mXVCuE6cCP7Yy9n6wtPNS3bukoWK+iio
         v8xRAf3xothHFbR8Ob717WlxEWRCKELet5nJHNDRFL7qOTsbpqXIePK444F2IOXLmI
         IjLghm5rCRl6AGB7eKdDdAWhit4Mc1zMYJ6/Vs3jIpxxDp8G103SD37x1J2XjCil9A
         bqG2Izi4Y3qBbzuoJkchwpXb5Cr3banGbqkGKafSkFULRuE9Pow+M1KazIg/lVze0X
         +3lFIOIcmPtALbTXMhliAsOslb/d3p084bFVn3gevirGHJdmGCwZ7mWyCbos15tGSi
         wGYUIvRd5hXWw==
Date:   Wed, 1 May 2019 08:06:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20190501080607.0eb96cca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hVu=l+HBvRm+Ub+a1kBDF5F"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hVu=l+HBvRm+Ub+a1kBDF5F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  60ae11086c04 ("unicode: update unicode database unicode version 12.1.0")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/hVu=l+HBvRm+Ub+a1kBDF5F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzIxs8ACgkQAVBC80lX
0Gy/Cgf/WUkgseW71XeOjl36gvbgapRffGsHJTgcXb4HCeMM7GctKR/9zd+N+qC2
YoUt2fxU+pEBv8ZeQIJQmZqiq8IV+Wu8m1tHlKKwvYV+cAGnV/7in+rWIRpgmUG4
S4WW3YrkambUFJUBd/wvURENGY+7ZxBU6q/Ejlvry0iUiIDsiaoxystyZfyiS3sV
hLpJLw7PKybv5dDEILZ2atRYu+mV13FCGfSOmQoD41QUveLMkM7pchengWuZnFBm
OghQr6yXfaCP+zOyGMbqONYYFp8gNe0xFmo+amJJwMRqhwTeIoJ6C1zgsDCrZ6Gv
UpFA8ft1sr9OvqlORb9T7g/q0EkXlQ==
=h4iu
-----END PGP SIGNATURE-----

--Sig_/hVu=l+HBvRm+Ub+a1kBDF5F--
