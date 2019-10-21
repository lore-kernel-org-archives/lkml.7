Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D10CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B3E214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfJUNub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:50:31 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53971 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJUNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:50:31 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8652920012;
        Mon, 21 Oct 2019 13:50:28 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:50:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Andreas Kemnade <andreas@kemnade.info>, lee.jones@linaro.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, phh@phh.me, b.galvani@gmail.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 5/5] rtc: rtc-rc5t583: add ricoh rc5t619 RTC driver
Message-ID: <20191021135028.GV3125@piout.net>
References: <20191021054104.26155-1-andreas@kemnade.info>
 <20191021054104.26155-6-andreas@kemnade.info>
 <d59b7e21112ac96a2d88ae623eb523fc@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59b7e21112ac96a2d88ae623eb523fc@agner.ch>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2019 15:19:09+0200, Stefan Agner wrote:
> On 2019-10-21 07:41, Andreas Kemnade wrote:
> > Add an RTC driver for the RTC device on Ricoh MFD rc5t619,
> > which is implemented as a variant of rn5t618
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/rtc/Kconfig       |  10 +
> >  drivers/rtc/Makefile      |   1 +
> >  drivers/rtc/rtc-rc5t619.c | 476 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> Parts of this driver look very similar to drivers/rtc/rtc-rc5t583.c. Can
> it maybe shared?
> 

If this could be done it would be better. I can't find any public
datasheet though...

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
