Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB3FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF832173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395228AbfHWOZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:25:41 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:48067 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbfHWOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:25:41 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4051E10000B;
        Fri, 23 Aug 2019 14:25:39 +0000 (UTC)
Date:   Fri, 23 Aug 2019 16:25:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Biwen Li <biwen.li@nxp.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][rtc-next] rtc: fsl: fix spelling mistake: "memery" ->
 "memory"
Message-ID: <20190823142538.GB30479@piout.net>
References: <20190823101823.18402-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823101823.18402-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2019 11:18:23+0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/rtc-fsl-ftm-alarm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

I squashed that in the original patch, thanks!

> diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
> index 4f7259c2d6a3..4bb98310cc3f 100644
> --- a/drivers/rtc/rtc-fsl-ftm-alarm.c
> +++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
> @@ -255,7 +255,7 @@ static int ftm_rtc_probe(struct platform_device *pdev)
>  
>  	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
>  	if (unlikely(!rtc)) {
> -		dev_err(&pdev->dev, "cannot alloc memery for rtc\n");
> +		dev_err(&pdev->dev, "cannot alloc memory for rtc\n");
>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
