Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D04C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2981F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfCYKr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:47:58 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:32831 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYKr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:47:57 -0400
X-Originating-IP: 109.213.38.144
Received: from localhost (alyon-652-1-47-144.w109-213.abo.wanadoo.fr [109.213.38.144])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 12A53C000D;
        Mon, 25 Mar 2019 10:47:54 +0000 (UTC)
Date:   Mon, 25 Mar 2019 11:47:54 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sh: fix unused variable warning
Message-ID: <20190325104754.GJ30105@piout.net>
References: <20190325102453.8349-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325102453.8349-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 11:24:53+0100, Anders Roxell wrote:
> When building the driver rtc/rtc-sh a warning about unused variable
> shows up:
> 
> ../drivers/rtc/rtc-sh.c: In function ‘sh_rtc_probe’:
> ../drivers/rtc/rtc-sh.c:472:18: warning: unused variable ‘r’ [-Wunused-variable]
>   struct rtc_time r;
>                   ^
> 
> Remove the declaration of the unused varable 'r'.
> 
> Fixes: 373f7f4bf4a5 ("rtc: sh: stop resetting time to epoch")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/rtc/rtc-sh.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Thanks, I've squashed it in the original commit as it is not yet in any
release and its hash may still change.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
