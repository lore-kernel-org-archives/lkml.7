Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED653C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B323920830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551657880;
	bh=JcLkQWoBso0TJZmGeaqKOGeMRO4DB4Casp5mSyw9L2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SoW7egIMBDy6xPKmQSRdkNGJdW2FTCeMeodlnDn7GVAsG9OthPPAUzciG55Yikhlg
	 NQY5+eMZd4uEorDJi2X1lbt8KAVlu1c/5dqrq9s3E3MmWpttGitSYjE5sYNVRL/d37
	 CzXTd6dYMG3Ih9Wdv185SLr/Phz8waV39IBGt1Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfCDAEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:04:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50470 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCDAEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N8h9uN8GqN8kZF3iUlSc6mwssE5lPOsXCv5oRSma56A=; b=hSN/Wc5hcr++oSyB9dVdv3N3T
        bPGGLZMWse2szXVKJHo8E0nOe8khpvNNkcX6FYnheijfzDgCbBlcpUKkQ6s9tHN4BjIC20yh4YKyF
        z57afdD6pbFWQnU8GPAGULlpBc0vsbZ6yuMsV8FN2UAGwyoAiIiJcCMexPainrn7m28PM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b5v-0007N7-EB; Mon, 04 Mar 2019 00:04:35 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1CF97440082; Mon,  4 Mar 2019 00:04:34 +0000 (GMT)
Date:   Mon, 4 Mar 2019 00:04:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: dw: Add support for an optional interface clock
Message-ID: <20190304000433.GO23441@sirena.org.uk>
References: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
 <1551360342-23981-3-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Content-Disposition: inline
In-Reply-To: <1551360342-23981-3-git-send-email-gareth.williams.jx@renesas.com>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 01:25:42PM +0000, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>=20
> The Synopsys SSI Controller has an interface clock, but most SoCs hide=20
> this away. However, on some SoCs you need to explicity enable the=20
> interface clock in order to access the registers. Therefore, add=20
> support for an optional interface clock.

This doesn't build for me:

  CC      drivers/spi/spi-dw-mmio.o
drivers/spi/spi-dw-mmio.c: In function =E2=80=98dw_spi_mmio_probe=E2=80=99:
drivers/spi/spi-dw-mmio.c:177:18: error: implicit declaration of function =
=E2=80=98devm_clk_get_optional=E2=80=99; did you mean =E2=80=98devm_gpiod_g=
et_optional=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  dwsmmio->pclk =3D devm_clk_get_optional(&pdev->dev, "pclk");
                  ^~~~~~~~~~~~~~~~~~~~~
                  devm_gpiod_get_optional
drivers/spi/spi-dw-mmio.c:177:16: warning: assignment to =E2=80=98struct cl=
k *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without =
a cast [-Wint-conversion]
  dwsmmio->pclk =3D devm_clk_get_optional(&pdev->dev, "pclk");
                ^

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx8a5EACgkQJNaLcl1U
h9AIWAf9HDmrXbTnxVnkqRuJ/D4ahaWL1j36TX2EFtbe2UpYA6akgolCZN+NhyaA
Txy2CXOSJge+9lX+Fv5ocJ13dAQmsE9QONkEZTWNLeLywRfyksIs5oy4ZFxnlMrL
RWyQWY8XJN2x3JhI0cVkI8FLTGaenAy53DV0ORU9Lr/yfkt3092135Wf5ZCCUWdK
J3lViFs8ipokb8YrGaJnXA3A8hCcIujOOFGmGgVxiG8N0r3VQ3xDh9VwJBTDeqN6
gg5RBhH5Mq9YxD+8/wZhGNXB/2LALr9VpchpiUzqwjyLci23o+0lXd/2UhuPg6Sf
gSmZIBPduryrQNxDAK0H3kvQle8rYA==
=emC2
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--
