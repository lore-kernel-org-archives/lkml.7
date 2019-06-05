Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AA6C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174472075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFEWdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:33:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEWds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:33:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E24FB374;
        Wed,  5 Jun 2019 15:33:47 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FE503F5AF;
        Wed,  5 Jun 2019 15:33:45 -0700 (PDT)
Date:   Wed, 5 Jun 2019 23:33:43 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 0/6] sched: Add new tracepoints required for EAS
 testing
Message-ID: <20190605223343.r42pgngvs7myzfke@e107158-lin.cambridge.arm.com>
References: <20190604111459.2862-1-qais.yousef@arm.com>
 <20190605061748.GA20661@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605061748.GA20661@infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/19 23:17, Christoph Hellwig wrote:
> > The following patches add the bare minimum tracepoints required to perform EAS
> > testing in Lisa[1].
> 
> What is EAS?  Whhy is "Lisa" not part of the patch submission?
> submission.

EAS is Energy Aware Scheduling. It was merged in 5.0.

Lisa is a python based testing platform that has dependency on other binaries
like trace-cmd, rt-app, etc. It is not suitable for kernel submission.

Lisa, or any userspace based testing for that matter, requires to know what's
happening inside the scheduler to test its behavior. I don't know know of any
other scheduler centric testing framework. I didn't intend to specify Lisa as
the sole user and reason for these tracepoints, I know others are interested in
these tracepoints in general for anyone who wants to achieve a similar goal of
studying scheduler PELT behavior and how it affects some of the decisions it
makes.

We had a talk in OSPM a couple of weeks ago to cover this topic if you're
interested to learn more

	https://www.youtube.com/watch?v=I_MZ9XS3_zc

> 
> > It is done in this way because adding new TRACE_EVENTS() is no longer accepted
> > AFAIU.
> 
> Huh?  We keep adding trace events all the time.  And they actually
> are useful because they are testable.
> 
> This series on the other hand adds exports not used in tree, which is
> a big no-go.

I see that Peter has already covered this part.

Thanks

--
Qais Yousef
