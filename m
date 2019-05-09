Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1DDC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575032175B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfEINJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:09:14 -0400
Received: from foss.arm.com ([217.140.101.70]:40990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfEINJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:09:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3DB9374;
        Thu,  9 May 2019 06:09:13 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF5EF3F7BD;
        Thu,  9 May 2019 06:09:10 -0700 (PDT)
Date:   Thu, 9 May 2019 14:09:08 +0100
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
Subject: Re: [PATCH v8 00/16] Add utilization clamping support
Message-ID: <20190509130908.vn24ucm5b2k36knc@e110439-lin>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190509130215.GV2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509130215.GV2623@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-May 15:02, Peter Zijlstra wrote:
> On Tue, Apr 02, 2019 at 11:41:36AM +0100, Patrick Bellasi wrote:
> > Series Organization
> > ===================
> > 
> > The series is organized into these main sections:
> > 
> >  - Patches [01-07]: Per task (primary) API
> >  - Patches [08-09]: Schedutil integration for FAIR and RT tasks
> >  - Patches [10-11]: Integration with EAS's energy_compute()
> 
> Aside from the comments already provided, I think this is starting to
> look really good.

Thanks Peter for the very useful review...
 
> Thanks!
> 
> >  - Patches [12-16]: Per task group (secondary) API
> 
> I still have to stare at these, but maybe a little later...

... I'll soon post a v9 to factor in all the last comments from this
round so that you have a better base for when you wanna start looking
at the cgroup bits.

-- 
#include <best/regards.h>

Patrick Bellasi
