Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58C6C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69E12077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfG1NYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:24:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58916 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1NYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:24:25 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 33D9E80239; Sun, 28 Jul 2019 15:24:11 +0200 (CEST)
Date:   Sun, 28 Jul 2019 15:24:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     liuyonglong <liuyonglong@huawei.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        shiju.jose@huawei.com
Subject: Re: [PATCH net] net: hns: fix LED configuration for marvell phy
Message-ID: <20190728132412.GC8718@xo-6d-61-c0.localdomain>
References: <1563775152-21369-1-git-send-email-liuyonglong@huawei.com>
 <20190722.181906.2225538844348045066.davem@davemloft.net>
 <72061222-411f-a58c-5873-ad873394cdb5@huawei.com>
 <20190725042829.GB14276@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725042829.GB14276@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-07-25 06:28:29, Andrew Lunn wrote:
> On Thu, Jul 25, 2019 at 11:00:08AM +0800, liuyonglong wrote:
> > > Revert "net: hns: fix LED configuration for marvell phy"
> > > This reverts commit f4e5f775db5a4631300dccd0de5eafb50a77c131.
> > >
> > > Andrew Lunn says this should be handled another way.
> > >
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > 
> > 
> > Hi Andrew:
> > 
> > I see this patch have been reverted, can you tell me the better way to do this?
> > Thanks very much!
> 
> Please take a look at the work Matthias Kaehlcke is doing. It has not
> got too far yet, but when it is complete, it should define a generic
> way to configure PHY LEDs.

I don't remember PHY LED discussion from LED mailing list. Would you have a pointer?
Would it make sense to coordinate with LED subsystem?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
