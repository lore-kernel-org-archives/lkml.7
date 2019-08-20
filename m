Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECAFC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217F222DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jrx0cBDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfHTW0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 18:26:05 -0400
Received: from ozlabs.org ([203.11.71.1]:36917 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfHTW0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:26:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46ClkK5VPYz9s3Z;
        Wed, 21 Aug 2019 08:26:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1566339962;
        bh=9lTc1NYFTyHBOgnqHteilDwNBvRAdJT8bvlciXTGHGc=;
        h=Date:From:To:Cc:Subject:From;
        b=jrx0cBDn4EC1x4IrtqWNXtP0LHHx9c0Ve0sehoXwtt75/XpSVTpTEmRJG49WgCQ/L
         aLE9Xgp4AxItK+TlsgQdJsXtgwgZvCX9fgwtrsXZH5PijECikxqTI6FvGxtwrtEuLG
         iPCfexJ6SfB4aeFXPin0Ur9Puwc7ajl3wDVL3TUXiB2p+IR4lgEczHkSzdLghqYutr
         fDlrOrTvOU9uN+QbvTdt7cu7+GPeoRsYfzB8WE6UaxtwPZIPhKtdD+uWMChyAfkhLF
         f7eSGeOhektcopeciP7mNieqVKz0w12ZMFcRJmrjvnE8s/99LutPq1d864XiNjDSFM
         kOYeY9nyeCLGQ==
Date:   Wed, 21 Aug 2019 08:25:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190821082555.4daa14df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2=X+rvTIopLOgHSkdQjmRr+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2=X+rvTIopLOgHSkdQjmRr+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c9cff337eab3 ("ASoC: mchp-i2s-mcc: Fix simultaneous capture and playback =
in master mode")

Fixes tag

  Fixes: 7e0cdf545a55 ("ASoC: mchp-i2s-mcc: add driver for I2SC Multi-Chann=
el Controller")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: b87d37d0231f ("ASoC: mchp-i2s-mcc: add driver for I2SC Multi-Channel=
 Controller")

--=20
Cheers,
Stephen Rothwell

--Sig_/2=X+rvTIopLOgHSkdQjmRr+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1cc3MACgkQAVBC80lX
0Gz6XQf/VWDd+gGkfvGrn+ni861aZ5i0H4Fggy185g5RCamezIePJawQkRPEPx4d
jhc8fdWtqu4AGS+heHGF34kX0QK4+QbCqvXivelFt3NFvSsjPDsq8QefmDDjaBT8
bWYvCcFhYARiMLc/VYYGr0GXOED3QsyH67gWFJbSOXw7VNObYiZr8owt7kACGG3E
Rk3ZeQNQistErbmsDesjtchGmU3iFdz0CPxbaFs+4MKE2qjqBSxdwWSt5IZtsW9y
A8RXCZknYYD3zZZuqZpUPJsEYCKTvY3LA37w1pRctuKZjMwWnsjIcD510fGYKwL2
f8L+KksBuEzAjrygI/UPj9HBc9prxg==
=kzrE
-----END PGP SIGNATURE-----

--Sig_/2=X+rvTIopLOgHSkdQjmRr+--
