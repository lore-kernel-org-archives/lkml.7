Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2706720674
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDIO4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:56:53 -0400
Received: from muru.com ([72.249.23.125]:45062 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfDIO4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:56:52 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 556A18027;
        Tue,  9 Apr 2019 14:57:07 +0000 (UTC)
Date:   Tue, 9 Apr 2019 07:56:49 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh@kernel.org,
        lee.jones@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] LM3532 backlight support improvements and
 relocation
Message-ID: <20190409145649.GE2839@atomide.com>
References: <20190407190951.27288-1-jacek.anaszewski@gmail.com>
 <20190407221740.GA6327@amd>
 <f96d09dc-3ddc-4ac7-3668-508df430f686@ti.com>
 <20190408193055.GN49658@atomide.com>
 <df6e1bf1-2588-46d0-c115-b6827174bb9b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6e1bf1-2588-46d0-c115-b6827174bb9b@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dan Murphy <dmurphy@ti.com> [190408 20:04]:
> Tony
> 
> On 4/8/19 2:30 PM, Tony Lindgren wrote:
> > * Dan Murphy <dmurphy@ti.com> [190408 15:54]:
> > > On 4/7/19 5:17 PM, Pavel Machek wrote:
> > > > Plus, I'd kind of expect ALS enabled/disabled to be runtime controled,
> > > > not from the device tree.
> > > We can always add runtime override control to the driver.
> > Yeah that sounds good to me :) Sounds like this can be done
> > with follow up patches though.
> > 
> > > Just need to see if there is a common interface from input or IIO we can adopt.
> > Hmm can the lm3532 registers actually show the value
> > for the ALS sensors?
> 
> 
> No it can only report the current configured ALS zone not the LUX value.

Sounds like it should be just enable/disable or auto/manual
type toggle then in /sys somewhere for the users.

Not sure if ledtrig-backlight-auto vs ledtrig-backlight would
make sense?

Regards,

Tony
