Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E398C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C2C21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577962469;
	bh=Fy88OIUGBdZink3Zu23Vq6yGNZlM5ZZ5JWMt1esy4l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=obdNrNAskREbBTlP1CF0IcC5vwXI2ruoLTVTYVVXh7UCaHMJSjbfIOWWf3oM2r74S
	 qAtbkJtgx9gvcdhFyFUeYC134+7RWGxprYeZfYYjKBHR8d8h3C7l9yAVOiuxbWvw3i
	 qjAAhcGuDWd4QKLgj+AUDG3FrIjm5vG1+5fPYplI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgABKy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgABKy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:54:28 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF7D9215A4;
        Thu,  2 Jan 2020 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577962467;
        bh=Fy88OIUGBdZink3Zu23Vq6yGNZlM5ZZ5JWMt1esy4l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnBsvJ05p3Ds7yL0MLHCjR87NT9t5mzkYeGJmJgiMgDmK713FdzWNghkKaALIVWW8
         ny0IgEDcvmNZlpP1KD/cpc1Mfb22aSVqvYBbBCl6JFyO01yO0qH8Db4VwIO8YGlSGX
         A7guAbA1c1PsU6M9qAgFuqHPTe5Z55brL7JTtrX4=
Date:   Thu, 2 Jan 2020 11:54:24 +0100
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
Subject: Re: [PATCH v3 2/9] drm/sun4i: tcon: Add TCON LCD support for R40
Message-ID: <20200102105424.kmte7aooh2gkrcnu@gilmour.lan>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
 <20191231130528.20669-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3yo7gd5amqttw6gt"
Content-Disposition: inline
In-Reply-To: <20191231130528.20669-3-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3yo7gd5amqttw6gt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2019 at 06:35:21PM +0530, Jagan Teki wrote:
> TCON LCD0, LCD1 in allwinner R40, are used for managing
> LCD interfaces like RGB, LVDS and DSI.
>
> Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
> tcon top.
>
> Add support for it, in tcon driver.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - none
>
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index fad72799b8df..69611d38c844 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -1470,6 +1470,13 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
>  	.has_channel_1		= true,
>  };
>
> +static const struct sun4i_tcon_quirks sun8i_r40_lcd_quirks = {
> +	.supports_lvds		= true,
> +	.has_channel_0		= true,
> +	/* TODO Need to support TCON output muxing via GPIO pins */
> +	.set_mux		= sun8i_r40_tcon_tv_set_mux,

What is this muking about? And why is it a TODO?

Maxime

--3yo7gd5amqttw6gt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg3L4AAKCRDj7w1vZxhR
xRZOAPoCD7Z/HWJ+sNCuLAC4kWMalabFj+9JAxw7wHzW3V/8/AD/Rh1zt1mpPjmK
b5SrQ6eKprPdUtwD1w0Aefuflq6U4QM=
=r3km
-----END PGP SIGNATURE-----

--3yo7gd5amqttw6gt--
