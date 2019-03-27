Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D61C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B4B20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f2V+2Tr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfC0Ub2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:31:28 -0400
Received: from ozlabs.org ([203.11.71.1]:47913 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfC0Ub2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:31:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44V05T3PjWz9sPg;
        Thu, 28 Mar 2019 07:31:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553718685;
        bh=l1KL4syGN3JREvoGOoDsOZCIMDgL2++eLjU9lH781EA=;
        h=Date:From:To:Cc:Subject:From;
        b=f2V+2Tr+j45TXiGUXLkOtyZCCZnEXbXMBZSGP7cTZiFd+EhRvd/K9xFMdbaVoDQ+S
         LjPG3nXfBRCd7ef/fhnMqggS0tBQTE6ixhuFT7SZEupOD6GqPncnY62vo20Oz+Xrvp
         6QLoqtbU3+xf8I2uG6hS7eenelijKxaZ5K4exSO5kVkBeroLGzhOBz5KI2Poxio4/N
         Yd2s9HJsfyFGG5pxd/iOMG0FBeUS9UIboW7M6M3KGnWcNPq7nTP3HHvNzXox3TtUup
         gAOSJXdNbuxjj9TcXXBDgXx2sMxOVvcAektRuxm4nk/ZE2yiaBCzKyOfD5Oy19Fxbq
         AczlHC3gdYOog==
Date:   Thu, 28 Mar 2019 07:31:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the at91 tree
Message-ID: <20190328073125.0e5a5668@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_aTV00d2J2HYQum21.OJM4q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_aTV00d2J2HYQum21.OJM4q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  080eb452bdc8 ("ARM: dts: at91: sama5d2_xplained: Add proper regulator sta=
tes for suspend-to-mem")
  2802bac0b675 ("ARM: dts: at91: sama5d2: add labels to soc dtsi for deriva=
tive boards")
  0c0fccec0545 ("ARM: at91: pm: do not disable/enable PLLA for ULP modes")
  9e35b518b8b2 ("ARM: at91: pm: disable RC oscillator in ULP0")
  1b86244a4d5e ("ARM: at91: pm: add ULP1 support for SAM9X60")
  0017bace228b ("ARM: at91: pm: add support for per SoC wakeup source confi=
guration")
  3201145a666b ("ARM: at91: pm: keep at91_pm_backup_init() only for SAMA5D2=
 SoCs")
  24c2ac08869b ("ARM: at91: pm: initial PM support for SAM9X60")
  0b072b0e1bd6 ("dt-bindings: arm: atmel: add binding for SAM9X60 SoC")
  783d37b06ad4 ("ARM: at91: pm: introduce at91_soc_pm structure")

are missing a Signed-off-by from their committers.

Rebasing will do that ...

--=20
Cheers,
Stephen Rothwell

--Sig_/_aTV00d2J2HYQum21.OJM4q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyb3Z0ACgkQAVBC80lX
0GzlYAf+LUJM5k2K633dhFHvMeEqgr5MqBcKHV/HUoPWsqlJpBVY1mVLdDldBdVs
WOi2l7Dyr8+clUzbdDdef903NNkcA7Pg8+lI2r1lzhz8GtuXhKE1sWU02FRb9XiJ
4mp0588tmKNpXE8AOxz0tecfnSZIJ/tkXmspc7dNCy9mhD4AC3EvbKeQa1qrK2Zv
r8Vg+LxuAtJ3G49+tM+4vh+Okhx7ZAF4IcgVy8CxSZZYWBoicLEQdaqzA4p9B3LF
DKq62PiMubPpf/yGKrDeMK6o6zXScPJy/zrT7Rdq9w1Q1fSlDU7BKEZ8TzdLlZgk
lBYfWSE7nFBxWQK8uQdaWJnO2qcy6g==
=xgyq
-----END PGP SIGNATURE-----

--Sig_/_aTV00d2J2HYQum21.OJM4q--
