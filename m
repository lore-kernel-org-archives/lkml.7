Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C761AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE4B218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfCUN2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:28:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15991 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728238AbfCUN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:28:43 -0400
X-UUID: 466d77577cc1487caf84a0eb7e89a477-20190321
X-UUID: 466d77577cc1487caf84a0eb7e89a477-20190321
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 838600290; Thu, 21 Mar 2019 21:28:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 21:28:39 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 21:28:39 +0800
Message-ID: <1553174919.30977.86.camel@mtkswgap22>
Subject: Re: [PATCH v2] drivers: ufs: Add missing MODULE_* information
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Anders Roxell <anders.roxell@linaro.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Date:   Thu, 21 Mar 2019 21:28:39 +0800
In-Reply-To: <20190321132444.28659-1-anders.roxell@linaro.org>
References: <20190321132444.28659-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On Thu, 2019-03-21 at 14:24 +0100, Anders Roxell wrote:
> When building the ufs-mediatek module the following warning shows up:
> 
> WARNING: modpost: missing MODULE_LICENSE() in
>   drivers/scsi/ufs/ufs-mediatek.o
> 
> Rework to add MODULE_LICENSE,MODULE_AUTHOR and MODULE_DESCRIPTION.
> 
> Fixes: ddd90623ce26 ("scsi: ufs-mediatek: Add UFS support for Mediatek SoC chips")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/scsi/ufs/ufs-mediatek.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
> index c3b78fc83d3f..5e3bda42ac3b 100644
> --- a/drivers/scsi/ufs/ufs-mediatek.c
> +++ b/drivers/scsi/ufs/ufs-mediatek.c
> @@ -364,4 +364,9 @@ static struct platform_driver ufs_mtk_pltform = {
>  	},
>  };
>  
> +MODULE_AUTHOR("Stanley Chu <stanley.chu@mediatek.com>");
> +MODULE_AUTHOR("Peter Wang <peter.wang@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek UFS Host Driver");
> +MODULE_LICENSE("GPL v2");
> +
>  module_platform_driver(ufs_mtk_pltform);


Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>


Thanks,
Stanley


