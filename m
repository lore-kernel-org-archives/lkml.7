Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886E3C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6081A2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDIGMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:12:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18018 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbfDIGMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:12:51 -0400
X-UUID: 708af587616e4ecbb67f047c76954581-20190409
X-UUID: 708af587616e4ecbb67f047c76954581-20190409
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1412010561; Tue, 09 Apr 2019 14:12:45 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Apr 2019 14:12:43 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Apr 2019 14:12:43 +0800
Message-ID: <1554790363.10331.1.camel@mtksdaap41>
Subject: Re: [PATCH 01/14] [media] mtk-mipicsi: add mediatek mipicsi driver
 for mt2712
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
Date:   Tue, 9 Apr 2019 14:12:43 +0800
In-Reply-To: <1554724505-19882-2-git-send-email-stu.hsieh@mediatek.com>
References: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
         <1554724505-19882-2-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: CF19FFDC3CE20E6C10B2D4979EFABE8034C444B504E33512BB9CFFC39EED8FBD2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Mon, 2019-04-08 at 19:54 +0800, Stu Hsieh wrote:
> This patch add mediatek mipicsi driver for mt2712,
> including probe function to get the value from device tree,
> and register to v4l2 the host device.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/media/platform/mtk-mipicsi/Makefile   |   4 +
>  .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 768 ++++++++++++++++++
>  2 files changed, 772 insertions(+)
>  create mode 100644 drivers/media/platform/mtk-mipicsi/Makefile
>  create mode 100644 drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
> 

[snip]

> +
> +static const struct of_device_id mtk_mipicsi_of_match[] = {
> +	{ .compatible = "mediatek,mt2712-mipicsi", },

Where is the binding document of "mediatek,mt2712-mipicsi"?

Regards,
CK

> +	{},
> +};
> +
> +static struct platform_driver mtk_mipicsi_driver = {
> +	.driver		= {
> +		.name	= MTK_MIPICSI_DRV_NAME,
> +		.of_match_table = of_match_ptr(mtk_mipicsi_of_match),
> +	},
> +	.probe		= mtk_mipicsi_probe,
> +	.remove		= mtk_mipicsi_remove,
> +};
> +
> +module_platform_driver(mtk_mipicsi_driver);
> +MODULE_DESCRIPTION("MediaTek SoC Camera Host driver");
> +MODULE_LICENSE("GPL v2");


