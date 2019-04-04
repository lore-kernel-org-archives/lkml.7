Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCC0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15420206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfDDPs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:48:56 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:57598 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDDPsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:48:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E0028FB03;
        Thu,  4 Apr 2019 17:48:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fNdyGWJaw293; Thu,  4 Apr 2019 17:48:50 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4ACD942BBE; Thu,  4 Apr 2019 17:48:50 +0200 (CEST)
Date:   Thu, 4 Apr 2019 17:48:50 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Joe Perches <joe@perches.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm/panel: Rocktech jh057n00900: Add terminating
 newlines to logging
Message-ID: <20190404154850.GA19334@bogon.m.sigxcpu.org>
References: <cover.1554114302.git.agx@sigxcpu.org>
 <20190403161735.GN5238@ulmo>
 <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
 <20190404105359.GA8255@bogon.m.sigxcpu.org>
 <da6f2344396555034cf2476c8338b0ce1c56e0a7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da6f2344396555034cf2476c8338b0ce1c56e0a7.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,
On Thu, Apr 04, 2019 at 08:06:09AM -0700, Joe Perches wrote:
> These were missing '\n' terminations, add them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> index 158a6d548068..d88ea8da2ec2 100644
> --- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> +++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> @@ -123,7 +123,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
>  
>  	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(dev, "Failed to exit sleep mode");
> +		DRM_DEV_ERROR(dev, "Failed to exit sleep mode\n");
>  		return ret;
>  	}
>  	/* Panel is operational 120 msec after reset */
> @@ -132,7 +132,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
>  	if (ret)
>  		return ret;
>  
> -	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done");
> +	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done\n");
>  	return 0;
>  }
>  
> @@ -172,7 +172,7 @@ static int jh057n_prepare(struct drm_panel *panel)
>  	if (ctx->prepared)
>  		return 0;
>  
> -	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel.");
> +	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel\n");
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>  	usleep_range(20, 40);
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> @@ -180,7 +180,8 @@ static int jh057n_prepare(struct drm_panel *panel)
>  
>  	ret = jh057n_init_sequence(ctx);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d", ret);
> +		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d\n",
> +			      ret);
>  		return ret;
>  	}
>  
> @@ -212,7 +213,7 @@ static int jh057n_get_modes(struct drm_panel *panel)
>  
>  	mode = drm_mode_duplicate(panel->drm, &default_mode);
>  	if (!mode) {
> -		DRM_DEV_ERROR(ctx->dev, "Failed to add mode %ux%u@%u",
> +		DRM_DEV_ERROR(ctx->dev, "Failed to add mode %ux%u@%u\n",
>  			      default_mode.hdisplay, default_mode.vdisplay,
>  			      default_mode.vrefresh);
>  		return -ENOMEM;
> @@ -241,7 +242,7 @@ static int allpixelson_set(void *data, u64 val)
>  	struct jh057n *ctx = data;
>  	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>  
> -	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on");
> +	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on\n");
>  	dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
>  	msleep(val * 1000);
>  	/* Reset the panel to get video back */
> @@ -290,7 +291,7 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
>  
>  	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(ctx->reset_gpio)) {
> -		DRM_DEV_ERROR(dev, "cannot get reset gpio");
> +		DRM_DEV_ERROR(dev, "cannot get reset gpio\n");
>  		return PTR_ERR(ctx->reset_gpio);
>  	}
>  
> @@ -315,12 +316,12 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
>  
>  	ret = mipi_dsi_attach(dsi);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?");
> +		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?\n");
>  		drm_panel_remove(&ctx->panel);
>  		return ret;
>  	}
>  
> -	DRM_DEV_INFO(dev, "%ux%u@%u %ubpp dsi %udl - ready",
> +	DRM_DEV_INFO(dev, "%ux%u@%u %ubpp dsi %udl - ready\n",
>  		     default_mode.hdisplay, default_mode.vdisplay,
>  		     default_mode.vrefresh,
>  		     mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
> 

Reviewed-By: Guido Günther <agx@sigxcpu.org>

Thanks,
 -- Guido

P.S.: The cc: list is huge, is there a reason for going way past what
get_maintainers puts out for this patch?



