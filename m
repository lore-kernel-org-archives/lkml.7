Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D193DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA92B2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfHZWol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:44:41 -0400
Received: from muru.com ([72.249.23.125]:58782 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfHZWol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:44:41 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8990B80AA;
        Mon, 26 Aug 2019 22:45:09 +0000 (UTC)
Date:   Mon, 26 Aug 2019 15:44:37 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, jacek.anaszewski@gmail.com,
        sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] leds: lm3532: Fix brightness control for i2c mode
Message-ID: <20190826224437.GZ52127@atomide.com>
References: <20190820195307.27590-1-dmurphy@ti.com>
 <20190826215822.GY52127@atomide.com>
 <20190826221413.GA19124@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826221413.GA19124@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190826 22:14]:
> On Mon 2019-08-26 14:58:22, Tony Lindgren wrote:
> > Hi,
> > 
> > * Dan Murphy <dmurphy@ti.com> [190820 19:53]:
> > > Fix the brightness control for I2C mode.  Instead of
> > > changing the full scale current register update the ALS target
> > > register for the appropriate banks.
> > > 
> > > In addition clean up some code errors and random misspellings found
> > > during coding.
> > > 
> > > Tested on Droid4 as well as LM3532 EVM connected to a BeagleBoneBlack
> > > 
> > > Fixes: e37a7f8d77e1 ("leds: lm3532: Introduce the lm3532 LED driver")
> > > Reported-by: Pavel Machek <pavel@ucw.cz>
> > > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > > ---
> > > 
> > > v3 - Removed register define updates - https://lore.kernel.org/patchwork/patch/1114542/
> > 
> > Looks like starting with this patch in Linux next the LCD on droid4
> > is so dim it's unreadable even with brightness set to 255. Setting
> > brightness to 0 does blank it completely though.
> > 
> > Did something maybe break with the various patch revisions or are
> > we now missing some dts patch?
> 
> Maybe missing dts patch. We should provide maximum current the LED can
> handle... 

Or i2c control is somehow broken and only als control now works?

Regards,

Tony

