Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED048C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77BD2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfEEHxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 03:53:12 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8637 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726846AbfEEHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 03:53:12 -0400
X-UUID: 0af89c9b9aeb404db02a4d2e33aae6f3-20190505
X-UUID: 0af89c9b9aeb404db02a4d2e33aae6f3-20190505
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1451780205; Sun, 05 May 2019 15:52:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 5 May
 2019 15:52:52 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 May 2019 15:52:52 +0800
Message-ID: <1557042772.18628.36.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] mmc: mtk-sd: select REGULATOR
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     NeilBrown <neil@brown.name>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <thirtythreeforty@gmail.com>
Date:   Sun, 5 May 2019 15:52:52 +0800
In-Reply-To: <155696549700.8632.10790498625986428152.stgit@noble.brown>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
         <155696549700.8632.10790498625986428152.stgit@noble.brown>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-04 at 20:24 +1000, NeilBrown wrote:
> The mtk-sd driver requires a regulator to be present, even if it is
> the "fixed" regulator.  So select REGULATOR to make it hard to build
> unusable configurations.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
 Reviewed-by:Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9c01310a0d2e..1249cde7004d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -941,6 +941,7 @@ config MMC_BCM2835
>  config MMC_MTK
>  	tristate "MediaTek SD/MMC Card Interface support"
>  	depends on HAS_DMA
> +	select REGULATOR
>  	help
>  	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
>  	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
> 
> 


