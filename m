Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EE2C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518982075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfECOkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:40:17 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52107 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfECOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:40:16 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A05781C0018;
        Fri,  3 May 2019 14:40:12 +0000 (UTC)
Date:   Fri, 3 May 2019 16:40:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 3/3] arm64: dts: allwinner: a64-oceanic-5205-5inmfd:
 Enable GT911 CTP
Message-ID: <20190503144012.hvbm54xjldyqysk4@flea>
References: <20190503104753.27562-1-jagan@amarulasolutions.com>
 <20190503104753.27562-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gxwv7dhu5oerttl5"
Content-Disposition: inline
In-Reply-To: <20190503104753.27562-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gxwv7dhu5oerttl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2019 at 04:17:53PM +0530, Jagan Teki wrote:
> Goodix GT911 CTP is bound with Oceanic 5205 5inMFD board.
>
> The CTP connected to board with,
> - SDA, SCK from i2c0
> - GPIO-LD0 as AVDD28 supply
> - PH4 gpio as interrupt pin
> - PH11 gpio as reset pin
> - X axis is inverted
> - Y axis is inverted
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied all three for 5.3, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gxwv7dhu5oerttl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMxSzAAKCRDj7w1vZxhR
xYW7AP0dBgkeuoEAunfGpwjVDN2vcJEOdH+H8sPkHTrGOqStsQEA3CpzynjQPQOR
Wq/vO9MjeqFw6SmSCcX+zlG6SurG9Ac=
=s4aJ
-----END PGP SIGNATURE-----

--gxwv7dhu5oerttl5--
