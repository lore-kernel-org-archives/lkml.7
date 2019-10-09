Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E87C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267F721848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfJIJSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:18:06 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:29791 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726068AbfJIJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:18:04 -0400
X-UUID: 61f34e2b5982457c8d41060679298e92-20191009
X-UUID: 61f34e2b5982457c8d41060679298e92-20191009
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 546005503; Wed, 09 Oct 2019 17:17:51 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 17:17:48 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 17:17:48 +0800
Message-ID: <1570612671.7713.1.camel@mtksdaap41>
Subject: Re: [PATCH v5, 15/32] drm/mediatek: add commponent OVL_2L0
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
Date:   Wed, 9 Oct 2019 17:17:51 +0800
In-Reply-To: <1567090254-15566-16-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-16-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 681A688D04C331099D6C08507BCFD8CF80C3801578307909A3D5D16ED81D58D62000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add commponent OVL_2L0
> 

Applied to mediatek-drm-next-5.5 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.5

Regards,
CK

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index b18bd66..4200f89 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -219,6 +219,7 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
>  
>  static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
>  	[MTK_DISP_OVL] = "ovl",
> +	[MTK_DISP_OVL_2L] = "ovl_2l",
>  	[MTK_DISP_RDMA] = "rdma",
>  	[MTK_DISP_WDMA] = "wdma",
>  	[MTK_DISP_COLOR] = "color",
> @@ -258,6 +259,7 @@ struct mtk_ddp_comp_match {
>  	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
>  	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, NULL },
>  	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
> +	[DDP_COMPONENT_OVL_2L0]	= { MTK_DISP_OVL_2L,	0, NULL },
>  	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
>  	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
>  	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 8d220224..9caec2d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -17,6 +17,7 @@
>  
>  enum mtk_ddp_comp_type {
>  	MTK_DISP_OVL,
> +	MTK_DISP_OVL_2L,
>  	MTK_DISP_RDMA,
>  	MTK_DISP_WDMA,
>  	MTK_DISP_COLOR,
> @@ -50,6 +51,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_OD0,
>  	DDP_COMPONENT_OD1,
>  	DDP_COMPONENT_OVL0,
> +	DDP_COMPONENT_OVL_2L0,
>  	DDP_COMPONENT_OVL1,
>  	DDP_COMPONENT_PWM0,
>  	DDP_COMPONENT_PWM1,


