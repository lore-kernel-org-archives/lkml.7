Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD8BC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8415E21835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgABR3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:29:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgABR3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:29:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C511206E6;
        Thu,  2 Jan 2020 17:29:03 +0000 (UTC)
Date:   Thu, 2 Jan 2020 12:29:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Load balance aggressively for SCHED_IDLE
 CPUs
Message-ID: <20200102122901.6acbf857@gandalf.local.home>
In-Reply-To: <885b1be9af68d124f44a863f54e337f8eb6c4917.1577090998.git.viresh.kumar@linaro.org>
References: <885b1be9af68d124f44a863f54e337f8eb6c4917.1577090998.git.viresh.kumar@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2019 10:43:30 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This is tested on ARM64 Hikey620 platform (octa-core) with the help of
> rt-app and it is verified, using kernel traces, that the newly
> SCHED_IDLE CPU does load balancing shortly after it becomes SCHED_IDLE
> and pulls tasks from other busy CPUs.

Can you post the actual steps you used to test this and show the before
and after results? Then others can reproduce what you have shown and
even run other tests to see if this change has any other side effects.

Thanks!

-- Steve
