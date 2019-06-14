Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1042C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE7621537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfFNDmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:42:51 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:23152 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725616AbfFNDmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:42:51 -0400
X-UUID: df532dbf28cb4d60bd19eaf78937139c-20190614
X-UUID: df532dbf28cb4d60bd19eaf78937139c-20190614
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2143418753; Fri, 14 Jun 2019 11:42:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Jun 2019 11:42:40 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Jun 2019 11:42:39 +0800
Message-ID: <1560483759.16718.12.camel@mtksdaap41>
Subject: Re: [PATCH v3, 13/27] drm/mediatek: add ddp component CCORR
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 14 Jun 2019 11:42:39 +0800
In-Reply-To: <1559734986-7379-14-git-send-email-yongqiang.niu@mediatek.com>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
         <1559734986-7379-14-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-06-05 at 19:42 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add ddp component CCORR

This patch is identical to v2, and I've give a 'Reviewed-by' for v2 [1],
so you should keep this 'Reviewed-by' tag in this patch, so I still give
you a

Reviewed-by: CK Hu <ck.hu@mediatek.com>

[1] https://patchwork.kernel.org/patch/10872697/

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 32 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 54ca794..310c0b9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -41,6 +41,12 @@
>  #define DISP_AAL_EN				0x0000
>  #define DISP_AAL_SIZE				0x0030
>  
> +#define DISP_CCORR_EN				0x0000
> +#define CCORR_EN				BIT(0)
> +#define DISP_CCORR_CFG				0x0020
> +#define CCORR_RELAY_MODE			BIT(0)
> +#define DISP_CCORR_SIZE				0x0030
> +
>  #define DISP_GAMMA_EN				0x0000
>  #define DISP_GAMMA_CFG				0x0020
>  #define DISP_GAMMA_SIZE				0x0030
> @@ -131,6 +137,24 @@ static void mtk_aal_stop(struct mtk_ddp_comp *comp)
>  	writel_relaxed(0x0, comp->regs + DISP_AAL_EN);
>  }
>  
> +static void mtk_ccorr_config(struct mtk_ddp_comp *comp, unsigned int w,
> +			     unsigned int h, unsigned int vrefresh,
> +			     unsigned int bpc)
> +{
> +	writel(h << 16 | w, comp->regs + DISP_CCORR_SIZE);
> +	writel(CCORR_RELAY_MODE, comp->regs + DISP_CCORR_CFG);
> +}
> +
> +static void mtk_ccorr_start(struct mtk_ddp_comp *comp)
> +{
> +	writel(CCORR_EN, comp->regs + DISP_CCORR_EN);
> +}
> +
> +static void mtk_ccorr_stop(struct mtk_ddp_comp *comp)
> +{
> +	writel_relaxed(0x0, comp->regs + DISP_CCORR_EN);
> +}
> +
>  static void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
>  			     unsigned int h, unsigned int vrefresh,
>  			     unsigned int bpc)
> @@ -179,6 +203,12 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
>  	.stop = mtk_aal_stop,
>  };
>  
> +static const struct mtk_ddp_comp_funcs ddp_ccorr = {
> +	.config = mtk_ccorr_config,
> +	.start = mtk_ccorr_start,
> +	.stop = mtk_ccorr_stop,
> +};
> +
>  static const struct mtk_ddp_comp_funcs ddp_gamma = {
>  	.gamma_set = mtk_gamma_set,
>  	.config = mtk_gamma_config,
> @@ -200,6 +230,7 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
>  	[MTK_DISP_RDMA] = "rdma",
>  	[MTK_DISP_WDMA] = "wdma",
>  	[MTK_DISP_COLOR] = "color",
> +	[MTK_DISP_CCORR] = "ccorr",
>  	[MTK_DISP_AAL] = "aal",
>  	[MTK_DISP_GAMMA] = "gamma",
>  	[MTK_DISP_UFOE] = "ufoe",
> @@ -221,6 +252,7 @@ struct mtk_ddp_comp_match {
>  	[DDP_COMPONENT_AAL0]	= { MTK_DISP_AAL,	0, &ddp_aal },
>  	[DDP_COMPONENT_AAL1]	= { MTK_DISP_AAL,	1, &ddp_aal },
>  	[DDP_COMPONENT_BLS]	= { MTK_DISP_BLS,	0, NULL },
> +	[DDP_COMPONENT_CCORR]	= { MTK_DISP_CCORR,	0, &ddp_ccorr },
>  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, NULL },
>  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, NULL },
>  	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 8399229..87ef290 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -28,6 +28,7 @@ enum mtk_ddp_comp_type {
>  	MTK_DISP_RDMA,
>  	MTK_DISP_WDMA,
>  	MTK_DISP_COLOR,
> +	MTK_DISP_CCORR,
>  	MTK_DISP_AAL,
>  	MTK_DISP_GAMMA,
>  	MTK_DISP_UFOE,
> @@ -44,6 +45,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_AAL0,
>  	DDP_COMPONENT_AAL1,
>  	DDP_COMPONENT_BLS,
> +	DDP_COMPONENT_CCORR,
>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_COLOR1,
>  	DDP_COMPONENT_DPI0,


