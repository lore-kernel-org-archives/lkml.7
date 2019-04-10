Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4812C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1062082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="spJXTs4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDJV2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:28:04 -0400
Received: from ozlabs.org ([203.11.71.1]:47259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfDJV2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:28:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44fchJ4tB4z9s0W;
        Thu, 11 Apr 2019 07:28:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554931681;
        bh=OvV58N4ZCm1IstRGxAt9EjsS5fpIPRP4pA7krluk5LY=;
        h=Date:From:To:Cc:Subject:From;
        b=spJXTs4OaOm+BahA/pj6URzNUOiOna6mKiUk5Xial2lDbD/4q95RjTQOjwz/+Kw6g
         FEf4ajUnz4sCvzGuG+LOZBuVGxWpK0eyL5vgT1Rr91jwOiA1KRLtyY/iVfAmZqTmhs
         YBltgY06y9XTd/Q8or2gw7fLTmmFPcJ4/WiZXpWZBNfuHd3VHuNat664VqoFjvgpbe
         t2NeHclO57iqQxuIKfCDAMpE4+KisiSfEMbKN3nMKTrydDdEtEBt2RuXG95UwKsXiA
         7QQGAwkak9LgPJ/NLXbQeQSa18S76zOFjc1GY3pbP0xj2fLXbf625QW0T2oL6/1ddd
         5bFLU1doMadUg==
Date:   Thu, 11 Apr 2019 07:27:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: linux-next: Fixes tag needs some work in the devicetree tree
Message-ID: <20190411072758.4fa7b9a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LQokV/iAjCunMV7O7o+hXwJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LQokV/iAjCunMV7O7o+hXwJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

In commit

  7800990023f4 ("of: use correct function prototype for of_overlay_fdt_appl=
y()")

Fixes tag

  Fixes: commit 39a751a4cb7e ("of: change overlay apply input data from unf=
lattened to FDT")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/LQokV/iAjCunMV7O7o+hXwJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyuX94ACgkQAVBC80lX
0GyX+Af9HttUtYMG3UDHyUHqYx5Zr/yb8Y9lDg9zvZaCVaL3XW4ddRTY4sOVhHdp
R8ghiyfyqvgk63ZFvRLIA1DHBPoPyrhOgHNZ8sMU4pwnDfYTZDtixck1bRl/524w
1x+lRqWCCD6RCLPfpy12Rms90Gl7UQ6CD8Xm6CFYtOUm97eQTUizzw8ugE9HCOmq
0tTqIUuYPjSqcBbkl2fOTeiPfqfhw9Nn+FeEZWjrGXcCPpPygXsRfdr7U3XoqzKx
TUtYftGqaVqcIUAaVp81KDFzyAJNof4UUd09ROmEmuRSvDjYydGfNYE4kDT1JD9G
jedBFTr8BpsHV5OR+Y0XDEVncD0OjQ==
=pVTM
-----END PGP SIGNATURE-----

--Sig_/LQokV/iAjCunMV7O7o+hXwJ--
