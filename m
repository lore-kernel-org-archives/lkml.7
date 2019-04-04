Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005BCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44F420820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mrr2w2bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDDCrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:47:05 -0400
Received: from ozlabs.org ([203.11.71.1]:48783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfDDCrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:47:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ZS5f1xymz9sSW;
        Thu,  4 Apr 2019 13:47:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554346022;
        bh=son33K3J3oXAeB/dhmB+jPSYEH1WzpcvrFCwKRq2Ji0=;
        h=Date:From:To:Cc:Subject:From;
        b=mrr2w2bm3vCyssafdvpatGr0Ny7rLGkwHporsHZL5/rdmJ2DAV8++wnHoUcA44KiT
         Zq6LBvT3ZobBgjKeHKG3+sjDboyVj3KUJk1TLbm8BGFk+V+eswg0DgLiCQ5vyKCcKn
         JlsuTPCDM2RAhBAkBj1Cv0h3nV2SFqOLMkbJathsTW8tFzXi/Rpx1yyeLa19ZTjHfS
         8Ai18rdFzd15PqVBD8miDYxz1unhTTrdru1ECHZ4LHNKqKCcdI/VUY/nFQ5YtVESiG
         f7NGcVIPIXedAiUMmp9AnEP9QvNr0yBplgtVvc2CTZ9VxgWen0pMoobVb/SyAbm3k6
         rSyHwytzwe7xg==
Date:   Thu, 4 Apr 2019 13:47:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Roese <sr@denx.de>
Subject: linux-next: manual merge of the staging tree with the spi tree
Message-ID: <20190404134701.2cfe692f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LFNzN5p_WT.Bt/wNU2IvqoP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LFNzN5p_WT.Bt/wNU2IvqoP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got conflicts in:

  drivers/staging/mt7621-spi/Kconfig
  drivers/staging/mt7621-spi/Makefile

between commit:

  cbd66c626e16 ("spi: mt7621: Move SPI driver out of staging")

from the spi tree and commits:

  99b75a4e3275 ("staging: add missing SPDX lines to Kconfig files")
  97ed8eab2a00 ("staging: add missing SPDX lines to Makefile files")

from the staging tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging. You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/LFNzN5p_WT.Bt/wNU2IvqoP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlylcCUACgkQAVBC80lX
0GwrIwf/aybXd1ndlWc47YMB8BEC4ztchpwPSaCaynVYxt7dzuAqkyVpGZTpDTS4
MVPLGKhVIoR2X2y3210+BcIEXLMApytPgLEtkm99A9Cw+vMDOlvgt5hiytaD9SaB
NCMthJP+FBQBFW/iD6ae/nlWj5gbeOvTlLGumSWZ7UWFJTgSoi3orfkDtQOikCDF
iRHFaOxLm5ioLoV45idqIS0uBnn7ONe7ONo4NtFjBlwQROzjKmDOfwu8gGVbqNJV
xoY9kh3GB7FnQ1Sf5fK5TmDvJZ72DwIig0CJ2ZhUB6mYh2p0s2dBsnEpYmuFALHg
d9NwGi8Kyu+Nm/nwQs5lP6fzjvgJTA==
=8Qpt
-----END PGP SIGNATURE-----

--Sig_/LFNzN5p_WT.Bt/wNU2IvqoP--
