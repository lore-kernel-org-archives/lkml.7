Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D13C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739A02071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfK0KAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:00:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:60146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfK0KAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:00:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A3F3B286;
        Wed, 27 Nov 2019 10:00:50 +0000 (UTC)
Date:   Wed, 27 Nov 2019 10:00:46 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     ?????? <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal Koutn? <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] sched/numa: expose per-task
 pages-migration-failure
Message-ID: <20191127100046.GM28938@suse.de>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <3931bf05-2939-0499-7660-8cc9a6f71c9a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3931bf05-2939-0499-7660-8cc9a6f71c9a@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 09:50:01AM +0800, ?????? wrote:
> NUMA balancing will try to migrate pages between nodes, which
> could caused by memory policy or numa group aggregation, while
> the page migration could failed too for eg when the target node
> run out of memory.
> 
> Since this is critical to the performance, admin should know
> how serious the problem is, and take actions before it causing
> too much performance damage, thus this patch expose the counter
> as 'migfailed' in '/proc/PID/sched'.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Suggested-by: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>

This patch can be treated independently of the rest of the series as
it's not directly related.

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
