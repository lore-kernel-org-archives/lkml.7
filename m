Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D36FC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538C9217BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfK2NzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:55:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:58888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbfK2NzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:55:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE6FCAC68;
        Fri, 29 Nov 2019 13:55:10 +0000 (UTC)
Subject: Re: [PATCH] mm: Proactive compaction
To:     Nitin Gupta <nigupta@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20191115222148.2666-1-nigupta@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1deccc9c-0aea-880e-772b-9b965a457d0a@suse.cz>
Date:   Fri, 29 Nov 2019 14:55:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191115222148.2666-1-nigupta@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 11:21 PM, Nitin Gupta wrote:
> For some applications we need to allocate almost all memory as
> hugepages. However, on a running system, higher order allocations can
> fail if the memory is fragmented. Linux kernel currently does on-demand
> compaction as we request more hugepages but this style of compaction
> incurs very high latency. Experiments with one-time full memory
> compaction (followed by hugepage allocations) shows that kernel is able
> to restore a highly fragmented memory state to a fairly compacted memory
> state within <1 sec for a 32G system. Such data suggests that a more
> proactive compaction can help us allocate a large fraction of memory as
> hugepages keeping allocation latencies low.
> 
> For a more proactive compaction, the approach taken here is to define
> per page-node tunable called ‘hpage_compaction_effort’ which dictates
> bounds for external fragmentation for HPAGE_PMD_ORDER pages which
> kcompactd should try to maintain.
> 
> The tunable is exposed through sysfs:
>   /sys/kernel/mm/compaction/node-n/hpage_compaction_effort
> 
> The value of this tunable is used to determine low and high thresholds
> for external fragmentation wrt HPAGE_PMD_ORDER order.

Could we instead start with a non-tunable value that would be linked to
 to e.g. the number of THP allocations between kcompactd cycles?
Anything we expose will inevitably get set to stone, I'm afraid, so I
would introduce it only as a last resort.

> Note that previous version of this patch [1] was found to introduce too
> many tunables (per-order, extfrag_{low, high}) but this one reduces them
> to just (per-node, hpage_compaction_effort). Also, the new tunable is an
> opaque value instead of asking for specific bounds of “external
> fragmentation” which would have been difficult to estimate. The internal
> interpretation of this opaque value allows for future fine-tuning.
> 
> Currently, we use a simple translation from this tunable to [low, high]
> extfrag thresholds (low=100-hpage_compaction_effort, high=low+10%). To
> periodically check per-node extfrag status, we reuse per-node kcompactd
> threads which are woken up every few milliseconds to check the same. If
> any zone on its corresponding node has extfrag above the high threshold
> for the HPAGE_PMD_ORDER order, the thread starts compaction in
> background till all zones are below the low extfrag level for this
> order. By default. By default, the tunable is set to 0 (=> low=100%,
> high=100%).
> 
> This patch is largely based on ideas from Michal Hocko posted here:
> https://lore.kernel.org/linux-mm/20161230131412.GI13301@dhcp22.suse.cz/
> 
> * Performance data
> 
> System: x64_64, 32G RAM, 12-cores.
> 
> I made a small driver that allocates as many hugepages as possible and
> measures allocation latency:
> 
> The driver first tries to allocate hugepage using GFP_TRANSHUGE_LIGHT
> and if that fails, tries to allocate with `GFP_TRANSHUGE |
> __GFP_RETRY_MAYFAIL`. The drives stops when both methods fail for a
> hugepage allocation.
> 
> Before starting the driver, the system was fragmented from a userspace
> program that allocates all memory and then for each 2M aligned section,
> frees 3/4 of base pages using munmap. The workload is mainly anonymous
> userspace pages which are easy to move around. I intentionally avoided
> unmovable pages in this test to see how much latency we incur just by
> hitting the slow path for most allocations.
> 
> (all latency values are in microseconds)
> 
> - With vanilla kernel 5.4.0-rc5:
> 
> percentile latency
> ---------- -------
>          5       7
>         10       7
>         25       8
>         30       8
>         40       8
>         50       8
>         60       9
>         75     215
>         80     222
>         90     323
>         95     429
> 
> Total 2M hugepages allocated = 1829 (3.5G worth of hugepages out of 25G
> total free => 14% of free memory could be allocated as hugepages)
> 
> - Now with kernel 5.4.0-rc5 + this patch:
> (hpage_compaction_effort = 60)
> 
> percentile latency
> ---------- -------
>          5       3
>         10       3
>         25       4
>         30       4
>         40       4
>         50       4
>         60       5
>         75       6
>         80       9
>         90     370
>         95     652
> 
> Total 2M hugepages allocated = 11120 (21.7G worth of hugepages out of
> 25G total free => 86% of free memory could be allocated as hugepages)

I wonder about the 14->86% improvement. As you say, this kind of
fragmentation is easy to compact. Why wouldn't GFP_TRANSHUGE |
__GFP_RETRY_MAYFAIL attempts succeed?

Thanks,
Vlastimil

> Above workload produces a memory state which is easy to compact.
> However, if memory is filled with unmovable pages, pro-active compaction
> should essentially back off. To test this aspect, I ran a mix of this
> workload (thanks to Matthew Wilcox for suggesting these):
> 
> - dentry_thrash: it opens /tmp/missing.x for x in [1, 1000000] where
> first 10000 files actually exist.
> - pagecache_thrash: it opens a 128G file (on a 32G system) and then
> reads at random offsets.
> 
> With this mix of workload, system quickly reaches 90-100% fragmentation
> wrt order-9. Trace of compaction events shows that we keep hitting
> compaction_deferred event, as expected.
> 
> After terminating dentry_thrash and dropping denty caches, the system
> could proceed with compaction according to set value of
> hpage_compaction_effort (60).
> 
> [1] https://patchwork.kernel.org/patch/11098289/
> 
> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
