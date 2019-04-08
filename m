Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC16C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98135214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDHOBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:01:21 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:40985 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfDHOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:01:21 -0400
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 230ED100006;
        Mon,  8 Apr 2019 14:01:16 +0000 (UTC)
Date:   Mon, 8 Apr 2019 16:01:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Claudiu.Beznea@microchip.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
Message-ID: <20190408140116.GM7480@piout.net>
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-3-git-send-email-claudiu.beznea@microchip.com>
 <a738fce5-1108-34d7-d255-dfcb86f51c56@linaro.org>
 <20190408121141.GK7480@piout.net>
 <ce42bb5f-c77e-e882-0579-2bbf95d7b1a5@linaro.org>
 <20190408124213.GL7480@piout.net>
 <e9e10fa5-dba6-e9ca-f319-036a71105b6a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e10fa5-dba6-e9ca-f319-036a71105b6a@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 15:22:50+0200, Daniel Lezcano wrote:
> On 08/04/2019 14:42, Alexandre Belloni wrote:
> > On 08/04/2019 14:35:05+0200, Daniel Lezcano wrote:
> >>
> >> What about commit 51f0aeb2d21f1 ?
> >>
> > 
> > Well, do you see anything parsing that in drivers/clocksource ?
> 
> So to make it clear:
> 
> 1. You say I said anything, emphasis this word in the previous answer.
> But you are the one who should have argue and give the reasons of the
> changes (and I'm sure they are valid). At the moment of the discussion
> in the thread you mentioned, the DT change was already present.
>  - Why did you not clarified this point in the thread discussion?
>  - Why there is no Rob's acked-by in this commit?
> 

This was a left over that had absolutely no influence on anything. I'll
remove it. There was no ack because nobody expects Rob to review all the
DT changes.

> 
> 2. You keep sending the atmel rework series again and again. And I'm
> reviewing it again and again. And you object every single comment I do
> on your code. I've already told you that.
> 

Have a look, I stopped trying to send it as a new driver and now the
changes are minimal, to solve the specific issues we have.

> 
> 3. I'm putting on the table again this clockevent/clocksource selection
> from the DT hoping we can finally find a solution for *everyone* and
> instead of jumping on the opportunity to discuss it, you blame me to not
> have done this for you before.
> 

I've been jumping on the opportunity since 2016 and like I pointed, last
time, you didn't even discuss it.

> 
> 4. Bonus, you resend your series again for the nth times two years after
> the last discussion.
> 

This is not the same series. And it has not been two year, the last one
was sent in September 2018.

> 
> Do you want to see some progress?
> 
> Propose something generic telling if the node pointer is for a
> clocksource or a clockevent. Get agreement from everyone and then resend
> your atmel rework based on this.
> 

This will never work. We have been doing plenty of work and participated
to plenty of discussions since 2016. Every time, you asked us to have a
look at the other drivers. We did. We tried to get something generic
enough and you never backed us. It is the maintainer job to ensure a
proposed solution is generic enough as he is the one that has a global
view of the different drivers and HW platforms. You should not ask that
from platform maintainers. If you want to have a generic binding, you
have to be active and discuss it with Rob.

Anyway, this is now out of the way for the TCB rework because I'm not
touching that part anymore. But I want to ensures this does not impede
the PIT64 driver.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
