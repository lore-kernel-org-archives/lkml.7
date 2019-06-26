Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98894C48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5FC216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFZTBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:01:04 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55411 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZTBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:01:03 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 8E5E6C0006;
        Wed, 26 Jun 2019 19:00:53 +0000 (UTC)
Date:   Wed, 26 Jun 2019 21:00:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Claudiu.Beznea@microchip.com, mturquette@baylibre.com,
        Nicolas.Ferre@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        claudiu.beznea@gmail.com
Subject: Re: [PATCH 0/7] clk: at91: sckc: improve error path
Message-ID: <20190626190053.GA3692@piout.net>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
 <20190618095521.GE23549@piout.net>
 <929ac20b-db1d-3f7a-b37c-0dfb253156d5@microchip.com>
 <20190621093302.GJ23549@piout.net>
 <20190626185359.D90C120B1F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626185359.D90C120B1F@mail.kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2019 11:53:59-0700, Stephen Boyd wrote:
> Quoting Alexandre Belloni (2019-06-21 02:33:02)
> > On 20/06/2019 10:30:42+0000, Claudiu.Beznea@microchip.com wrote:
> > > Hi,
> > > 
> > > On 18.06.2019 12:55, Alexandre Belloni wrote:
> > > > On 13/06/2019 15:37:06+0000, Claudiu.Beznea@microchip.com wrote:
> > > >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> > > >>
> > > >> Hi,
> > > >>
> > > >> This series tries to improve error path for slow clock registrations
> > > >> by adding functions to free resources and using them on failures.
> > > >>
> > > > 
> > > > Does the platform even boot when the slow clock is not available? 
> > > > 
> > > > The TCB clocksource would fail at:
> > > > 
> > > >         tc.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
> > > >         if (IS_ERR(tc.slow_clk))
> > > >                 return PTR_ERR(tc.slow_clk);
> > > > 
> > > 
> > > In case of using TC as clocksource, yes, the platform wouldn't boot if slow
> > > clock is not available, because, anyway the TC needs it. PIT may work
> > > without it (if slow clock is not used to drive the PIT).
> > > 
> > > For sure there are other IPs (which may be or are driven by slow clock)
> > > which may not work if slow clock is driven them.
> > > 
> > > Anyway, please let me know if you feel this series has no meaning.
> > > 
> > 
> > Well, I'm not sure it is worth it but at the same time, it is not adding
> > many lines and you already developed it...
> > 
> 
> Is that a Reviewed-by or a Rejected-by tag?
> 

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
