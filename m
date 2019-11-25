Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA9DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0CB207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfKYNtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:49:41 -0500
Received: from foss.arm.com ([217.140.110.172]:50674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfKYNtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:49:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3E7F31B;
        Mon, 25 Nov 2019 05:49:40 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508B43F6C4;
        Mon, 25 Nov 2019 05:49:39 -0800 (PST)
Subject: Re: [GIT PULL] scheduler changes for v5.5
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20191125125944.GA22218@gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9af8a5eb-5104-ad0b-bf46-dedb65d66a07@arm.com>
Date:   Mon, 25 Nov 2019 13:49:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125125944.GA22218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 12:59, Ingo Molnar wrote:

So I really don't want to be labeled as "that annoying scheduler PR guy",
but some patches in Vincent's rework should be squashed to avoid being
performance bisection honeypots.

> Vincent Guittot (14):
>       sched/fair: Remove meaningless imbalance calculation
>       sched/fair: Rework load_balance()

These two ^ (were split for ease of reviewing, [1])

>       sched/fair: Rework find_idlest_group()
>       sched/fair: Fix rework of find_idlest_group()

And these two ^ (Mel voiced similar concerns at [2])



Sorry for being annoying :/

[1]: https://lore.kernel.org/lkml/CAKfTPtCqLGJDNHgG099wQ7Gy6A+63yP36cxAR_somNPEcJMxGA@mail.gmail.com/
[2]: https://lore.kernel.org/lkml/20191030160749.GN3016@techsingularity.net/
