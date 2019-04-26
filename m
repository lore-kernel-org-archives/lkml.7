Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970BF206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CPPOeOCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfDZDFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:05:54 -0400
Received: from ozlabs.org ([203.11.71.1]:55511 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfDZDFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:05:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qzTB4RCfz9s3Z;
        Fri, 26 Apr 2019 13:05:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556247951;
        bh=SyU+6zUJv5EY80y4dJsRkozaWkjrBOBiJUmWFnmDkFc=;
        h=Date:From:To:Cc:Subject:From;
        b=CPPOeOCjKE7CTsW56DOWYQFAQ1vC4/FyA07v2Sitlbqd7WZoT0+LZhrPy/YKlijmD
         0wKUVDPVdU3DLTBxjXZTZTTazbDQxzPpi1UywNppRgtJTp64bnT25XubporDMIJQwM
         5YqU/c0tsdJiC04YChaPhE0jzVNmj4DGMUf1s66czGycmetETy4Csgp5laO8yKpeMm
         itvVKOXMsq1RghpCEjgBbhCjFSYoQKnqX02C9XcyfqV5pPardyDFDCRTY2DovmHtz2
         FjlsT764WuUNIspwYyoBG/RY1/LWC3m9Zxc0keqPolSaqkFFlogHysQn2p5iaE8Gds
         rTkz6EqKXAEXw==
Date:   Fri, 26 Apr 2019 13:05:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20190426130549.59f7e604@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k0dArgqWDEr04j791JcWNGf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k0dArgqWDEr04j791JcWNGf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

sound/soc/fsl/fsl_sai.c: In function 'fsl_sai_remove':
sound/soc/fsl/fsl_sai.c:921:1: warning: no return statement in function ret=
urning non-void [-Wreturn-type]
 }
 ^

Introduced by commit

  812ad463e089 ("ASoC: fsl_sai: Add support for runtime pm")

--=20
Cheers,
Stephen Rothwell

--Sig_/k0dArgqWDEr04j791JcWNGf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzCdY0ACgkQAVBC80lX
0Gy3hggAgta9W7V7Cb/iiPd73oUf4R+aUUAS4zRRgVmLIzmcoiVfZKfrlzyozGrb
XIKoTUzuqbNwQcyh35wVjT91/ZGsXufrno6CatyOySBv+5d3UnByxXo3M4wKh/lX
uwvuDRh5rzRtkwUwSsfm7zZqWgSO+HchLkFmQwAaHO6eN2oWySzLE20r+YaihBmj
+shkUE8gURA1M+X+Cvhy2H5scEak89Ac5U+0ZsY0s8BKuPZMzqB2rfn5ymis+8GK
Z6HNTEX1GV7hApAEe9gLyw+SXUwh6gLhsq9vHqcGGAx69vHc5G3o8GHA2u9njV7f
jojp7RHGsjFFulfrnRF8kEBUIRO7wQ==
=DZES
-----END PGP SIGNATURE-----

--Sig_/k0dArgqWDEr04j791JcWNGf--
