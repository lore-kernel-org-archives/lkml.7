Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C1DC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EA1217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577963059;
	bh=3LNe3iq4StFtI2iDqoiQdEX5CNmS4n6Pm0K46y0rQn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a0wpGf6JAIuH3bsoLy2E8dm0bi+uMAlhj2Dyn8fEo+Pf2pDfLe627RmAzYLM6kKVl
	 adzSFEcD3lnbARDqw3xEhpt4KpBzvt5sX2wo+BH1hS8pwi9+WxKtEJxzma7jTEhW/v
	 /bUCx0D1h+raGrZEacEbZPwIVplWPA6yE6RL8MM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgABLES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgABLES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:04:18 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47207215A4;
        Thu,  2 Jan 2020 11:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577963057;
        bh=3LNe3iq4StFtI2iDqoiQdEX5CNmS4n6Pm0K46y0rQn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVtGJkDM8+eS4K5lHhsXqMDzObmErV/mA0SM43IPLKAiQMWCxyfiXAl7ZN0g9WEK6
         +uBi06ZlcF8DQgbWHRW/MC1034bd9h3uP2mvCBp6xSx1JjII8dpuawFMIrC7kwMABZ
         zIbSjojPzOsg/GnURuFNNHxlK7lPValhQDKlafNI=
Date:   Thu, 2 Jan 2020 12:04:15 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 7/9] dt-bindings: sun6i-dsi: Document R40 MIPI-DSI
 controller (w/ A64 fallback)
Message-ID: <20200102110415.rtehrvtq3darfv35@gilmour.lan>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
 <20191231130528.20669-8-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ryvuaned34qshr7z"
Content-Disposition: inline
In-Reply-To: <20191231130528.20669-8-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ryvuaned34qshr7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2019 at 06:35:26PM +0530, Jagan Teki wrote:
> The MIPI DSI controller on Allwinner R40 is similar on
> the one on A64 like doesn't associate any DSI_SCLK gating.
>
> So, add R40 compatible and append A64 compatible as fallback.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - update the binding in new yaml format
>
>  .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml    | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> index d41ecb5e7f7c..138ffb6ae403 100644
> --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> @@ -15,9 +15,11 @@ properties:
>    "#size-cells": true
>
>    compatible:
> -    enum:
> -      - allwinner,sun6i-a31-mipi-dsi
> -      - allwinner,sun50i-a64-mipi-dsi
> +    oneOf:
> +      - const: allwinner,sun6i-a31-mipi-dsi
> +      - const: allwinner,sun50i-a64-mipi-dsi
> +      - items:
> +          - const: allwinner,sun8i-r40-mipi-dsi

Again, this isn't what you claim it does.

Maxime

--ryvuaned34qshr7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg3OLwAKCRDj7w1vZxhR
xchiAP93RIGrX3ISxW0q1Z138tIsQSb3kOZXPC1XEawoRlNQHwEAzJ9E6ZE37C7r
7TLlBdK3HIs6GDySKpbjycSin4zM6wc=
=bTyi
-----END PGP SIGNATURE-----

--ryvuaned34qshr7z--
