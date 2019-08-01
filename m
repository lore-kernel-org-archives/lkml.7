Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC3C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C9D20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kVqa7R9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfHAN7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:59:33 -0400
Received: from ozlabs.org ([203.11.71.1]:40397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730687AbfHAN7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:59:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zsNb5xGdz9sBF;
        Thu,  1 Aug 2019 23:59:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564667969;
        bh=0TkuU9HuDmLarxlx0OR/DQfd35PgnfMgsYQDCO6Zgz8=;
        h=Date:From:To:Cc:Subject:From;
        b=kVqa7R9/YG5+bKji5ffvPFX7YXzJJ8YPU5piqemgzjmhHFRTZyoGnwPAvEAHve7JB
         Rzu904WlpY5Mb+n2z5db0PZqKdx9Zp+MSvxAW/Cc7k6e+Oq6rMg80rbVE615ZXSrJw
         dxSf13jMXFg8C45IdNcIkfsxv9Ja/Rrm1swUuIEw6jLksfY6d2+aBQmdNll1nVUE2K
         qOypVFjtJYSlZwmG266s9vy+RVBa9qJrUEpdvZZgl2tvQzp98WCdyf0IRyH9su6tvO
         8tQrHv3nnuIS3l3H8mqw2zotQ5Ty1NudEU+zso/8YR0cZ7cTT3kfMLwBUTa96TNwI7
         VnPVIjS8/B+2g==
Date:   Thu, 1 Aug 2019 23:59:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>
Subject: linux-next: Signed-off-by missing for commit in the
 sound-asoc-fixes tree
Message-ID: <20190801235926.4b973d01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5SGfZv1e+nRLXwwPWtIb32H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5SGfZv1e+nRLXwwPWtIb32H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  66b25f247e90 ("ASoC: amd: use dma_ops of parent device for acp3x dma driv=
er")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/5SGfZv1e+nRLXwwPWtIb32H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1C8D4ACgkQAVBC80lX
0Gy7PAf+P5lE0HGGMmFaD1R4ReETgQA+5bKjl2W1gzPAjcJeh+el+ZbNaW1sfxtx
eateh+VRs1mcKNQ3XZHY4E0F1IFvnZSVYm1i7my2Sofqx8L3S0s5Kkhc/IAZHwQ7
P3lFb4u5hE9TS/IBEeJcK9qMvalLLam6NXMe7Vw2+nxc1s8w4hp/KT+KatmlxL1b
qKNNm/V1I3wvf4mQk+K9q4A2qscQxtOj8LjLiDsVq7h2qe9qxtEWgJezUyBMnZ0I
5kRf8FN8DW/JpOd2gRM6HvL1JGqdDth7aXm+a/SDVkQAr+mNWSZnlbsSy957HMAb
jyTsX1KaBKmIso5iz7xc4T1dIYsRYg==
=0/+O
-----END PGP SIGNATURE-----

--Sig_/5SGfZv1e+nRLXwwPWtIb32H--
