Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AEDC10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8D62077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GVLpcbcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDODAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 23:00:30 -0400
Received: from ozlabs.org ([203.11.71.1]:33121 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfDODAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 23:00:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jCt30Wygz9s47;
        Mon, 15 Apr 2019 13:00:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555297227;
        bh=OOige9tIXkA2rp06ykTG+jXZ4yp3tVn0MLMLDgKrsxs=;
        h=Date:From:To:Cc:Subject:From;
        b=GVLpcbcU5JJs+YUaVmobZ0p/Ylza+E6C4yYmopRFYoY2QaSe8vlcQUKSZyEZGnY/G
         PXbahqlrztti34XPgiMEPc1DVwIQ3bpO0ouQIpXShI2U3uwppyRfibOWVRX19UljPX
         RSGMM8an8QiWZK2Sz1DbCL9xLBxHs01EOCLuvLXvA4lkk1y0z7/cTw3H978TvHcI6+
         5B/Xx9opRkZdbXbzVLD3PWGT084aQp6Nb7GdE5twHSOmcv1oE0xSod2E202acVWeOW
         yrwaqU+yb0oIeJ9IPOZW5A8XgfV1ygZoG61ZCkkEu0JUo8G8PjKUcZwAFIe3HdXWug
         LeWokZOc/VhAA==
Date:   Mon, 15 Apr 2019 13:00:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Angelo Ruocco <angelo.ruocco.90@gmail.com>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20190415130024.68c7d2a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ATFa4udzLKNS5bup8du0UJW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ATFa4udzLKNS5bup8du0UJW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  block/bfq-iosched.c

between commit:

  eed47d19d936 ("block, bfq: fix use after free in bfq_bfqq_expire")

from Linus' tree and commit:

  636b8fe86bed ("block, bfq: fix some typos in comments")

from the block tree.

I fixed it up (the former included the fix from the latter, so I just
used that) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ATFa4udzLKNS5bup8du0UJW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyz88gACgkQAVBC80lX
0GywfAf+KbwkCrTCbinmBRefg3wBXGBhL/foeJto9yn4RdmaBH4NVabje/mZeWrZ
lWxPgRWWrz+xHAo6i7VSk/JmRuzajQVHYrh9LMNGW2n9kwqLRswT8U8NzUJRz0pf
3FxLrIorHYGtUZKwghLDi2/OcYxxuKSwAd87R9tmPq+XOtiFOztko/1jYbK/mQ85
++fVEEgKh7zgGDrqkgMGcwt8ALZWAUYPtdMPCsa2DCHDpQYmoopd6GKgZTPrenEA
XeR8mW4AfsXCEuNkTo89Qv9vMmqd4QT96I259gVuf6Z6E13uCBgpSUjaXaN0DRUH
Cei09jHfXJu5m240GVMmD5V6qLAhRw==
=yonb
-----END PGP SIGNATURE-----

--Sig_/ATFa4udzLKNS5bup8du0UJW--
