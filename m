Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB62C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DCE217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfI0NxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:53:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60707 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfI0NxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:53:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DB93D80551; Fri, 27 Sep 2019 15:52:51 +0200 (CEST)
Date:   Fri, 27 Sep 2019 15:53:00 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        tim.c.chen@linux.intel.com, mingo@redhat.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com, pjt@google.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org, tj@kernel.org,
        rafael.j.wysocki@intel.com, qais.yousef@arm.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: Usecases for the per-task latency-nice attribute
Message-ID: <20190927135259.GB3557@bug>
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
 <87woe51ydd.fsf@arm.com>
 <77457d5b-185e-1548-4a5c-9b911b036cec@arm.com>
 <dc0712e4-f66f-a92b-fbf9-a3a84cf982a6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0712e4-f66f-a92b-fbf9-a3a84cf982a6@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't want to start a bikeshedding session here, but I agree with Parth
> > on the interpretation of the values.
> > 
> > I've always read niceness values as
> > -20 (least nice to the system / other processes)
> > +19 (most nice to the system / other processes)
> > 
> > So following this trend I'd see for latency-nice:
> 
> 
> So jotting down separately, in case if we think to have "latency-nice"
> terminology, then we might need to select one of the 2 interpretation:
> 
> 1).
> > -20 (least nice to latency, i.e. sacrifice latency for throughput)
> > +19 (most nice to latency, i.e. sacrifice throughput for latency)
> > 
> 
> 2).
> -20 (least nice to other task in terms of sacrificing latency, i.e.
> latency-sensitive)
> +19 (most nice to other tasks in terms of sacrificing latency, i.e.
> latency-forgoing)

For the record, interpretation 2 makes sense to me.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
