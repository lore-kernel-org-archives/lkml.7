Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E11CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0B42146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UDvJHt8c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RxSXL/qC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfC0MtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:49:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0MtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:49:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 33DB560E3F; Wed, 27 Mar 2019 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690960;
        bh=JaM2QHROcFsO07q/ZN/Cm4gvfw/tYjhzE6fXL5o2A6A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UDvJHt8cBYnv5ONzd4bjEAfoQ+Ad3v8AgeHntiEYLXVrF8cHCV8BClmUC0fRJC8pi
         2tcZ/SPSOnFeE2Lg7Uorh94uBLWNs/koXqt8ai8KPVbuPK/OpgPAvCOKMggo7/TFQ1
         Bagejq0+En3pKcyIRBp9AS5Ls3JofTBh1TNqg4Sk=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2294460736;
        Wed, 27 Mar 2019 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690957;
        bh=JaM2QHROcFsO07q/ZN/Cm4gvfw/tYjhzE6fXL5o2A6A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RxSXL/qCEJQMwQXBMprcX1tT+gX/YhcQHc5NirGNsFhNzLITOLYtI23D1xfR8rbhu
         cV0c+Vh/OkKtLvKtj/I46UIv3xmpRuAED+SdGbrEQy4rnIDP81+zVMNv9vlF6ql/Md
         27fb07/dHtmYTYLS3IZb9X78tNS9ZtmUrPY2UVZo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2294460736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] drm/omap: Add NULL entry to the end of_device_id
 array
To:     YueHaibing <yuehaibing@huawei.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190327031904.63046-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <5acec65f-03c0-d09c-cdd6-acab5da01678@codeaurora.org>
Date:   Wed, 27 Mar 2019 18:19:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190327031904.63046-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the spam whosoever has got the last mail, as the last did not 
get to
the mailing list, and it bounced, so sending it again.

On 3/27/2019 8:49 AM, YueHaibing wrote:
> Make sure of_device_id tables are NULL terminated
> Found by coccinelle spatch "misc/of_table.cocci"
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


> ---
>   drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> index 2b41c75ce988..e02aa8e70968 100644
> --- a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> +++ b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> @@ -198,6 +198,7 @@ static const struct of_device_id omapdss_of_fixups_whitelist[] __initconst = {
>   	{ .compatible = "toppoly,td028ttec1" },
>   	{ .compatible = "tpo,td028ttec1" },
>   	{ .compatible = "tpo,td043mtea1" },
> +	{},
>   };
>   
>   static int __init omapdss_boot_init(void)
>
>
>
