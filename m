Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F12C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C335520848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RQmnmT+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfEPWe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 18:34:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfEPWe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 18:34:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 454mSJ2tnYz9s7h;
        Fri, 17 May 2019 08:34:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558046064;
        bh=4WF9tFk6sqWOmZbS/IusM33ZL2tuh/ex1I2D3sr5cf4=;
        h=Date:From:To:Cc:Subject:From;
        b=RQmnmT+Xm0upbU+cpgJxpoi+Dxnf+HSV/Q/Q8ZQleXT5OaCWnK9o9HgqgotfDqZko
         whu2+Ww2KYzrdHxXmxLfn6SiLh7igCNmHq5kMprnq+okuxkF/+3cixWNE6fvyUe011
         vL3QecZwDOvfJ6kx6+6HIJ87W3Mrtc/ezKRbQj3s81JjpO3D0POWqgsYkWAtra13Ek
         3UnwdjnMjGpnS76BAbCIX8ZOKRQUBri297spM2hNBoOEOTEHGCUmsmK/1qmckgGMsL
         mBXH4XYjn+O1aut1WYbKVQ0QimdkRYFZ8huqbrEFnatYEeEovMaD3KCKmvKbG9XtQM
         cH41P4yZqXmUg==
Date:   Fri, 17 May 2019 08:34:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190517083411.56ae5997@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wB_apB0HY22uBX=AvE.6aQR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wB_apB0HY22uBX=AvE.6aQR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b06c58c2a1ee ("ASoC: fsl_asrc: Fix the issue about unsupported rate")

Fixes tag

  Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split fixes tags over more that one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/wB_apB0HY22uBX=AvE.6aQR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzd5WMACgkQAVBC80lX
0GxAcgf/bi0GX7TE6eiZ1/Y+J09jxCdks7tcJ75ey1IVBxTooVZTYYg3SEKMIIBl
X2rb5YozHithd6us+XAn58/KNe6z8fGZ9gnhqvISRNfLGb7qcamMwFvJoefs1lI6
Kc+ZjMwGF2pChp+kQceShsiVLFTCZVs3DCeq4S7mHsHXUe9ZAPHfOFNTo/KvCEDM
r9PBhzHKh7cFXDFQ63aI8fEDitPr2Dtf8CqAPykMrXHHXs0ckjProfTz/PFV8E1a
kywKv9nru/tbdGMP5C1qLej4tegLU+JrBDDsCa0OEyDCKFulkAL5PLKD0+1deA/t
YQ0XJDx/Q00fR9Ivx3odvOJqkFEIow==
=nwN0
-----END PGP SIGNATURE-----

--Sig_/wB_apB0HY22uBX=AvE.6aQR--
