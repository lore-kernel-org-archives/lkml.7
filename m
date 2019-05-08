Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F37C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1493E20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SrfcNIKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfEHVxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:53:18 -0400
Received: from ozlabs.org ([203.11.71.1]:36937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfEHVxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:53:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zqwV5L36z9s5c;
        Thu,  9 May 2019 07:53:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557352395;
        bh=t68SMhMlojtdWXHtZ81TNturMPkafFqx2s//xlsE/y8=;
        h=Date:From:To:Cc:Subject:From;
        b=SrfcNIKafzMJ19gtwJ2kWSPjuLVHTMjVEahLAqNNgwURC6Eab0sT6TlpSl24pVWwh
         T9z0pzFipUZBwTk1WG3CtDw75aZ2g+4LkhZvZWbm2Oa9UnO0nZ2ZYy7PFj9V5tYDvC
         l7Thx/UeLlpG+3Wnf2TPmwf8ta07SpluICf+o9yS92scFef1oHWEqBbbboQLpfD1NJ
         LpxquIHgwbi4g4t2to7QdUeHwukImqcrqBnCTin5PUD38CowQl8nEYX6dmczmGSdvn
         eOwCjB0FmAzKmEmG0cW5F8JoagaQkcZdTlHqIXuGqWgMKSAeYz55TERHVEF9JLxEEH
         YsO80J87Z9zvg==
Date:   Thu, 9 May 2019 07:53:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: linux-next: Fixes tags need some work in the v4l-dvb tree
Message-ID: <20190509075311.1865ca8b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FHpSzG6JJhO86JmkIl_PTbX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FHpSzG6JJhO86JmkIl_PTbX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1199fa8c0ddd ("media: tegra-cec: fix cec_notifier_parse_hdmi_phandle retu=
rn check")

Fixes tag

  Fixes: 4d34c9267db7: ("media: tegra_cec: use new cec_notifier_parse_hdmi_=
phandle helper")

has these problem(s):

  - the ':' after teh SHA1 is unexpected
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

In commit

  1e4e25c4959c ("media: atmel: atmel-isc: fix asd memory allocation")

Fixes tag

  Fixes: 106267444f ("[media] atmel-isc: add the Image Sensor Controller co=
de")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

In commit

  79199002db5c ("media: atmel: atmel-isc: fix INIT_WORK misplacement")

Fixes tag

  Fixes: 93d4a26c3d ("[media] atmel-isc: add the isc pipeline function")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/FHpSzG6JJhO86JmkIl_PTbX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzTT8cACgkQAVBC80lX
0Gzd/wf+OnEgksfPQzlPlH6WxyYgQzboNgR8RrbKfxgDPPLdkINV/fXwGvacw12Z
pTLvj8hk6DINl2H1R59AsIkVu/mX43fNF8+hIz+VFsAQiKFiGapIMkIb+GfWPAGp
wZok4LXIdNcATZvmr9xBlNEObbhG345AbgN/fUpP1spM/sOOYZYnzo/WSc9bOcWE
lKZ1KJTPIES/G6ixuqILFn0DRllxV5Z3C8FrEwLdvFE0eArkDvW5PKorsb9keTQ2
lvT/KitWYvwqmoTnQLoKCe5+38gxmpFHDUKPNvVRa6peICJIj0i3qeEeGq4Yz50v
UEpr7kVwXPRUOi3jOwasUB4K5hs5xA==
=n53M
-----END PGP SIGNATURE-----

--Sig_/FHpSzG6JJhO86JmkIl_PTbX--
