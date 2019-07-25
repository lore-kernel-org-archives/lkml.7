Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759F2C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FCB2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fOxEu9cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391543AbfGYLHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:07:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389082AbfGYLHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:07:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vTvL4Lhrz9s00;
        Thu, 25 Jul 2019 21:07:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564052847;
        bh=Bm2c/QSVpXGWLQP3GEz/S0gxu20d8uO6T7h8lSbMO/0=;
        h=Date:From:To:Cc:Subject:From;
        b=fOxEu9cvow4vsalwglBu7llywp4Ht5KHchoiLpa2l08t2y9GLAM45N4p4m/mxTt4I
         S+bMYgv23lDvHAuE+pjjOP6TJUZcpdj+U+rqktPikKmmjQ4/0T+XHnFwuP4tw2W+2I
         pIJ/kwWSJmJHQdBMQUOMLX4s2Tqf3Vr3Ftza/fvNmZ4N26M6+6DN4k1UVGPpjupIg1
         ynWcgZFcNUub63areMo8bWl1wGE1Z+9tpa4HhfTJ9TcOManJe0lQqzW10Ez6XarGi6
         Wo7uboitLvRmz4kMGyS/Klm9PvpdnZ+YQe57jxMovZv2uVNY8RWSwA0sX/gJVQ0eD/
         SwYG+RNRIF4fw==
Date:   Thu, 25 Jul 2019 21:07:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: linux-next: Fixes tag needs some work in the nand tree
Message-ID: <20190725210724.66cb82a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=uSDGb=wVzfeeztIT/D4rrk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=uSDGb=wVzfeeztIT/D4rrk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  0ade3f0f5877 ("mtd: rawnand: stm32_fmc2: avoid warnings when building wit=
h W=3D1 option")

Fixes tag

  Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/=uSDGb=wVzfeeztIT/D4rrk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl05jWwACgkQAVBC80lX
0GyZiAf+MyUTf/TmK/j5SYDBVNAAeG20sPGUFdO/797sw5leIcrEpxdG8eeGuHr4
tcGkEbfGmsWtjlzIGgbJZPffVvK7VlZPv3ZglOXBQnfp2gjtOq55w/r/qJKRm+Bk
VtD2xiYh43J88sxAjcZV+7SzAB2Si/QBp6S4L+QUK+g0//AhI7etTA3emqD0gi/P
nq43y3+Gw4mbbSojHFqNa2rhN88sI3EqlQRFMRVMKRm5u0pNUodTKdOA0NCXhNUC
zIVT49C5DbEMgo4HS2Tdxy54Jx4HJiU4yk+ecRU+WBhScKKQBDJDRi0BKEmu9Fwj
08W78CuRah5kwWI3ff4fXT4MRllkeg==
=hvw2
-----END PGP SIGNATURE-----

--Sig_/=uSDGb=wVzfeeztIT/D4rrk--
