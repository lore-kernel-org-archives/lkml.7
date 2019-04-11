Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E0AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBC52146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDKUm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:42:27 -0400
Received: from muru.com ([72.249.23.125]:45392 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfDKUm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:42:27 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 64270810D;
        Thu, 11 Apr 2019 20:42:42 +0000 (UTC)
Date:   Thu, 11 Apr 2019 13:42:23 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
Message-ID: <20190411204223.GS2839@atomide.com>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch>
 <20190404141730.GE49658@atomide.com>
 <6defcea8-1e94-14ac-f9c5-e14c61ea4d99@linaro.org>
 <20190410200748.GN2839@atomide.com>
 <b8a177ee-0058-2730-4c95-56834f6bafd4@linaro.org>
 <20190411193614.GA8469@archlinux-i9>
 <d6a52524-006c-0a2f-2687-b65095b9c81f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6a52524-006c-0a2f-2687-b65095b9c81f@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Daniel Lezcano <daniel.lezcano@linaro.org> [190411 20:13]:
> I can see those fixes in timers/core:
> 
> Fixes: 592ea6bd1fad ("clocksource: timer-ti-dm: Make unexported
> functions static")

Hmm so this one was over a year ago related to the PWM series :)

> Fixes: 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
> omap_dm_timer_set_load_start() static")

Seems the warnings started with this one.

Regards,

Tony
