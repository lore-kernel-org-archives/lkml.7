Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F931C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A798218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tkiMUKi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfCTU6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:58:24 -0400
Received: from ozlabs.org ([203.11.71.1]:35495 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfCTU6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:58:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Pj1n1JgLz9s3q;
        Thu, 21 Mar 2019 07:58:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553115501;
        bh=SX0CVgKXSxgaII5kPcChVBCgfsYOOcVj2P9e+jwEB4E=;
        h=Date:From:To:Cc:Subject:From;
        b=tkiMUKi8i+u8v+Iu5c/LKKFFbBct6ZUPragVx9J3Rt4/eIgq2+l36/sewvT4CFJFD
         MxkPY3Po3KPrqCj7L1LMrKEqrXRskwDZZSqnuImR6dYrhJIOToj02njKLpWKahf8em
         nrQ2QFuGQZXoVmR2L+t/VR13YxnvFgoqmJ0+liNGRPEYOeXJL7Zuuie1u5c0RRnTqH
         vzhkQlIDdS/MleJCO2Ied3Kx/Cpr/hiCITCNVDJnVavD5/e+7A5CuFW0Ky0ghZBIDd
         RU3j+J32qunSJvwrLlFBBJ4LaMdTNRxkQzPg8JXY6xqLUkChvTjHFvJZSCrm3pNxyK
         D0XYshl/ogJiA==
Date:   Thu, 21 Mar 2019 07:58:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jon Mason <jdmason@kudzu.us>,
        NTB Mailing List <linux-ntb@googlegroups.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: linux-next: Fixes tag needs some work in the ntb tree
Message-ID: <20190321075818.24f9703a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wfWlJaTnCrn0=Kn4xr_QCJT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wfWlJaTnCrn0=Kn4xr_QCJT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f4d0dd1064b8 ("NTB: ntb_transport: Ensure qp->tx_mw_dma_addr is initaliaz=
ed")

Fixes tag

  Fixes: c27ccb899219 ("NTB: ntb_transport: Ensure the destination buffer i=
s mapped for TX DMA")

has these problem(s):

  - Target SHA1 does not exist

Did you mean:

  c59666bb32b9 ("NTB: ntb_transport: Ensure the destination buffer is mappe=
d for TX DMA")

--=20
Cheers,
Stephen Rothwell

--Sig_/wfWlJaTnCrn0=Kn4xr_QCJT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlySqWoACgkQAVBC80lX
0Gx1tAf/QOrwg468avcjYsUY2uzPNwTYuM1iGFnq15ztb04t10OLvcTKOIizdD+j
Vtn6b9ZxkVoQUOER96omj01F4ZHbWntGOx1xKmsGg97+XJg9O0nb3bGqJo3RLnlJ
uNYE6jLi+veZEILiEJ7MYqWw11EM/blYVp0YUg8/rrA/jsPkNL7xLutce4IPMepZ
PZPRaskEbxTPWqkmU+bEyuSCyBGZSq4B7GxHRCbdaEAGMPEejcIkBwrWr4y6ddHM
UwjHkoyQzkF1ceGiTMqBQPmVimBKsLUX2pkQCZ8Vh02oF7LpC9Mm+2d546ufj06I
SFlqceiMAykAzB3rGP5k4/OaZQh2XA==
=0+8A
-----END PGP SIGNATURE-----

--Sig_/wfWlJaTnCrn0=Kn4xr_QCJT--
