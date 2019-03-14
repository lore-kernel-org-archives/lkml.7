Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52799C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C98C2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCNPIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:08:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfCNPH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:07:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27BE1A78;
        Thu, 14 Mar 2019 08:07:59 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34B023F59C;
        Thu, 14 Mar 2019 08:07:56 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:07:53 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190314150753.lzu6uftirxnhdv4y@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313134022.GB5922@hirez.programming.kicks-ass.net>
 <20190313161229.pkib2tmjass5chtb@e110439-lin>
 <20190313194838.GS2482@worktop.programming.kicks-ass.net>
 <20190314121315.juqpsqu5cwouuqpp@e110439-lin>
 <20190314133211.GJ5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314133211.GJ5996@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Mar 14:32, Peter Zijlstra wrote:
> On Thu, Mar 14, 2019 at 12:13:15PM +0000, Patrick Bellasi wrote:
> > > I'd be most impressed if they pull this off. Check the generated code
> > > and see I suppose :-)
> > 
> > On x86 the code generated looks exactly the same:
> > 
> >    https://godbolt.org/z/PjmA7k
> 
> Argh, they do mult by inverse to avoid the division, and can do this
> because its a constant.
> 
> And then yes, your arm version looks worse.

your "arm version" is worst then x86, or "your version" is worse?

IOW, should I keep the code as the original? Do you prefer your
version? Or... we don't really care...

> It does what I expected with -Os, but as Rutland said the other day,
> that stands for Optimize for Sadness.

Yes, I guess we cannot optimize for all flags... however, just let me
know what you prefer and I'll put that version in ;)

-- 
#include <best/regards.h>

Patrick Bellasi
