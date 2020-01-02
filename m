Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E344C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4540A21835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577963032;
	bh=lyuQwYk6duK7MRRoZwouWCgWYszfADDHUK+QRJ9MmW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xMWmxZOTd6uDJnPQNlXwjuTokq+o5JS0xv7Vaee1mt55Ge4Bb2sMSi9d3b0pqRCWK
	 rRrd/vCeAJnHJ3PDq+HMJkUXb3wHmp6lindJdtZZ2vVozLhJDjhcseaOMa8Vc7gGL7
	 aY6lhVJKBWiRddE4G2P5KNsrIrVJ4gHsg3U0coV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgABLDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgABLDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:03:51 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140F2215A4;
        Thu,  2 Jan 2020 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577963030;
        bh=lyuQwYk6duK7MRRoZwouWCgWYszfADDHUK+QRJ9MmW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9F7Onm8xocF2Q+5nqgcr+BNQIIsFDSMp1mLSNtnpHRUwDXcAn0vdgfxYhKm9z2aY
         LENy+LulhaOZmhM+KRmCYsGpCyY12E6fxwnNKZ78vnSe7EktsiTP5xBhmAKaBztR42
         hAgg9HmVyHQRWAAxwZJ7gJsuBzYGpjHKPq0m3JlI=
Date:   Thu, 2 Jan 2020 12:03:47 +0100
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
Subject: Re: [PATCH v3 6/9] dt-bindings: sun6i-dsi: Add R40 DPHY compatible
 (w/ A31 fallback)
Message-ID: <20200102110347.v7lsnmmsbp66r3ia@gilmour.lan>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
 <20191231130528.20669-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5qm5gfldbu2p5gzt"
Content-Disposition: inline
In-Reply-To: <20191231130528.20669-7-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5qm5gfldbu2p5gzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2019 at 06:35:25PM +0530, Jagan Teki wrote:
> The MIPI DSI PHY controller on Allwinner R40 is similar
> on the one on A31.
>
> Add R40 compatible and append A31 compatible as fallback.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - update the binding in new yaml format
>
>  .../devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> index 8841938050b2..0c283fe79402 100644
> --- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> @@ -18,6 +18,7 @@ properties:
>      oneOf:
>        - const: allwinner,sun6i-a31-mipi-dphy
>        - items:
> +          - const: allwinner,sun8i-r40-mipi-dphy
>            - const: allwinner,sun50i-a64-mipi-dphy
>            - const: allwinner,sun6i-a31-mipi-dphy

This isn't doing what you say it does.

Here you're stating that there's two valid values, one that is a
single element allwinner,sun6i-a31-mipi-dphy, and another which is a
list of three elements allwinner,sun8i-r40-mipi-dphy,
allwinner,sun50i-a64-mipi-dphy and allwinner,sun6i-a31-mipi-dphy, in
that order.

Did you run make dtbs_check and dt_bindings_check?

Maxime

--5qm5gfldbu2p5gzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg3OEwAKCRDj7w1vZxhR
xYg8AQD+cQIazIyZ31zNcUjJMQLtkQ/R7hrnYDW+zDPmikoO1gEAjLRGNbqfmTOI
GKoV946i+sXeig/aykX9B6o8FpF0cg0=
=rFQC
-----END PGP SIGNATURE-----

--5qm5gfldbu2p5gzt--
