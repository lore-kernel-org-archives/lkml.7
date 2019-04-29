Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 04:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5DA2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 04:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P1e13FVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfD2EaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 00:30:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51471 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfD2EaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:30:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ssC05Mccz9s6w;
        Mon, 29 Apr 2019 14:30:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556512205;
        bh=+c0oXz2sdKbyCzypp9ynSSAQxxT+vq3iZqoM414nTEk=;
        h=Date:From:To:Cc:Subject:From;
        b=P1e13FVt1AqgRPrVT+9dqCgOb0WUFmQGhFmWCww3Kgw8kx6tOI5FK+N9up3Ec7Xcf
         eNeC55h1JN+uCy7QkI0917F17CmoLC1Q9yvraoLVWmUc1flTeG5Yvof5rf5mvpQi2Y
         ClI7QBMDf/jla06/rLXjtK3lUDjygI5BeFtbhPVkibhlPgHLPehR6g/s1TQcTUVLlu
         XrA4J9s411DYK850X9APO/KWwLqvSibGWDAHKc7WMORzkAHt310S3DbdGMM02+0Dlq
         t/ESORe5wXyX+DNGKSnjoem3BAxr7oj93BpVpOetbYuOc2OcygCJVP3ONUqrSEgKjY
         OaUiJZQtgW07A==
Date:   Mon, 29 Apr 2019 14:30:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20190429143003.200eb702@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qnFLwNk6ilC8BT.+6Cznw7."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qnFLwNk6ilC8BT.+6Cznw7.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

After merging the spi tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/spi/spi-ep93xx.c: In function 'ep93xx_spi_probe':
drivers/spi/spi-ep93xx.c:654:6: warning: unused variable 'i' [-Wunused-vari=
able]
  int i;
      ^

Introduced by commit

  06a391b1621e ("spi: ep93xx: Convert to use CS GPIO descriptors")

--=20
Cheers,
Stephen Rothwell

--Sig_/qnFLwNk6ilC8BT.+6Cznw7.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzGfcsACgkQAVBC80lX
0GwECgf+OkPEcwKW0oeK3GVLfo0Ovcb3zrzOzfgQk8PfD5dLZvN6m9TQji5IUC/j
F7MBaIHRiUSZK8eNm53EoVema4yQdP9MP2Wb/ysC6TfmWseEw2tIBVebsXwgWCJp
Gvf8YLwF0jg2SbXL4fHEeDyLw/m9sWXDwOjtIpF8wp18a5zmkFkExcPgWT6ibi5S
G9Gjw3xPeLYVEq0XDz39D+T3CXqYTqC1XNXOqHOJ8eWtEnNB/BJvANmnj6vQuc3V
1VikmPAGKUwexJlc+LFbq4QracoNt5MbdoZs/YiGGrgBKgCvFIR463eFKM/SPtIl
E6BIxdpeu1kNbu0aRaObP/+y6jMF9g==
=5mZs
-----END PGP SIGNATURE-----

--Sig_/qnFLwNk6ilC8BT.+6Cznw7.--
