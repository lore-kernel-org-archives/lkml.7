Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83322C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAA22187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfKGH3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:29:44 -0500
Received: from foss.arm.com ([217.140.110.172]:50950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfKGH3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:29:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 466DD46A;
        Wed,  6 Nov 2019 23:29:43 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7DE53F71A;
        Wed,  6 Nov 2019 23:32:37 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:29:39 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: core: fix compilation error when cgroup not
 selected
Message-ID: <20191107072939.u5a3p7apphq5oxnm@e107158-lin.cambridge.arm.com>
References: <20191105112212.596-1-qais.yousef@arm.com>
 <20191107072525.GA19642@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107072525.GA19642@darkstar>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick

On 11/07/19 07:25, Patrick Bellasi wrote:

[...]

> Thanks for posting this again.
> 
> We now have three "versions" of this same fix, including:
>  - the original bug report by Randy and a fix from me here:
>    Message-ID: <8736gv2gbv.fsf@arm.com>
>    https://lore.kernel.org/linux-next/8736gv2gbv.fsf@arm.com/
>  - and a follow up patch from Arnd:
>    Message-ID: <20190918195957.2220297-1-arnd@arndb.de>
>    https://lore.kernel.org/lkml/20190918195957.2220297-1-arnd@arndb.de/

Oh I should have done my homework better. FWIW I caught this on 5.4-rc6 so
that's why I didn't think there was a fix posted.

I don't mind which version gets picked. But if it can go in before 5.4 is
released that'd be great.

Thanks

--
Qais Yousef
