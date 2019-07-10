Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB2C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1590820838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562771793;
	bh=sPYdK/AiA+gg/7LedtybDnaOtTe9bVP0+4TaMRxUoXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oHErlb+4ywQr1q7kwh3u7yC4mG9uHQZoKk71q/jO7dpRd7OaKojy+xupSay1cJhih
	 LcUCtaDZGDlRLG2w8HNY9cteDSi9YO9WQ7Wte1jyLDY6oNZW3cDw5pCLzl1E5hg95Q
	 jIF3Ksya8TeSsExk7MW1I9FvmFISFDGIp/kXtjWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfGJPQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:16:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42908 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+NmPohTe5VcwGbBQfkbScaQQcsiEBLcON+Y9FGq7nUc=; b=KfdlmKY+62neHMNCrhnMM/gRF
        evFbuArvd5BJkHQXE5pqjmENoARRiZbft/nm9NvXFu36wszOucl7RihMRZJyG7AOFFCp9A3r95z7I
        VRKXTkKKZC3SZC3EV5JyWVk/2klLld/g5wxmGud0nxF2HPmOyhtefXd5yJlUoVqWV9ZD8=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlEKb-00082E-G9; Wed, 10 Jul 2019 15:16:29 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id AFE31D02D51; Wed, 10 Jul 2019 16:16:28 +0100 (BST)
Date:   Wed, 10 Jul 2019 16:16:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     han.xu@nxp.com
Cc:     ashish.kumar@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB memory for
 FSPI
Message-ID: <20190710151628.GF14859@sirena.co.uk>
References: <20190710023128.13115-1-han.xu@nxp.com>
 <20190710023128.13115-2-han.xu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Content-Disposition: inline
In-Reply-To: <20190710023128.13115-2-han.xu@nxp.com>
X-Cookie: Visit beautiful Vergas, Minnesota.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2019 at 10:31:26AM +0800, han.xu@nxp.com wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> dynamically alloc AHB memory for FSPI controller

Why?  This is currently done at probe which is what you'd expect
to happen here, there's no explanation as to why this change is
being made.

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0mAUsACgkQJNaLcl1U
h9Dwqwf/XfgT2pwWuQsy6NbQs7XkAQ/D0a1jByJNafCXGsuoIDp9fBsT27ugprQ0
2BkIzw0Mj2hgvh7Fx0vlB78sDiU17SLMFKWHzHxLQGCHFDeX0z2i9pfnFYKgN1fn
r0qusnbnu0ZqgFcXtqMV+muWvGVZXrXqraICv9mnbfgUc2LgizjDY6vD4RrgLrWM
Gpu65WuvbMXf/FXOuIHGSlfe2Cl4dLBkaf5Vr/sxti0r6n0bxmm3RoTO6GpS9Z+h
21pGi63ixddVXMCGOK+93DutGZcTpPx9JFuIKha3oJVNNblrXEEIBfWd4RgAQJD7
GitY8PwFzdAShFzKzne8bzwtUfIIUQ==
=89qm
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--
