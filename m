Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5B1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6EF2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfKGRjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:39:03 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33369 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfKGRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:39:02 -0500
X-Originating-IP: 92.137.17.54
Received: from localhost (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7FC2B1BF20A;
        Thu,  7 Nov 2019 17:39:00 +0000 (UTC)
Date:   Thu, 7 Nov 2019 18:38:59 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: bd70528: Fix hour register mask
Message-ID: <20191107173859.GR8309@piout.net>
References: <20191023114751.GA14100@localhost.localdomain>
 <20191105165317.GC8309@piout.net>
 <20191107105949.GA19195@dell>
 <20191107112850.GP8309@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107112850.GP8309@piout.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2019 12:33:53+0100, Alexandre Belloni wrote:
> On 07/11/2019 10:59:49+0000, Lee Jones wrote:
> > On Tue, 05 Nov 2019, Alexandre Belloni wrote:
> > 
> > > On 23/10/2019 14:47:51+0300, Matti Vaittinen wrote:
> > > > When RTC is used in 24H mode (and it is by this driver) the maximum
> > > > hour value is 24 in BCD. This occupies bits [5:0] - which means
> > > > correct mask for HOUR register is 0x3f not 0x1f. Fix the mask
> > > > 
> > > > Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528 RTC")
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > ---
> > > >  include/linux/mfd/rohm-bd70528.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > Applied, thanks.
> > 
> > You have been duped. This is clearly not an RTC patch.
> > 
> 
> Well, it only affects the RTC driver. Do you want to take it?
> 

I've removed it from rtc-next, up to you to take it.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
