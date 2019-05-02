Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD85C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12DF206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HR3vKaZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEBKZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:25:23 -0400
Received: from ozlabs.org ([203.11.71.1]:59885 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfEBKZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:25:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vrxX40gfz9s7T;
        Thu,  2 May 2019 20:25:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556792720;
        bh=IHI6mMQFoDYS/j9O7HioSeiNF1mnixqCkIlh/69QZwA=;
        h=Date:From:To:Cc:Subject:From;
        b=HR3vKaZ6pTMWuKEjESqMOXJY/mS2N/8FIzplswJSyDRIXJKvQGfmyR1uyHfrsE4Lp
         D5AoDa4S3w6fFriL/XznFXtBlpXcG7W5gc5o/K5vD8ad91dV858+eQp8nS+ZW0b4sU
         8GZkdFDKsHU8An+p/nk4oV7nn3kBKPTwCn93iQ9gBF8bWL0dzEivAxemjQkEE5zzK2
         P93jr2BkgODuwTSTe6nUl4uEWN6U5bBQcAtmkuwRn2igYYOFqBRPH+2hWqFcYujxlD
         DR64Wt2OZVTw0qCUuUw/jZqf8HS4Hj0zKOXc6nk3khCBZ+aMWnodvsDVq6PPMQmblV
         6bn9z/w4wCygQ==
Date:   Thu, 2 May 2019 20:25:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the vfs tree
Message-ID: <20190502202515.22f72e48@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ulH.JuB/uS1=Eg7Pvri=9W1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ulH.JuB/uS1=Eg7Pvri=9W1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

In commit

  4e9036042fed ("ufs: fix braino in ufs_get_inode_gid() for solaris UFS fla=
vour")

Fixes tag

  Fixes: 252e211e90ce

has these problem(s):

  - missing subject

Did you mean

Fixes: 252e211e90ce ("Add in SunOS 4.1.x compatible mode for UFS")

--=20
Cheers,
Stephen Rothwell

--Sig_/ulH.JuB/uS1=Eg7Pvri=9W1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKxYsACgkQAVBC80lX
0Gw4AggAlK4m/cnMIbRK9g7eVyWYyLZ7cuBvVD34bhMkYgl1nPA0JquX5lQtOeU/
Mb+Pl7fJteE9bURcq27eRC2W4aJWu7/B4uhpwA8D94aHfS8ttHk2xBBY4HXsmwsU
s4RYjG9qmpZZ6giMr1YqB9hWzF+HjMQNuuqfms5ZcPhSUYa30sBQtVHmN2gWIrAo
UFdL83cadlHfmxl3XPcjXsqxp8wGKxc0iJ6F6O0slkXfEjhwth9QKW2fzoGplBx8
yZOTTGXGo+uFSrZBrTbrWUbN0KTp7mtY3JqungkZ2Fd1IKITPRzXYRR061rUHYQ1
k76GxELmJ0hTQev9J4sSIb7O8ksMaA==
=SwSu
-----END PGP SIGNATURE-----

--Sig_/ulH.JuB/uS1=Eg7Pvri=9W1--
