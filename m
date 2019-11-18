Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92193C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704262071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfKRQMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:12:37 -0500
Received: from foss.arm.com ([217.140.110.172]:36590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfKRQMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:12:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E601FB;
        Mon, 18 Nov 2019 08:12:36 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 129E13F703;
        Mon, 18 Nov 2019 08:12:34 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:12:32 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191118161232.6qeolfuheroggbs5@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20191028143749.GE4114@hirez.programming.kicks-ass.net>
 <20191028140147.036a0001@grimm.local.home>
 <20191118154334.tolws225robfncp6@e107158-lin.cambridge.arm.com>
 <20191118105355.2f822886@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118105355.2f822886@oasis.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 10:53, Steven Rostedt wrote:
> On Mon, 18 Nov 2019 15:43:35 +0000
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> >   
> > > 
> > > Nothing against it, but I want to take a deeper look before we accept
> > > it. Are you OK in waiting a week? I'm currently at Open Source Summit
> > > and still have two more talks to write (giving them Thursday). I wont
> > > have time to look till next week.  
> > 
> > Apologies if I am being too pushy. But not sure whether this is waiting for its
> > turn in the queue or slipped through the cracks, hence another gentle reminder
> > in case it's the latter :-)
> 
> No you are not being too pushy, my apologies to you, it's been quite
> hectic lately (both from a business and personal stand point). I'll
> look at it now.
> 
> Thanks, and sorry for the delay :-(

No worries! I appreciate that you have to juggle a lot of things together. As
long as it's on the queue and isn't accidentally dropped, then it is what it
is.

Many thanks

--
Qais Yousef
