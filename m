Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244D4C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED92C2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFNJ3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:29:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37878 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfFNJ3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:29:49 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbiWc-00044s-Js; Fri, 14 Jun 2019 11:29:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
Date:   Fri, 14 Jun 2019 11:29:33 +0200
Message-ID: <4131981.039HHiXCja@phil>
In-Reply-To: <VI1PR03MB42062F51FD88AEB6DADD8734AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com> <VI1PR03MB42062F51FD88AEB6DADD8734AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 26. Mai 2019, 23:20:05 CEST schrieb Jonas Karlman:
> This patch enables Dynamic Range and Mastering InfoFrame on RK3328 and RK3399.
> 
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 4cdc9f86c2e5..1f31f3726f04 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -405,6 +405,7 @@ static const struct dw_hdmi_plat_data rk3328_hdmi_drv_data = {
>  	.phy_ops = &rk3328_hdmi_phy_ops,
>  	.phy_name = "inno_dw_hdmi_phy2",
>  	.phy_force_vendor = true,
> +	.drm_infoframe = true,
>  };
>  
>  static struct rockchip_hdmi_chip_data rk3399_chip_data = {
> @@ -419,6 +420,7 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
>  	.cur_ctr    = rockchip_cur_ctr,
>  	.phy_config = rockchip_phy_config,
>  	.phy_data = &rk3399_chip_data,
> +	.drm_infoframe = true,
>  };
>  
>  static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
> -- 
> 2.17.1
> 
> 




