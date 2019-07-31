Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7587BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D82F206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q2ubVie9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfGaHMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:12:25 -0400
Received: from ozlabs.org ([203.11.71.1]:56423 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfGaHMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:12:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45z4PL3hKgz9s3l;
        Wed, 31 Jul 2019 17:12:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564557142;
        bh=UdwW/mnUrireVfWyIo4Ee6IEoXzagdV0hnePRChllbw=;
        h=Date:From:To:Cc:Subject:From;
        b=Q2ubVie93phsnRvmBAwuhn8LRJydx4UX/IHz51DwJ4zor0EKYBNBRtTIFlQ5FP4AI
         xNeD8wkpBTutkTP5ffh1Yfg4PnCA/MXtTzpLGt6TlI7MS/3EqxY9+rCHPb8thfS8aX
         vzKqDEPrBbqO3kZbCHV2a99ZyASKnjyBN2tC/jwjVLMWESOlLXAKU7dytr1LH+B8l+
         9CUSjwS1G1U0Z8QWToCkg6cslLnmJI3jHkpMurd40KzQFcirMq2hz2yIAei3FHV68e
         KsB2nrIFEtBiYqXBl8RjVd4fdqcaWQ1l5L2KhHJliFUnswqE3qaYXnH0K8jHHmcIfZ
         XIpwg8TbqwSUg==
Date:   Wed, 31 Jul 2019 17:12:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: linux-next: Fixes tag needs some work in the tty tree
Message-ID: <20190731171221.326095e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.baL9FeGwHuZIWh+eOtLaWa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.baL9FeGwHuZIWh+eOtLaWa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  fa04d8c1c150 ("tty: serial: fsl_lpuart: Use appropriate lpuart32_* I/O fu=
ncs")

Fixes tag

  Fixes: a5fa2660d787 ("tty/serial/fsl_lpuart: Add CONSOLE_POLL support

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/.baL9FeGwHuZIWh+eOtLaWa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1BP1UACgkQAVBC80lX
0GzAAQf8CmfbG5DLxBciqquYtgOXsgCHbJEQQBWrgf73/n7iYrcdvzOOd7clxxC0
lKGG4xvKEmUD7ITNfs3QVPTMijBBuEwPXw39uCfn00QP/rE2aQTgusSecNxf7Za6
RA0PF7dtlRUJ2rc2uqusDps0hr2Gxt+xjCez0izTx8VK90F1FBTFHJxQvFq9rdnU
2W1JbuV5/VjHpFodWRn5VETTsqkqqdZshnyeiLR0EfPdBX/Xj1P8o58Zfz5gomHc
7MJ+eJd9lR53xtk+UWJzS7HDRoRS5gSy/eCFm/Gkw1bzazcn1pGwIFcWerTNBk3m
Bcs5iO4ERAhm7Q7YbI2IrBer7QisrA==
=a7It
-----END PGP SIGNATURE-----

--Sig_/.baL9FeGwHuZIWh+eOtLaWa--
