Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E54C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACE020873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDKGOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:14:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59735 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726121AbfDKGOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:14:30 -0400
X-UUID: 46a0ab1f03f0401089e178a492f70ced-20190411
X-UUID: 46a0ab1f03f0401089e178a492f70ced-20190411
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1609266676; Thu, 11 Apr 2019 14:14:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Apr 2019 14:14:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 14:14:24 +0800
Message-ID: <1554963264.4768.7.camel@mtksdaap41>
Subject: Re: [PATCH v2 10/25] drm/mediatek: add commponent OVL0_2L
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Thu, 11 Apr 2019 14:14:24 +0800
In-Reply-To: <1553667561-25447-11-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-11-git-send-email-yongqiang.niu@mediatek.com>
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

On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add commponent OVL0_2L
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 310c0b9..19a8b06 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -227,6 +227,7 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
>  
>  static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
>  	[MTK_DISP_OVL] = "ovl",
> +	[MTK_DISP_OVL_2L] = "ovl_2l",
>  	[MTK_DISP_RDMA] = "rdma",
>  	[MTK_DISP_WDMA] = "wdma",
>  	[MTK_DISP_COLOR] = "color",
> @@ -266,6 +267,7 @@ struct mtk_ddp_comp_match {
>  	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
>  	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, NULL },
>  	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
> +	[DDP_COMPONENT_OVL0_2L]	= { MTK_DISP_OVL_2L,	0, NULL },
>  	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
>  	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
>  	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 87ef290..c061784 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -25,6 +25,7 @@
>  
>  enum mtk_ddp_comp_type {
>  	MTK_DISP_OVL,
> +	MTK_DISP_OVL_2L,
>  	MTK_DISP_RDMA,
>  	MTK_DISP_WDMA,
>  	MTK_DISP_COLOR,
> @@ -58,6 +59,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_OD0,
>  	DDP_COMPONENT_OD1,
>  	DDP_COMPONENT_OVL0,
> +	DDP_COMPONENT_OVL0_2L,

I think this component is the OVL_2L with index 0, I would like the
naming to be DDP_COMPONENT_OVL_2L0.

Regards,
CK

>  	DDP_COMPONENT_OVL1,
>  	DDP_COMPONENT_PWM0,
>  	DDP_COMPONENT_PWM1,


