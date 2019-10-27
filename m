Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1915CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 20:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69685208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 20:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JXte50sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfJ0UX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 16:23:29 -0400
Received: from ozlabs.org ([203.11.71.1]:54445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfJ0UX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 16:23:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 471TnT4zj4z9sNw;
        Mon, 28 Oct 2019 07:23:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572207806;
        bh=4/py1Sd0H8mU1OiXiJqYGQKU7rWZZ0TdE/i2StPIxqc=;
        h=Date:From:To:Cc:Subject:From;
        b=JXte50snjzIqCmNX0WIZ4R6Edj1TCJ+hujkIurjkpsRZP1yNxH20VVwAynOnLkTkT
         DtuuHB7LUevnmpkkwvo2QNugvq89LpcM/oh9GIZp9DkpMXpC21NX/9WWrH5LdiLi0J
         QJi7UagrZGK07c2vzyA7/gjO0IM0V/BTX0yycdjEey7ckcUcLXO3EK4qaJMGvcgx9n
         Al4hS1TsNTaCPK05yH7sBXPm2bnIVHVPWc46zwgmRZZma+zZDcFMPuRpsXRKFz7Oko
         SB2Fn/5KgauPOuEt/EesebGV+v40eRn1IV6M6Xu3pjjZ5oSvGaFsNkpPla6WNQxegJ
         rMEu6QMnDHFqg==
Date:   Mon, 28 Oct 2019 07:23:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shirish S <shirish.s@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: Fixes tag needs some work in the drm tree
Message-ID: <20191028072324.5b2b2d4b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lIZJRsiyGFmin4iX41DG0rM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lIZJRsiyGFmin4iX41DG0rM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8c9f69bc5cc4 ("drm/amdgpu: fix build error without CONFIG_HSA_AMD")

Fixes tag

  Fixes: 1abb680ad371 ("drm/amdgpu: disable gfxoff while use no H/W schedul=
ing policy")

has these problem(s):

  - Target SHA1 does not exist

Did you mean:

Fixes: aa978594cf7f ("drm/amdgpu: disable gfxoff while use no H/W schedulin=
g policy")

--=20
Cheers,
Stephen Rothwell

--Sig_/lIZJRsiyGFmin4iX41DG0rM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl21/LwACgkQAVBC80lX
0GzQsggAl+LQ8kBupvYoiXexYXskkvbY29zpeVHRSytPk5Owot5vsF4MmcypFXjf
cypgC6HCD2kJuIx9ZzSpNZdWsUHGpn4j/FstXgPXbmpx08PjXWtef444fe8X4gEZ
WXdQe0QNSWm0KDX6v76Llyq+q0xwPScTt+IOmR/hLapRzXMFXDsWu8JIYj53TPvz
hPpHIbZqQfz4umNFLX8NMU64SnanWmxF9Wl1LYpSRMqJCiUpdLfiGkLlVp9uRkzQ
A3OguWYplgXdS/jhYX54hinJj/wIp/Pwvhq4CkYhGfxlI4Ypu/GrfZNqCmZGsW4R
zJCq89cjnvuHUJRErD7QGnWiqI82iQ==
=MY5H
-----END PGP SIGNATURE-----

--Sig_/lIZJRsiyGFmin4iX41DG0rM--
