Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0B3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932C6233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZL3mNv5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbfHWCFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:05:14 -0400
Received: from ozlabs.org ([203.11.71.1]:45173 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733086AbfHWCFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:05:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46F4VF3sDsz9sND;
        Fri, 23 Aug 2019 12:05:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1566525910;
        bh=DHac/wq3kp4kkEfMoK/YQLQeuEFn6Dp9Fyco01b1RC0=;
        h=Date:From:To:Cc:Subject:From;
        b=ZL3mNv5vfU3Zm1L+Op7Dsv8dA0LB+az0HlyqXpeOPBCSDrLLe/9cJpgigEk7Oo/Fv
         JfMPu53afzHshdXcrCOgnD5mHp+OgUJKgCuhwBms24LUSL2oj5hJOHLsAZlnkmG6Hc
         r9dfBnvNxp1Hic1drhkLNzlu9oO762tJ7/eO9dsTpR+dmhfRDSELSf0url1gUdsBOP
         ZoXB+DfXmLBLJbjtT6JsC+acu0+K0l56Ce1ykD3IS7qLb2MaL30I9LkhLl0LWk+FgU
         9MRG2VGVNbEkwkuc/yT7c4QfOAeAv7WHPNjSwFEOLp/JwFyMiMehYV3a/VLt2Ov8W8
         RCm+xR+t5ZQVA==
Date:   Fri, 23 Aug 2019 12:04:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Zhang Rui <rui.zhang@intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: linux-next: manual merge of the thermal tree with the jc_docs tree
Message-ID: <20190823120454.654577c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hthhm1XizwI05UVf2WSfvy.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hthhm1XizwI05UVf2WSfvy.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal tree got a conflict in:

  Documentation/driver-api/thermal/index.rst

between commit:

  eaf7b46083a7 ("docs: thermal: add it to the driver API")

from the jc_docs tree and commit:

  af3e0fe9c663 ("docs: thermal: add it to the driver API")

from the thermal tree.

I fixed it up (the former just has an SPDX tag at the top) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/hthhm1XizwI05UVf2WSfvy.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1fScYACgkQAVBC80lX
0GzTOgf/cCYM3dCA2A4lsP5ihmo13aXj7Ljm9bHs0E3OWlhjexcOP/dU6MWJlOQ/
VYTDEPewAtguaR1V0EsCnnUOqIi5iPqW8uCmryeifKlribMpu6Y/N+jxqzBX4fnG
eV9YRaXOPnMjddffPgRaP7OJeJSZFnMYeFE2xWUn48aFEEFkBuXYOftPH1z/jSL1
o3/WgLrZ157FIywY48oWf0OJbY9QhYr/1TTT2EC0YuYEQB8m71x1THfvrRQPHaZ8
C5QkVLDX6dhZeeaW6Vz0ESSR7SFL8RwpSVLl0HoRWXAcC2iVer2ISRRosOLFyR+8
xr+U1PeHx05dxXudbd/htACLNPln/g==
=JDDv
-----END PGP SIGNATURE-----

--Sig_/hthhm1XizwI05UVf2WSfvy.--
