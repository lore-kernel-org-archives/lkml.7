Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ED0C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4687121835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570440687;
	bh=JaINcyQNLKJhhWm6YuBkApUi5w0bmV2v7c3hLArmMVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zsGbRNh8CpWbazSPtQn385rFHFOg7lwXeZtuLfVsDUZyvyCHcRFTAzKzac0S4UArk
	 1djrLsDC2sbl4NRDeQGLsS6zszUo6dmL16DKF9+YVC7KMvz/VusZ/svDGWOtumplBH
	 fBz4oUXU52DzVeNtehYJ+Qhcb/sflMLRp6TcVPso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfJGJb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGJb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:31:26 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FDE32084B;
        Mon,  7 Oct 2019 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570440685;
        bh=JaINcyQNLKJhhWm6YuBkApUi5w0bmV2v7c3hLArmMVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kd7fdRTlUPPtMG3X4zZBeEJWzSxB41hcUU2JEQL7IbNvkBcpHYYrBAJtWsAKa6WGp
         o3/OJOQ15zc6Czm/5Vy/8FTFe8OoYnnnOUrFHqkTTuuKS9WvKbDptV2MTvy98cIESh
         J2C9xVNo0kNqTdyOo6jlggUMaFXk7uTFHzPV8/vI=
Date:   Mon, 7 Oct 2019 11:31:22 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v10 1/6] dt-bindings: sun6i-dsi: Add A64 MIPI-DSI
 compatible
Message-ID: <20191007093122.ixrpzvy6ynh6vuir@gilmour>
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
 <20191005141913.22020-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hcbxlzriavurqgww"
Content-Disposition: inline
In-Reply-To: <20191005141913.22020-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hcbxlzriavurqgww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 05, 2019 at 07:49:08PM +0530, Jagan Teki wrote:
> The MIPI DSI controller in Allwinner A64 is similar to A33.
>
> But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> to with separate compatible for A64 on the same driver.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> index dafc0980c4fa..cfcc84d38084 100644
> --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> @@ -15,7 +15,9 @@ properties:
>    "#size-cells": true
>
>    compatible:
> -    const: allwinner,sun6i-a31-mipi-dsi
> +    enum:
> +      - const: allwinner,sun6i-a31-mipi-dsi
> +      - const: allwinner,sun50i-a64-mipi-dsi

How did you test this? It will report an error when running the
validation

Maxime

--hcbxlzriavurqgww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZsF6gAKCRDj7w1vZxhR
xecaAP9RqOVF2LeEc8hVaJ7qENbVYYasarhmNzXWXQ/tp03R3gEAt6lJLwS2PUdi
ULmqU8z92Ol9GjvEOXSZB3G08d0G9wg=
=VSAg
-----END PGP SIGNATURE-----

--hcbxlzriavurqgww--
