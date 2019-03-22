Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8413CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4EC218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCVHiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:38:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:42112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfCVHiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:38:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7494CAF0F;
        Fri, 22 Mar 2019 07:38:09 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 2E8C0E00BF; Fri, 22 Mar 2019 08:38:07 +0100 (CET)
Date:   Fri, 22 Mar 2019 08:38:07 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     John Linville <linville@tuxdriver.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: New ethtool sub-feature and ethtool-netlink
Message-ID: <20190322073807.GL29968@unicorn.suse.cz>
References: <4ecd48b3-92d6-38a1-11db-5c7b6a0ae341@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ecd48b3-92d6-38a1-11db-5c7b6a0ae341@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:23:36PM +0100, Heiner Kallweit wrote:
> I have an ethtool extension in the pipe that adds one more PHY tunable
> sub-feature (for Fast Link Down support). Are smaller extensions still
> ok for ethtool,

Adding a new PHY tunable is IMHO minor change which doesn't need to wait
for the netlink interface. It's a bit more complicated due to the way
tunables (and PHY tunables) are implemented in ioctl API (which requires
both sides to have a list of tunables and their interpretation) but that
is one of the things I would like to change. :-)

After all, I don't have support for (PHY) tunables in the netlink API
yet (not even in the part which hasn't been submitted yet).

> or IOW: When do you think is ethtool-netlink going to be stable enough
> so that other developers can add features?

I would say that once it reaches mainline and userspace starts to use
it, it will have to be stable (due to "Linus' first commandment"). When
that is going to be, that depends on how the review is going, it's hard
to guess.

Michal
