Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392FAC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084182084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDINPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:15:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDINPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:15:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D386C0733FA;
        Tue,  9 Apr 2019 13:15:41 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1349C5DA96;
        Tue,  9 Apr 2019 13:15:39 +0000 (UTC)
Date:   Tue, 9 Apr 2019 09:15:38 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, bsegall@google.com,
        torvalds@linux-foundation.org, anton@ozlabs.org, efault@gmx.de,
        mingo@kernel.org, tglx@linutronix.de,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/fair: Limit sched_cfs_period_timer loop
 to avoid hard lockup
Message-ID: <20190409131537.GC10132@pauld.bos.csb>
References: <20190319130005.25492-1-pauld@redhat.com>
 <tip-06ec5d30e8d57b820d44df6340dcb25010d6d0fa@git.kernel.org>
 <20190409124815.GA10132@pauld.bos.csb>
 <20190409130527.GR11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409130527.GR11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 09 Apr 2019 13:15:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 03:05:27PM +0200 Peter Zijlstra wrote:
> On Tue, Apr 09, 2019 at 08:48:16AM -0400, Phil Auld wrote:
> > Hi Ingo, Peter,
> > 
> > On Wed, Apr 03, 2019 at 01:38:39AM -0700 tip-bot for Phil Auld wrote:
> > > Commit-ID:  06ec5d30e8d57b820d44df6340dcb25010d6d0fa
> > > Gitweb:     https://git.kernel.org/tip/06ec5d30e8d57b820d44df6340dcb25010d6d0fa
> > > Author:     Phil Auld <pauld@redhat.com>
> > > AuthorDate: Tue, 19 Mar 2019 09:00:05 -0400
> > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > CommitDate: Wed, 3 Apr 2019 09:50:23 +0200
> > 
> > This commit seems to have gotten lost. It's not in tip and now the 
> > direct gitweb link is also showing bad commit reference. 
> > 
> > Did this fall victim to a reset or something?
> 
> It had (trivial) builds fails on 32 bit. I have a fixed up version
> around somewhere, but that hasn't made it back in yet.

Drat. Sorry about that. At least I'm not going crazy...  

Do you want me to fix it and push it back or will you do that? 


Thanks,
Phil


-- 
