Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24675C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC7420665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X4SA7gIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfFMRCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:02:35 -0400
Received: from ozlabs.org ([203.11.71.1]:59143 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfFLXHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:07:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45PMvf6Csvz9s00;
        Thu, 13 Jun 2019 09:07:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560380831;
        bh=UdldULC6VqoNkkec5xx/1Gl133nw3s45DH0pbTnGJ9E=;
        h=Date:From:To:Cc:Subject:From;
        b=X4SA7gIKIn2yx7BxaD6EDA0gViV6x7sJq790B9RxbimLiVw3Xji0f1TqkQxsc7nmU
         xJmxT9WX+HGGImdml3NNPL3no9xbvTji+IxT8Rga/uoFJKUrFBJ/oFzZn8sNnR012+
         ou+3Zwqx8YjwuChZm53Uv9Xi4UkCPf/Tc+zxdTeBm+dy1xJsI21uayregP4hpNQzIi
         +z1LEfHc4sX/GIH0E4ydNkBgEOUU+Y4LhOVv7p9kk/pO24WZ4S/+YwP4L6pRXaGoJ5
         h37QSNmQeSXVr5ZqbDWEKszBKcGcnnXQ1v4GQY+Aj5kEpZ/aZNdfEmF2Z4MlHyZfbL
         YxXanKbUghPiA==
Date:   Thu, 13 Jun 2019 09:07:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: linux-next: Fixes tag needs some work in the clockevents tree
Message-ID: <20190613090700.04badfc3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9XxNnr/bQBTFrzLY_.KnWAE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9XxNnr/bQBTFrzLY_.KnWAE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  98793726ab3f ("clocksource/drivers/tegra: Restore timer rate on Tegra210")

Fixes tag

  Fixes: 3be2a85a0b61 ("Support per-CPU timers on all Tegra's")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/9XxNnr/bQBTFrzLY_.KnWAE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0BhZkACgkQAVBC80lX
0GyAtgf7Bg1GxFw4110B5/LO0rTjI+Naw8yMRZWOjGdHlqzxJB6PNEtHqGXIwxou
+ScQlN0ao2gzUZc4m8sWQUB0kOJaBR3T3J4+3TdbbekKT+94BbS+CftQS8vww+tL
x0+af6LcLluJYkUaBOTR8KwzyRMKPjGFsOGCYX+76TRspQkg+x+WLL/3iF7Tav3a
mstcHrlk8SIgGqk5wGbIatsaHTs0wNZlf3F1R9TNA7QJ2B7tynuUGoX6MMSi9tnt
FEJkBcORbLyPN+T62V8TS6vRTi0a9pbO14lusS5amcnuz06XhC9CX0wLFniLVEEy
fXgtYxa0TOYcfQ+BEVZe5MsybK6hfA==
=1kvb
-----END PGP SIGNATURE-----

--Sig_/9XxNnr/bQBTFrzLY_.KnWAE--
