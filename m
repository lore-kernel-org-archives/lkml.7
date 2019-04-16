Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60209C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8FE20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfDPTuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:50:32 -0400
Received: from fudo.makrotopia.org ([185.142.180.71]:46488 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:50:32 -0400
X-Greylist: delayed 1442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 15:50:31 EDT
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.91)
        (envelope-from <daniel@makrotopia.org>)
        id 1hGTiq-0004tT-Sj; Tue, 16 Apr 2019 21:26:25 +0200
Date:   Tue, 16 Apr 2019 21:26:22 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        "moderated list:ARM/OXNAS platform support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/OXNAS platform support" <linux-oxnas@groups.io>
Subject: Re: [PATCH 3/4] clocksource/drivers/oxnas: Fix OX820 compatible
Message-ID: <20190416192621.GE1409@makrotopia.org>
References: <92427592-507b-e280-01bf-763d795c8a2f@linaro.org>
 <20190416124640.20058-1-daniel.lezcano@linaro.org>
 <20190416124640.20058-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416124640.20058-3-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Works great here

On Tue, Apr 16, 2019 at 02:46:39PM +0200, Daniel Lezcano wrote:
> From: Neil Armstrong <narmstrong@baylibre.com>
> 
> The OX820 compatible is wrong is the driver, fix it.
> 
> Fixes: 2ea3401e2a84 ("clocksource/drivers/oxnas: Add OX820 compatible")
> Reported-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/clocksource/timer-oxnas-rps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
> index eed6feff8b5f..30c6f4ce672b 100644
> --- a/drivers/clocksource/timer-oxnas-rps.c
> +++ b/drivers/clocksource/timer-oxnas-rps.c
> @@ -296,4 +296,4 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
>  TIMER_OF_DECLARE(ox810se_rps,
>  		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
>  TIMER_OF_DECLARE(ox820_rps,
> -		       "oxsemi,ox820se-rps-timer", oxnas_rps_timer_init);
> +		       "oxsemi,ox820-rps-timer", oxnas_rps_timer_init);
> -- 
> 2.17.1
> 
