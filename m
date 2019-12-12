Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E61C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADE521556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfLLSAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:00:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48429 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfLLSAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:00:30 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id c27927c87785b29b; Thu, 12 Dec 2019 19:00:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jonas Meurer <jonas@freesources.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>,
        Yannik Sembritzki <yannik@sembritzki.me>
Subject: Re: [PATCH 0/2] PM: Add a switch for disabling/enabling sync() before suspend
Date:   Thu, 12 Dec 2019 19:00:28 +0100
Message-ID: <3713877.SYXNVznUqu@kreacher>
In-Reply-To: <f94b4603-f438-b516-af53-c919f392ae3c@freesources.org>
References: <1ee5b9ef-f30e-3fde-2325-ba516a96ced5@freesources.org> <f94b4603-f438-b516-af53-c919f392ae3c@freesources.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 11, 2019 4:59:29 PM CET Jonas Meurer wrote:
> Hello,
> 
> Jonas Meurer:
> > Hello,
> > 
> > Introduce a new run-time sysfs switch to disable/enable sync() before
> > system suspend. This is useful to avoid races and deadlocks if block
> > devices have been suspended before, e.g. by 'cryptsetup luksSuspend'.
> > 
> > The second patch changes the behaviour of build-time switch
> > 'CONFIG_SUSPEND_SKIP_SYNC' accordingly, using the build-time switch value
> > as default for our new run-time switch '/sys/power/sync_on_suspend'.
> > 
> > Jonas Meurer (2):
> >   PM: Add a switch for disabling/enabling sync() before suspend
> >   PM: CONFIG_SUSPEND_SKIP_SYNC sets default for '/sys/power/sync_on_suspend'
> > 
> >  Documentation/ABI/testing/sysfs-power | 15 +++++++++++++++
> >  include/linux/suspend.h               |  2 ++
> >  kernel/power/Kconfig                  |  5 ++++-
> >  kernel/power/main.c                   | 33 +++++++++++++++++++++++++++++++++
> >  kernel/power/suspend.c                |  2 +-
> >  5 files changed, 55 insertions(+), 2 deletions(-)
> 
> Any chance to get a review/comment on this patch? What's the next
> logical steps to get it merged?

This is not a super-high priority patchset IMO, but it is in my list of things
to look at.

Thanks!



