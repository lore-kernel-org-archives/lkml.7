Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BCC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EE4208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bZUzTzWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFFAny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 20:43:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40253 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfFFAnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 20:43:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45K6NP6ZVyz9s4Y;
        Thu,  6 Jun 2019 10:43:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559781830;
        bh=EHcFxfeEAKSYLC4UAySTt2xaqrXLzZzJzzgUUmkoPck=;
        h=Date:From:To:Cc:Subject:From;
        b=bZUzTzWgYZBzKhHWQTjQCtNEygnXj/GaPNJOZPlINyIv3eAAouczEHK87gP8Lh83W
         1EE0x9vsRrIFQAeSc46qNISzib0gVeLIw+dyxOMmRm3zKy5d8zs+FsHCGLj+uFCuv/
         AaFL5Vz/KwXD1KvC1XkbMFnw58Wk07iexD/WlOrQCHp94e4lPQrJ20q0Bqh4xndOOr
         dY4LsrdU8DdTJQIF2aRCCTOogOxVmzpAjIRPTZF7BIbcFH7wZGOFKqcETNAaS+IAod
         lboPQJL5lvlyZT9uth0BlmYB4V7rvs1KiDukhk4KhAgjBbwBXSuIy4nycw7DmKamJD
         47ZGpmwSwaI+Q==
Date:   Thu, 6 Jun 2019 10:43:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: linux-next: manual merge of the v4l-dvb tree with Linus' tree
Message-ID: <20190606104349.49dfb934@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Oe11bsP0hu.ON7m8r/ymXG5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Oe11bsP0hu.ON7m8r/ymXG5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb tree got conflicts in:

  drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
  drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h
  drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
  drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
  drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
  drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
  drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
  drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.h
  drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
  drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
  drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
  drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
  drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
  drivers/media/platform/mtk-vcodec/vdec_drv_base.h
  drivers/media/platform/mtk-vcodec/vdec_drv_if.c
  drivers/media/platform/mtk-vcodec/vdec_drv_if.h
  drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
  drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
  drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
  drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
  drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
  drivers/media/platform/mtk-vcodec/venc_drv_base.h
  drivers/media/platform/mtk-vcodec/venc_drv_if.c
  drivers/media/platform/mtk-vcodec/venc_drv_if.h
  drivers/media/platform/mtk-vcodec/venc_ipi_msg.h
  drivers/media/platform/mtk-vcodec/venc_vpu_if.c
  drivers/media/platform/mtk-vcodec/venc_vpu_if.h

between commit:

  1802d0beecaf ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 174")

from Linus' tree and commit:

  9293e39c5d7f ("media: mtk-vcodec: replace GPLv2 with SPDX")

from the v4l-dvb tree.

I fixed it up (I just iused the versions from the v4l-dvb tree -
although I think that they may have gone to far in removing copyright
notices as well as the license boilerplate) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Oe11bsP0hu.ON7m8r/ymXG5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz4YcUACgkQAVBC80lX
0GxHTwgAhapoLlcNm/ijbK3nJPCKVqsRXgRCJuFJNRFCOD0SMage0zi9ipz6HfTM
4RLOF6sCkB8tr06vVgFjeNQX6FjbM0pGhuFMol+S9Z4QZpbFKJFg2TYINaCBJe3B
JLEur1yCBzpJ2kIpsLDOp5mEyQtirO2+YPc7Stbb6WQDLBGPAkqmUZYmtpwYD4wC
tllX7pmk+2yMqdrgDCRbpBOunzo9IbxIC8+ewUKslTvfPUTf7uoxp08LRUDQ+MUR
yp7RaI887ErIxwXoK/G+bBJmxDa23IQszxfoGGgYhibyf9AgTGuMyO/HCRdGDDK4
8UF0TzxOyIfpXuyZff7eI7oOv9PCZQ==
=cvIS
-----END PGP SIGNATURE-----

--Sig_/Oe11bsP0hu.ON7m8r/ymXG5--
