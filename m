Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281ADC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D650206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfJIJUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:20:42 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47990 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725935AbfJIJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:20:42 -0400
X-UUID: 6b5adf56ec59466eb2a069f0e00b456d-20191009
X-UUID: 6b5adf56ec59466eb2a069f0e00b456d-20191009
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1432871242; Wed, 09 Oct 2019 17:20:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 17:20:29 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 17:20:29 +0800
Message-ID: <1570612831.7713.4.camel@mtksdaap41>
Subject: Re: [PATCH v5, 19/32] drm/medaitek: add layer_nr for ovl private
 data
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
Date:   Wed, 9 Oct 2019 17:20:31 +0800
In-Reply-To: <1567090254-15566-20-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-20-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: A5B33E426A6A22AF7CE56AB684BF57B97D9F0F8D5DE9B544F6874FCD68A276BC2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add layer_nr for ovl private data
> ovl_2l almost same with with ovl hardware, except the
> layer number for ovl_2l is 2 and ovl is 4.
> this patch is a preparation for ovl-2l and
> ovl share the same driver.
> 

Applied to mediatek-drm-next-5.5 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.5

Regards,
CK

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 82eaefd..baef066 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -52,6 +52,7 @@
>  struct mtk_disp_ovl_data {
>  	unsigned int addr;
>  	unsigned int gmc_bits;
> +	unsigned int layer_nr;
>  	bool fmt_rgb565_is_0;
>  };
>  
> @@ -129,7 +130,9 @@ static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
>  
>  static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
>  {
> -	return 4;
> +	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
> +
> +	return ovl->data->layer_nr;
>  }
>  
>  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
> @@ -334,12 +337,14 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
>  static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT2701,
>  	.gmc_bits = 8,
> +	.layer_nr = 4,
>  	.fmt_rgb565_is_0 = false,
>  };
>  
>  static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT8173,
>  	.gmc_bits = 8,
> +	.layer_nr = 4,
>  	.fmt_rgb565_is_0 = true,
>  };
>  


