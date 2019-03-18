Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB37C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9B320857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a0xZl0mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfCRE7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 00:59:19 -0400
Received: from ozlabs.org ([203.11.71.1]:48865 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbfCRE7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 00:59:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44N3r25GMdz9s5c;
        Mon, 18 Mar 2019 15:59:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552885156;
        bh=IH7BmqNOVeqDD6EZkz3rY1uLaJTcbfCfK0+/t3PXaT0=;
        h=Date:From:To:Cc:Subject:From;
        b=a0xZl0mjRHuOyt0S1HCgBSz1dkwqHJ5r8qzUNyflM9I3HJ8xiM888jDQ+4pRLwMKC
         M/jHcYT8EjAEBhtYZUrvFnILg5n6d4ZPaFyIPM954nbdL4IR2eTxAInybBpnSqKcXh
         pe9rGVz584uVYKCgNrsEB1nPy4PUG7IZc3fy055JxJcl5UTVxtkuKasJGeqYVrlqel
         p11eHFCeVcJEtYrF9t8XWsQiAOtKKfOS8jrfw0DeUK1QAYXYicRAc41c5TnltbfB+Z
         BAb5y5u8PYXAUSBxwSd+H3JKA24H0mpn7Nex7xoNTWcwLByKXb1FNNFCZTovzeapIU
         wZkKgzIllwO2w==
Date:   Mon, 18 Mar 2019 15:59:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dave Airlie <airlied@redhat.com>
Subject: linux-next: Fixes tags need some work in the amdgpu tree
Message-ID: <20190318155914.74b67033@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0ntJg.sTk1g4uTNh.zAX+0X"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0ntJg.sTk1g4uTNh.zAX+0X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

In commit

  4dc982bbdaad ("drm/amd/powerplay: fix memdup.cocci warnings")

Fixes tag

  Fixes: 76760fe3c00d ("drm/amd/powerplay: add function to store overdrive =
information for smu11")

has these problem(s):

  - Target SHA1 does not exist

Did you mean:

  ec95996ed982 ("drm/amd/powerplay: add function to store overdrive informa=
tion for smu11")

In commit

  7b19bba58f77 ("drm/amd/display: Use vrr friendly pageflip throttling in D=
C.")

Fixes tag

  Fixes: bb47de736661 ("drm/amdgpu: Set FreeSync state using drm VRR

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not wrap Fixes tags onto more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/0ntJg.sTk1g4uTNh.zAX+0X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyPJaIACgkQAVBC80lX
0GzuuQf+IKALn5aomqFo50WQB1fWMbKXf0mf8/+7ARYOjrMyNCsuhJajOoTeSdfL
CjWwDyu1i/zhdClYA5Vq3Ys5Gx5leQMHVH/G8rqhZfX3zDXruhp0YE/aklRGicco
l/QwnaSkTFvwHIDqqz6cbWXKkIehl2pT55lVpsdzkjcou0gvjPKTkaqPVGXnpnaC
OsEN6yfC2fL5/ASd3KUzlnQzC2gtGUasb5IG4ck1GVNGc/N1hgGfViyZY0v42hOX
YN92hMJHn4hkCQuGwwLz/UuHdxsJcQfrFBXSizQ2yVzkXqflp7wasIOwg/IA2KU5
Ja7d7nyiUq+W94ZiomolwgRszNnCIw==
=nfZ6
-----END PGP SIGNATURE-----

--Sig_/0ntJg.sTk1g4uTNh.zAX+0X--
