Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70077C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 11:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310EF20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577447562;
	bh=fpxAuj56PtPkXj1kH4oxVP3nuSYEPKqNh67BNwrzLbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f7MEylhJd8xC6HhapudoPlqBylecI+3HlHXoAdwUzdJWpib1FKxZ08XLv1JPOcqd/
	 3OwKdMd5dpJf9YRdfzj54fH/If0k5wyc0hlJz6KWp4ANf3UAng5rtvbgEgVJvh9hQa
	 CagaXKU84oyTOT4Y1us+GfarSqKP/Ja0jorVEs1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfL0Lwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 06:52:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfL0Lwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 06:52:41 -0500
Received: from localhost (lfbn-lyo-1-633-204.w90-119.abo.wanadoo.fr [90.119.206.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569B5208C4;
        Fri, 27 Dec 2019 11:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577447560;
        bh=fpxAuj56PtPkXj1kH4oxVP3nuSYEPKqNh67BNwrzLbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6ladlkbq2xNmkwSxOz0zb1jzq/dpn0LveU9V5KElUbc4eaIQUbAq/Llimn2PcVNS
         djnkcmEGFB7TEMa/wCCIG1zFTkK8gAFpZl3eII6Yf1Wgntu359GOA07TwDBfZulqjE
         LxMW1yK+5DLJM/CWGWpogwzCRR19OWLP+0sz/C8o=
Date:   Fri, 27 Dec 2019 12:54:01 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        wens@csie.org, jernej.skrabec@siol.net, thierry.reding@gmail.com,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] drm: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Message-ID: <20191227115401.agumkfuiwexl2wmx@hendrix.home>
References: <20191225132042.5491-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qekez63uoqkeptq7"
Content-Disposition: inline
In-Reply-To: <20191225132042.5491-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qekez63uoqkeptq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 25, 2019 at 09:20:42PM +0800, yu kuai wrote:
> no functional change, just to make the code simpler
>
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c         | 5 +----
>  drivers/gpu/drm/omapdrm/dss/hdmi4_core.c    | 6 ++----
>  drivers/gpu/drm/omapdrm/dss/hdmi5_core.c    | 4 +---
>  drivers/gpu/drm/omapdrm/dss/hdmi_phy.c      | 4 +---
>  drivers/gpu/drm/sun4i/sun4i_dotclock.c      | 4 +---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c      | 4 +---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 4 +---
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c  | 5 +----
>  drivers/gpu/drm/tegra/drm.c                 | 4 +---
>  drivers/gpu/drm/tegra/gem.c                 | 4 +---
>  10 files changed, 11 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> index 0f557fad4513..eb71baedf19e 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> @@ -587,10 +587,7 @@ static int hdmi_audio_register(struct omap_hdmi *hdmi)
>  		&hdmi->pdev->dev, "omap-hdmi-audio", PLATFORM_DEVID_AUTO,
>  		&pdata, sizeof(pdata));
>
> -	if (IS_ERR(hdmi->audio_pdev))
> -		return PTR_ERR(hdmi->audio_pdev);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(hdmi->audio_pdev);
>  }
>
>  /* -----------------------------------------------------------------------------
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
> index ea5d5c228534..fdd73fb73653 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
> @@ -924,8 +924,6 @@ int hdmi4_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
>
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
>  	core->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(core->base))
> -		return PTR_ERR(core->base);
> -
> -	return 0;
> +
> +	return PTR_ERR_OR_ZERO(core->base);
>  }
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
> index ff4d35c8771f..30454bc9de78 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
> @@ -908,8 +908,6 @@ int hdmi5_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
>
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
>  	core->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(core->base))
> -		return PTR_ERR(core->base);
>
> -	return 0;
> +	return PTR_ERR_OR_ZERO(core->base);
>  }
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
> index 00bbf24488c1..bbc02d5aa8fb 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
> @@ -191,8 +191,6 @@ int hdmi_phy_init(struct platform_device *pdev, struct hdmi_phy_data *phy,
>
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
>  	phy->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(phy->base))
> -		return PTR_ERR(phy->base);
>
> -	return 0;
> +	return PTR_ERR_OR_ZERO(phy->base);
>  }
> diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> index 417ade3d2565..84c04d8192b3 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> @@ -191,10 +191,8 @@ int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
>  	dclk->hw.init = &init;
>
>  	tcon->dclk = clk_register(dev, &dclk->hw);
> -	if (IS_ERR(tcon->dclk))
> -		return PTR_ERR(tcon->dclk);
>
> -	return 0;
> +	return PTR_ERR_OR_ZERO(tcon->dclk);

This has been submitted a couple of times already. It's harder to
maintain and not easier to read.

Please remove sun4i from your patch

Maxime

--qekez63uoqkeptq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXgXw2QAKCRDj7w1vZxhR
xcC0AP41YnCplFDuwO92c5iWckNOenpr5t0CgtMx4SUZvRwRfAEAofLF2tx6/nNv
2u5zEYJchT5oj2oyNfSR2wa6CCYaMQM=
=9hHy
-----END PGP SIGNATURE-----

--qekez63uoqkeptq7--
