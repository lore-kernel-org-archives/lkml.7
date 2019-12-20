Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B08DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461762465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLTQBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:01:54 -0500
Received: from foss.arm.com ([217.140.110.172]:52848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfLTQBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:01:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F9CD1FB;
        Fri, 20 Dec 2019 08:01:53 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 299DA3F6CF;
        Fri, 20 Dec 2019 08:01:52 -0800 (PST)
Date:   Fri, 20 Dec 2019 16:01:49 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191220160149.fj5gdkaxm763fhfl@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20191028143749.GE4114@hirez.programming.kicks-ass.net>
 <20191028140147.036a0001@grimm.local.home>
 <20191028205034.GL4643@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028205034.GL4643@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

On 10/28/19 21:50, Peter Zijlstra wrote:
> On Mon, Oct 28, 2019 at 02:01:47PM -0400, Steven Rostedt wrote:
> > On Mon, 28 Oct 2019 15:37:49 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Works for me; Steve you OK with this?
> > 
> > Nothing against it, but I want to take a deeper look before we accept
> > it. Are you OK in waiting a week? I'm currently at Open Source Summit
> > and still have two more talks to write (giving them Thursday). I wont
> > have time to look till next week.
> 
> Sure, I'll keep it in my queue, but will make sure it doesn't hit -tip
> until you've had time.

Reviewers are happy with this now. It'd be nice if you can pick it up again for
the next round to -tip.

Thanks!

--
Qais Yousef
