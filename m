Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020E2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 20:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AC920644
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 20:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391211AbfIVU3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 16:29:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60289 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbfIVU3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 16:29:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A5ED3808F6; Sun, 22 Sep 2019 22:29:35 +0200 (CEST)
Date:   Sun, 22 Sep 2019 22:29:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Crews <ncrews@chromium.org>
Cc:     bleung@chromium.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org
Subject: Re: [PATCH v2 2/2] rtc: wilco-ec: Fix license to GPL from GPLv2
Message-ID: <20190922202947.GA4421@bug>
References: <20190916181215.501-1-ncrews@chromium.org>
 <20190916181215.501-2-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916181215.501-2-ncrews@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-09-16 12:12:17, Nick Crews wrote:
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  drivers/rtc/rtc-wilco-ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> index e84faa268caf..951268f5e690 100644
> --- a/drivers/rtc/rtc-wilco-ec.c
> +++ b/drivers/rtc/rtc-wilco-ec.c
> @@ -184,5 +184,5 @@ module_platform_driver(wilco_ec_rtc_driver);
>  
>  MODULE_ALIAS("platform:rtc-wilco-ec");
>  MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Wilco EC RTC driver");

File spdx header says GPL-2.0, this change would make it inconsistent with that...

Best regards,
											Pavel
