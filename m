Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4BC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767852053B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfEATej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:34:39 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:43280 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEATej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:34:39 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id F0AB9804A7;
        Wed,  1 May 2019 21:34:30 +0200 (CEST)
Date:   Wed, 1 May 2019 21:34:29 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/panel: simple: Add FriendlyELEC HD702E 800x1280
 LCD panel
Message-ID: <20190501193429.GA9075@ravnborg.org>
References: <20190501121448.3812-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501121448.3812-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dTbK6rJxFaEA:10
        a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8 a=iP-xVBlJAAAA:8
        a=zuLzuavZAAAA:8 a=Ojeavkj-tGznWrRYVDAA:9 a=CjuIK1q_8ugA:10
        a=tCw7dILebdcA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=lHLH-nfn2y1bM_0xSXwp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan

On Wed, May 01, 2019 at 05:44:47PM +0530, Jagan Teki wrote:
> HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
> resolution. It has built in Goodix, GT9271 captive touchscreen
> with backlight adjustable via PWM.
> 
> Add support for it.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Please submit the binding in a separate patch as per
Documentation/devicetree/bindings/submitting-patches.txt

The binding looks like it is compatible with common-panel and
simple-panel - please say so in the bindings.
See for example the last few binding documents added to the kernel tree.

> ---
>  .../display/panel/friendlyarm,hd702e.txt      | 29 +++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c          | 26 +++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt b/Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
> new file mode 100644
> index 000000000000..67349d7f79be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
> @@ -0,0 +1,29 @@
> +FriendlyELEC HD702E 800x1280 LCD panel
> +
> +HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
> +resolution. It has built in Goodix, GT9271 captive touchscreen
> +with backlight adjustable via PWM.
> +
> +Required properties:
> +- compatible: should be "friendlyarm,hd702e"
> +- power-supply: regulator to provide the supply voltage
> +
> +Optional properties:
> +- backlight: phandle of the backlight device attached to the panel
> +
> +Optional nodes:
> +- Video port for LCD panel input.
> +
> +Example:
> +
> +	panel {
> +		compatible ="friendlyarm,hd702e";
> +		backlight = <&backlight>;
> +		power-supply = <&vcc3v3_sys>;
> +
> +		port {
> +			panel_in_edp: endpoint {
> +				remote-endpoint = <&edp_out_panel>;
> +			};
> +		};
> +	};
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9e8218f6a3f2..9db3c0c65ef2 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1184,6 +1184,29 @@ static const struct panel_desc foxlink_fl500wvr00_a0t = {
>  	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
>  };
>  
> +static const struct drm_display_mode friendlyarm_hd702e_mode = {
> +	.clock		= 67185,
> +	.hdisplay	= 800,
> +	.hsync_start	= 800 + 20,
> +	.hsync_end	= 800 + 20 + 24,
> +	.htotal		= 800 + 20 + 24 + 20,
> +	.vdisplay	= 1280,
> +	.vsync_start	= 1280 + 4,
> +	.vsync_end	= 1280 + 4 + 8,
> +	.vtotal		= 1280 + 4 + 8 + 4,
> +	.vrefresh	= 60,
> +	.flags 		= DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +};
> +
> +static const struct panel_desc friendlyarm_hd702e = {
> +	.modes = &friendlyarm_hd702e_mode,
> +	.num_modes = 1,
> +	.size = {
> +		.width	= 94,
> +		.height	= 151,
> +	},
> +};
As I read the datasheet then this panel needs at least a prepare delay
of 10 ms (it says > 10 ms from VGH until Data).
And then we also know that VGH shall be valid at least 10 ms after DVDD
so prepare is likely 20 ms.

Based on datasheet found here:
https://pan.baidu.com/s/1geEfBLh/

Please evaluate all delays.

> +
>  static const struct drm_display_mode giantplus_gpg482739qs5_mode = {
>  	.clock = 9000,
>  	.hdisplay = 480,
> @@ -2634,6 +2657,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "edt,etm0700g0edh6",
>  		.data = &edt_etm0700g0bdh6,
> +	}, {
> +		.compatible = "friendlyarm,hd702e",
> +		.data = &friendlyarm_hd702e,
>  	}, {
>  		.compatible = "foxlink,fl500wvr00-a0t",
>  		.data = &foxlink_fl500wvr00_a0t,

Add these in sorted order.
"fox" is before "fri"

	Sam
