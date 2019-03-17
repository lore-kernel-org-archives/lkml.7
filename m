Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ADCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 01:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71154218D0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 01:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j5S3Ctb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfCQB3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 21:29:04 -0400
Received: from ozlabs.org ([203.11.71.1]:47177 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfCQB3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 21:29:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44MMCx0MHPz9s3l;
        Sun, 17 Mar 2019 12:29:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552786141;
        bh=4ZKuZwOKmqvClDBaFIbkpiSeYwsvqjCdijO/SeJKsoY=;
        h=Date:From:To:Cc:Subject:From;
        b=j5S3Ctb+0nY/VHp5UDUonV/6xTLF42xN6xy6iwlYOpLr2lUf19w5S9wfmwaJrIhPN
         GR3Xo/Phcm1p3QC536sopxGhAZT52yi8yy0q2hP3kbaB5T3T1x5CnCJkfQOdocoTjN
         I5WOddLCjuurR+NiOg3UZpTV/q/bjmx3uuWAlj3KR3BlnOvEgPPwg8F5afhd4aHnPd
         a4z0CJP1InVSoARAadAufIyBBdlAgXrl9BI3jOuZAgRxAcAFDRG7xcyscqSxyrYfDn
         XnqZ4s6PRQi2X+4HZG5OW1HtP4JXyFW3m92ZEO2AN+xkSQ5CKcF3kWrahmpf4DrYGc
         nRNN+hAL9cQcg==
Date:   Sun, 17 Mar 2019 12:28:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190317122851.2cf734bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TelkFK1v.XotP9Mogd4PFsc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TelkFK1v.XotP9Mogd4PFsc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2b13bee38849 ("ASoC: samsung: odroid: Fix clock configuration for 44100 s=
ample rate")

Fixes tag

  Fixes: fbeec965b8d1c ("ASoC: samsung: odroid: Fix 32000 sample rate handl=
ing")

has these problem(s):

  - Target SHA1 does not exist

Did you mean:

  1d22c337dc8f ("ASoC: samsung: odroid: Fix 32000 sample rate handling"

--=20
Cheers,
Stephen Rothwell

--Sig_/TelkFK1v.XotP9Mogd4PFsc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyNotMACgkQAVBC80lX
0Gxnugf/X28p2RcURStB9ykF5moKb4ErdogtMKHdm8I4QdhYUP+o+imuL8s3BVsC
Hc0m2sz4F7DHhAycGRp3CE/njCHz9mrjDzgGeiq8230/pqthn/Q/HxjJ1SlSn+Og
4VpwHhP1a4qR/EbNonWxul5kmd1ryRNVqwh7AtOs/Q7VYCxD1fCAGSxS3NaVV1ww
W77esQnjOstyeyE9XIQyLOXY0bArxXKIjoBrDlPoPqDLzrBN1y0mNoUmjgnzf+6X
ddTT1qNB5w8xvKgQSVrtjiXj7VUnTUuDKx/koOYRw+qnvoVGQQrXQyW2U4uc3aiC
Znp3Bl9OVy1+aXdY50e1a46S7xClYQ==
=j8eo
-----END PGP SIGNATURE-----

--Sig_/TelkFK1v.XotP9Mogd4PFsc--
