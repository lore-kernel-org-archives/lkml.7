Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40405C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D62214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfHAIlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:41:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59627 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfHAIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:41:15 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ht6e6-0002Qy-3C; Thu, 01 Aug 2019 10:41:10 +0200
Message-ID: <1564648868.7267.28.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/1] dt-bindings: reset: Fix typo in imx8mq resets
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Thu, 01 Aug 2019 10:41:08 +0200
In-Reply-To: <660b4fb6ab9acec05aa5fde323d878e04e3d1f64.1564647612.git.agx@sigxcpu.org>
References: <cover.1564647612.git.agx@sigxcpu.org>
         <660b4fb6ab9acec05aa5fde323d878e04e3d1f64.1564647612.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 01.08.2019, 10:20 +0200 schrieb Guido Günther:
> Some of the mipi dsi resets were called
> 
>   IMX8MQ_RESET_MIPI_DIS__
> 
> instead of
> 
>   IMX8MQ_RESET_MIPI_DSI__
> 
> Since they're DSI related this looks like a typo. This fixes the
> only in tree user as well to not break bisecting.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/reset/reset-imx7.c               | 12 ++++++------
>  include/dt-bindings/reset/imx8mq-reset.h |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 3ecd770f910b..1443a55a0c29 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -169,9 +169,9 @@ static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
> > >  	[IMX8MQ_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
> > >  	[IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N]	= { SRC_MIPIPHY_RCR, BIT(1) },
> > >  	[IMX8MQ_RESET_MIPI_DSI_RESET_N]		= { SRC_MIPIPHY_RCR, BIT(2) },
> > > -	[IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
> > > -	[IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
> > > -	[IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
> > > +	[IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
> > > +	[IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
> > > +	[IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
> > >  	[IMX8MQ_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR,
> >  						    BIT(2) | BIT(1) },
> > >  	[IMX8MQ_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
> @@ -220,9 +220,9 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
>  
> >  	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
> > >  	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	/* fallthrough */
> > > -	case IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N:	/* fallthrough */
> > > -	case IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N:	/* fallthrough */
> > > -	case IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N:	/* fallthrough */
> > > +	case IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N:	/* fallthrough */
> > > +	case IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N:	/* fallthrough */
> > > +	case IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N:	/* fallthrough */
> > >  	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
> > >  	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
> >  		value = assert ? 0 : bit;
> diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
> index 57c592498aa0..bfa41b0e24f6 100644
> --- a/include/dt-bindings/reset/imx8mq-reset.h
> +++ b/include/dt-bindings/reset/imx8mq-reset.h
> @@ -31,9 +31,9 @@
> >  #define IMX8MQ_RESET_OTG2_PHY_RESET		20
> >  #define IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N	21
> >  #define IMX8MQ_RESET_MIPI_DSI_RESET_N		22
> > -#define IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N	23
> > -#define IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N	24
> > -#define IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N	25
> > +#define IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N	23
> > +#define IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N	24
> > +#define IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N	25
> >  #define IMX8MQ_RESET_PCIEPHY			26
> >  #define IMX8MQ_RESET_PCIEPHY_PERST		27
> >  #define IMX8MQ_RESET_PCIE_CTRL_APPS_EN		28
