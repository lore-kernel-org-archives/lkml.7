Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58C0C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B8E20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfDKVF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:05:28 -0400
Received: from muru.com ([72.249.23.125]:45426 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfDKVF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:05:28 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 59990810D;
        Thu, 11 Apr 2019 20:57:16 +0000 (UTC)
Date:   Thu, 11 Apr 2019 13:56:57 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ladislav Michl <ladis@linux-mips.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
Message-ID: <20190411205657.GT2839@atomide.com>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch>
 <20190404141730.GE49658@atomide.com>
 <6defcea8-1e94-14ac-f9c5-e14c61ea4d99@linaro.org>
 <20190410200748.GN2839@atomide.com>
 <b8a177ee-0058-2730-4c95-56834f6bafd4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a177ee-0058-2730-4c95-56834f6bafd4@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Daniel Lezcano <daniel.lezcano@linaro.org> [190411 19:21]:
> On 10/04/2019 22:07, Tony Lindgren wrote:
> > Hi,
> > 
> > * Daniel Lezcano <daniel.lezcano@linaro.org> [190410 17:02]:
> >> can you ask for an acked-by before pulling a patch in your tree?
> > 
> > I certainly do ask and wait for acks where possible :)
> 
> Ok, I may have missed them.
> 
> > Note that I have not applied this patch. I just added
> > Keerthy to Cc on this thread so maybe you misread the
> > message earlier. My comment "seems like no other
> > takers" was for Ladislav regarding somebody picking up
> > his earlier work, not for picking up this patch :)
> 
> Actually I was referring to the commit 592ea6bd1fad. Anyway as stated
> above I could have miss your call.

Hmm so commit 592ea6bd1fad was part of the PWM timer series
that was posted several times from late 2017 to end of
February 2018. I did not get any timer related acks or
comments so I applied it together with the PWM timer
changes.

I'm guessing you may have accidentally checked out some
older deja-vu branch from about a year ago? Commit
592ea6bd1fad is not related to this fix.. :)

Regards,

Tony



