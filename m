Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B51C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7FA21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="faPLG+3a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cjJWEJBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfCTTb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:31:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfCTTb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:31:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C564F615BF; Wed, 20 Mar 2019 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553110285;
        bh=Xdf1c234HLx/K6hMHcrsZ2lUuUnCMbdLJxKFG7uB4nw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=faPLG+3aknBfM94ks8ELRaoc0gUdbCOVlVU+4ZEo7FvI8SLyPzjp/wJDsZNp18wuX
         76SVSIpRsO4C6mhCWaPyE+zq2rzyz8MWCf00jw+2/HxZYt35KU4wbBCbEj6FT1eYqe
         qUdobV1GaCDH6UNWLkJryOJ1ag6cTJ9cWQ6LKydo=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51118609F3;
        Wed, 20 Mar 2019 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553110266;
        bh=Xdf1c234HLx/K6hMHcrsZ2lUuUnCMbdLJxKFG7uB4nw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cjJWEJBO8zgqDBqt+1cjSf0gagz+iuHQQa4n+ivkt3AJf1+ccrOPh8Z143dvEfWi8
         dY2vaJnBId4xJCFsecBSBiwJ33LV1OiVgQ9WuiGcbvsRYwE0SEhmf7NScItn1ofW3S
         2xXg/v9iobHhS/af9NfZYUICZlgRIMWGkOEH2srE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51118609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] scsi: ufs-mediatek: Make some symbols static
To:     Yue Haibing <yuehaibing@huawei.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, matthias.bgg@gmail.com,
        stanley.chu@mediatek.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20190320142458.20052-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <d0536ff3-c6aa-ae3d-49cd-1a54a8dce5b5@codeaurora.org>
Date:   Thu, 21 Mar 2019 01:00:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320142458.20052-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 7:54 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warnings:
>
> drivers/scsi/ufs/ufs-mediatek.c:19:6: warning: symbol 'ufs_mtk_cfg_unipro_cg' was not declared. Should it be static?
> drivers/scsi/ufs/ufs-mediatek.c:55:5: warning: symbol 'ufs_mtk_bind_mphy' was not declared. Should it be static?
> drivers/scsi/ufs/ufs-mediatek.c:342:27: warning: symbol 'ufs_mtk_of_match' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/scsi/ufs/ufs-mediatek.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
> index c3b78fc..2fbb450 100644
> --- a/drivers/scsi/ufs/ufs-mediatek.c
> +++ b/drivers/scsi/ufs/ufs-mediatek.c
> @@ -16,7 +16,7 @@
>   #include "unipro.h"
>   #include "ufs-mediatek.h"
>   
> -void ufs_mtk_cfg_unipro_cg(struct ufs_hba *hba, bool enable)
> +static void ufs_mtk_cfg_unipro_cg(struct ufs_hba *hba, bool enable)
>   {
>   	u32 tmp;
>   
> @@ -52,7 +52,7 @@ void ufs_mtk_cfg_unipro_cg(struct ufs_hba *hba, bool enable)
>   	}
>   }
>   
> -int ufs_mtk_bind_mphy(struct ufs_hba *hba)
> +static int ufs_mtk_bind_mphy(struct ufs_hba *hba)
>   {
>   	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
>   	struct device *dev = hba->dev;
> @@ -339,7 +339,7 @@ static int ufs_mtk_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -const struct of_device_id ufs_mtk_of_match[] = {
> +static const struct of_device_id ufs_mtk_of_match[] = {
>   	{ .compatible = "mediatek,mt8183-ufshci"},
>   	{},
>   };


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


Cheers,
Mukesh

