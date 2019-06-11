Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F47C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5370C205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391548AbfFKOyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:54:46 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50628 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388097AbfFKOyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:54:46 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x5BEsfXD002810;
        Tue, 11 Jun 2019 16:54:41 +0200
Date:   Tue, 11 Jun 2019 16:54:41 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     =?iso-8859-1?Q?=D6yvind?= Saether <oyvinds@linuxreviews.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Why "must" we upgrade the kernels? A hint would be nice
Message-ID: <20190611145441.GB2788@1wt.eu>
References: <20190611163142.1f7c8146@taeyeon.everdot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190611163142.1f7c8146@taeyeon.everdot.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:31:42PM +0200, Öyvind Saether wrote:
> All the recently released kernels have had a "All users of the
> _branch_ kernel series must upgrade." notice. It would be informative
> to have some indication as to why users "must" upgrade. The logs are
> long and do not really say if there is some urgent reason to upgrade.
> 
> Also, as I point out in my latest article about them kernels at
> https://linuxreviews.org/Mihan - it is fair to wonder if Greg just put
> that warning in a template and forgot about it since it appears to be
> attached to every single kernel-release. A warning like that gets less
> urgent each time it appears.

I'm pretty sure he keeps it on purpose and it's not a bad idea. Each time
you say someone "now you must really upgrade", you can be sure that no
other upgrades will happen. In practice the kernel is robust enough to
resist not being upgraded every week. And in the rare cases it will not
be true, you will learn about it instantly via news channels. It's also
worth reminding that what is critical to some is totally irrelevant to
others, and with the millions of users following these updates, it's
really impossible to tell which update is important and which one is
not.

Just proceed like most of us : try to stay up to date, take the opportunity
of a calm afternoon to upgrade and reboot once in a while and that's fine.
I personally do it every time my laptop runs out of juice because that's
the moment where I know I will not lose my environment again :-)

It's not uncommon to see devices shipping with thousands of bugs remaining
unfixed for 6 months or more, so you can really consider that you're
doing a good job if you're updating more often than this. A good hint is
to remember to update when you see a new major kernel issued (every 2.5
months on average). If you're on LTS and have little time available, just
pick the latest one of your branch. If you're on LTS with a bit more time,
try to upgrade to a more recent LTS branch (takes more time just because
you'll discover many new config options). If you're following -stable and
not LTS, then at this pace you can take the latest stable of the branch
just before the newly issued one. For example I upgraded my laptop to
4.19.48 this week-end. I wanted to go to 5.1 but didn't feel brave enough
to go through "make oldconfig" this time. And I won't upgrade it again
within the next month or so.

Overall it's not as if options were lacking. Just don't feel guilty and
be reasonable with your upgrades. You'll then see that the "all users
must upgrade" advice becomes an excellent reminder!

Just my two cents,
Willy
