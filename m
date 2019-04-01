Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA5C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695972133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfDAPQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:16:33 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54043 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDAPQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:16:32 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6DDCA2000F;
        Mon,  1 Apr 2019 15:16:29 +0000 (UTC)
Date:   Mon, 1 Apr 2019 17:16:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190401151628.GK3430@piout.net>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190401084143.uqbiktkt2vltgrxa@ninjato>
 <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401150741.vwqzzngnma4jvkid@ninjato>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 17:07:42+0200, Wolfram Sang wrote:
> On Mon, Apr 01, 2019 at 03:39:43PM +0200, Geert Uytterhoeven wrote:
> > Hi Wolfram,
> > 
> > On Mon, Apr 1, 2019 at 3:21 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > > I was just wondering whether they work for Wolfram, who has a similar
> > > > but different board than I have. Last time I tried, they didn't work for me.
> > >
> > > How did you test?
> > 
> > tools/testing/selftests/rtc/rtctest.c cfr.
> > https://lore.kernel.org/lkml/CAMuHMdWbV2=LfSWz0rFTGRakZ=2iXKOYdM_Uwaov8-OsJpUgoA@mail.gmail.com/
> 
> Hmm, with vanilla v5.1-rc3, I don't even get that far:
> 
> [==========] Running 7 tests from 2 test cases.
> [ RUN      ] rtc.date_read
> rtctest.c:49:rtc.date_read:Current RTC date/time is 01/01/2000 04:06:40.
> [       OK ] rtc.date_read
> [ RUN      ] rtc.uie_read
> 
> And here it blocks forever. Any pointers?
>

This means that you don't get any interrupt from your RTC (and that I
have to fix the timeout for uie_read).

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
