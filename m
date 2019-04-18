Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF7FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B819A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbfDROyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:54:15 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:47925 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388161AbfDROyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:54:15 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7A1BE200011;
        Thu, 18 Apr 2019 14:54:10 +0000 (UTC)
Date:   Thu, 18 Apr 2019 16:54:10 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 2/2] arm64: dts: allwinner: a64-amarula-relic: Add
 OV5640 camera node
Message-ID: <20190418145410.nm6c3jjwo6xw5mm5@flea>
References: <20190418135232.9368-1-jagan@amarulasolutions.com>
 <20190418135232.9368-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ahboa3r6xa7npauw"
Content-Disposition: inline
In-Reply-To: <20190418135232.9368-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ahboa3r6xa7npauw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 07:22:32PM +0530, Jagan Teki wrote:
> Amarula A64-Relic board by default bound with OV5640 camera,
> so add support for it with below pin information.
>
> - PE13, PE12 via i2c-gpio bitbanging
> - CLK_CSI_MCLK as external clock
> - PE1 as external clock pin muxing
> - ALDO1 as AVDD supply
> - DLDO3 as DOVDD supply
> - ELDO3 as DVDD supply
> - PE14 gpio for reset pin
> - PE15 gpio for powerdown pin
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied both, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ahboa3r6xa7npauw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLiPkgAKCRDj7w1vZxhR
xensAQCOVagcgDSylkXif/UTqSfpo76tHC/BFay1hla0hEqCgAEAlkdGi50wQWz5
KmvDP48t64pcmSV5rDir06szRQ8ICAM=
=Kvur
-----END PGP SIGNATURE-----

--ahboa3r6xa7npauw--
