Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B093C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A21820B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WHChn52f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfGAFXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:23:15 -0400
Received: from ozlabs.org ([203.11.71.1]:41335 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfGAFXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:23:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cbPC58wSz9s00;
        Mon,  1 Jul 2019 15:23:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561958592;
        bh=AH7WDT+Qq9ffMvO5e7JwxjPzKJnLM/VUqJI5ku+e+Tg=;
        h=Date:From:To:Cc:Subject:From;
        b=WHChn52fmsnMze2szaoy86htycEq58dElmtdhYcKi5SQ4x1DhaMQHM6BpJqMiBPyX
         q8nrJOhjBsBrDMMVfQ+RkmFkOMDyiYhYOB2N64l07MAUO/Z6ia6qEY8lsAMVBpADLg
         8IAymN3r1uBlZg0nc3dAGxghB2GWTrAmYmkybwGIyHSHGkULmuA5B3xl4L9AHfBVTq
         Abw06v9Q1/tr+CXDyXFjQ+UAfk051hO26qRA0yDuNFmz+uOpMaNKAE1yfyswimRPWh
         KwELZITBV5eLpsaRAvXJvkZLLVU64jqYULauoWtdqZZbSvESo00Xxt4oAJIwsEYYM4
         iuSM/zkcZWbmw==
Date:   Mon, 1 Jul 2019 15:23:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiaolei Li <xiaolei.li@mediatek.com>
Subject: linux-next: manual merge of the nand tree with Linus' tree
Message-ID: <20190701152309.4023898b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HSWM+gjN6zgcZZZzc/Tu=PK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HSWM+gjN6zgcZZZzc/Tu=PK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nand tree got a conflict in:

  drivers/mtd/nand/raw/mtk_ecc.h

between commit:

  d2912cb15bdd ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 500")

from Linus' tree and commit:

  b74e6985bfe8 ("mtd: rawnand: mtk: Re-license MTK NAND driver as Dual MIT/=
GPL")

from the nand tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/HSWM+gjN6zgcZZZzc/Tu=PK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ZmL0ACgkQAVBC80lX
0Gy9PAgAgOPjSt3opuiiWqKbDDvN8nTOWqhQjhi+RKsA7XnzkRoVwWowljyQXogC
rCokK1Utgj4jv2K7+ifedexG+v0LJkb8nh/3InScPV4+SfV87zAEhM2gWiVW6Ov1
FXvWOSXnTQUqIH8YVi6PvGuPXieg1TeaqYOnKNtWjt2nlbUgh1Y9kM5lznRJAloy
lOqdY9CHC2t7aTEUT8phe1ithbzcbc2rO1FKYFTlgzUKBXrJccuH6S29J4WCH4Ut
W5MDWBmVSaZYBOfFEMyfhAKyzi5J38miMgAA6TGbd/YakSMvVC6xn1IsckFCQb6Z
jfjeS/Puu+xrsS7onrrdo583ZuAnoA==
=wH4u
-----END PGP SIGNATURE-----

--Sig_/HSWM+gjN6zgcZZZzc/Tu=PK--
