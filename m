Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0489C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEA52086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HHX4eUa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFYWM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:12:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52675 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYWM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:12:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45YL4P65dxz9s3C;
        Wed, 26 Jun 2019 08:12:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561500744;
        bh=qGcg0SR74qg8KaugUHDJ6wMVcrBY0NX8Y49yabnuGzA=;
        h=Date:From:To:Cc:Subject:From;
        b=HHX4eUa/nr4lkU8qdHeG3aXxGHe7/AwJzIUB8QZjTiQPZJ1MCX1zr+LvSUAfQNm/f
         ZEhISklPbThfbBnLOTbqL+rNHo068E2YhWBuOClglbDik0hFMOrg/E3eBL4rfcmF5t
         HoE6Kao+0vxRyp9HnoELz7UxuFg0UCxaznskf9vhwo6FrFJx/N0JJxhWXh9ai0L/x9
         xdyFjbgdyGQWw315cT4LnZcHdk4Uv/u6iy7Rr0ppCCegwWSbWHYF77sX5ZJeTdtd//
         0P4DAWZZ34a3gGzi2MoQwYQ0bpB22sF9wqGTgK3Tm5oEQGrKudBdz873dRMXOtb3FZ
         7K0Tw4wXB2Tuw==
Date:   Wed, 26 Jun 2019 08:12:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Lukas Wunner <lukas@wunner.de>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20190626081216.4b8f48cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GQh29YaGsGpYJe2hGqtHNGj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GQh29YaGsGpYJe2hGqtHNGj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cbbe88333062 ("ARM: bcm283x: Enable DMA support for SPI controller")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/GQh29YaGsGpYJe2hGqtHNGj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0SnEAACgkQAVBC80lX
0GyiFQf8CptctZ1Pj9v17+202YzkdivpT2sBA0AUPMM+QqsZThc+iL9pn4s0a3Fe
N/CrSehYBDYGsmvTX8qU60lz8F4rDn7+ERmidTKSyknkQYjoihnybAaO57puj327
d6MhscD0iJgiBlDK1U+JPAXt3MQBLtadoIsUjT12+FprUuD5niU/Ie835MvYNhzQ
BXANackw3tb6o0WwFlX3gYDWCdW4vRLSJS4s6UawtzRmxFPa6nyxv0l+n6swhSrH
Pc2DjblZPICQ70g9MeG1Ysyo7ls1RXADUZF1Hlp5UGEiq3Rpbb+3YiegtThfRukL
q75crrUaGckyPtbZB37DJdheWvoG4Q==
=62Sw
-----END PGP SIGNATURE-----

--Sig_/GQh29YaGsGpYJe2hGqtHNGj--
