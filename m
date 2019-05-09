Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B9BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814D820656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfEIGYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 02:24:16 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:53481 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfEIGYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 02:24:16 -0400
Received: from localhost (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5AC90100009;
        Thu,  9 May 2019 06:24:13 +0000 (UTC)
Date:   Thu, 9 May 2019 08:24:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com
Subject: Re: [PATCH v2 4/4] reset: Switch to SPDX license identifier for
 reset-simple
Message-ID: <20190509062412.wwxi2wsxh5qxuynk@flea>
References: <20190508165319.19822-1-manivannan.sadhasivam@linaro.org>
 <20190508165319.19822-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b2ls5al25iuwpocw"
Content-Disposition: inline
In-Reply-To: <20190508165319.19822-5-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b2ls5al25iuwpocw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 10:23:19PM +0530, Manivannan Sadhasivam wrote:
> Switch to SPDX license identifier for reset-simple driver.
>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--b2ls5al25iuwpocw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXNPHhgAKCRDj7w1vZxhR
xcsGAQDWw03uN6SKonzQo7n9s7K1TZI+Z7qjYYNYj1jsijXp3wD/ddEo49lQII4g
ZZcHpUtsMt0+tE4cKqmnwom4SS5TGgM=
=rFRJ
-----END PGP SIGNATURE-----

--b2ls5al25iuwpocw--
