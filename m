Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E991C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5458A2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfGSQrP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:47:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727528AbfGSQrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:47:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80171AF9C;
        Fri, 19 Jul 2019 16:47:13 +0000 (UTC)
Date:   Fri, 19 Jul 2019 18:47:11 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     keescook@chromium.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        Peter Zijlstra <peterz@infradead.org>, mcgrof@kernel.org,
        mhocko@kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, riel@surriel.com,
        Mel Gorman <mgorman@suse.de>, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] numa: introduce per-cgroup numa balancing locality,
 statistic
Message-ID: <20190719164711.GB854@blackbody.suse.cz>
References: <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <3ac9b43a-cc80-01be-0079-df008a71ce4b@linux.alibaba.com>
 <20190711134754.GD3402@hirez.programming.kicks-ass.net>
 <b027f9cc-edd2-840c-3829-176a1e298446@linux.alibaba.com>
 <20190712075815.GN3402@hirez.programming.kicks-ass.net>
 <37474414-1a54-8e3a-60df-eb7e5e1cc1ed@linux.alibaba.com>
 <20190712094214.GR3402@hirez.programming.kicks-ass.net>
 <f8020f92-045e-d515-360b-faf9a149ab80@linux.alibaba.com>
 <20190715121025.GN9035@blackbody.suse.cz>
 <ecd21563-539c-06b1-92f2-26a111163174@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ecd21563-539c-06b1-92f2-26a111163174@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:41:36AM +0800, 王贇  <yun.wang@linux.alibaba.com> wrote:
> Actually whatever the memory node sets or cpu allow sets is, it will
> take effect on task's behavior regarding memory location and cpu
> location, while the locality only care about the results rather than
> the sets.
My previous response missed much of the context, so it was a bit off.

I see what you mean by the locality now. Alas, I can't assess whether
it's the right thing to do regarding NUMA behavior that you try to
optimize (i.e. you need an answer from someone more familiar with NUMA
balancing).

Michal
