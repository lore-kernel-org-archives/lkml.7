Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E589DC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B912A20821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfEVOqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:46:18 -0400
Received: from mail.gydle.com ([64.18.173.180]:41483 "EHLO mail.gydle.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbfEVOqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:46:16 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 10:46:16 EDT
X-Received: from [192.168.1.136] (unknown [69.70.179.254])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboisvert@gydle.com)
        by mail.gydle.com (Postfix) with ESMTPSA id D37AB442DB;
        Wed, 22 May 2019 10:39:47 -0400 (EDT)
Subject: Re: [lttng-dev] [PATCH v2] mm: Rename mm_vmscan_lru_shrink_inactive
 trace event variables
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        mjeanson@efficios.com, rostedt@goodmis.org,
        lttng-dev@lists.lttng.org, linux-kernel@vger.kernel.org
References: <155851455676.7870.1951762540769724271.stgit@localhost.localdomain>
 <9b9a8da4-556a-8972-cf87-071ce5099ad0@virtuozzo.com>
From:   Sebastien Boisvert <sboisvert@gydle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sboisvert@gydle.com; keydata=
 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
 vnOzfc5OOiR/D+lE
Message-ID: <a187c72c-9ca2-7668-fc60-e9c310c30d5c@gydle.com>
Date:   Wed, 22 May 2019 10:39:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9b9a8da4-556a-8972-cf87-071ce5099ad0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-05-22 6:17 a.m., Kirill Tkhai wrote:
> Rename nr_activate{0,1} into nr_activate{anon,file} since this

Rename nr_activate{0,1} into nr_activate{anon,file}
                                        ^
                                         add an underscore here
 (nr_activate_anon, nr_activate_file).


> is exported into userspace, e.g., it's shown here:
> 
> /sys/kernel/debug/tracing/events/vmscan/mm_vmscan_lru_shrink_inactive/format
> 
> v2: Changed suggested person (sorry, Mathieu :))
> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/trace/events/vmscan.h |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index a5ab2973e8dc..c316279715f4 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -348,8 +348,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>  		__field(unsigned long, nr_writeback)
>  		__field(unsigned long, nr_congested)
>  		__field(unsigned long, nr_immediate)
> -		__field(unsigned int, nr_activate0)
> -		__field(unsigned int, nr_activate1)
> +		__field(unsigned int, nr_activate_anon)
> +		__field(unsigned int, nr_activate_file)
>  		__field(unsigned long, nr_ref_keep)
>  		__field(unsigned long, nr_unmap_fail)
>  		__field(int, priority)
> @@ -364,8 +364,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>  		__entry->nr_writeback = stat->nr_writeback;
>  		__entry->nr_congested = stat->nr_congested;
>  		__entry->nr_immediate = stat->nr_immediate;
> -		__entry->nr_activate0 = stat->nr_activate[0];
> -		__entry->nr_activate1 = stat->nr_activate[1];
> +		__entry->nr_activate_anon = stat->nr_activate[0];
> +		__entry->nr_activate_file = stat->nr_activate[1];
>  		__entry->nr_ref_keep = stat->nr_ref_keep;
>  		__entry->nr_unmap_fail = stat->nr_unmap_fail;
>  		__entry->priority = priority;
> @@ -377,7 +377,7 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>  		__entry->nr_scanned, __entry->nr_reclaimed,
>  		__entry->nr_dirty, __entry->nr_writeback,
>  		__entry->nr_congested, __entry->nr_immediate,
> -		__entry->nr_activate0, __entry->nr_activate1,
> +		__entry->nr_activate_anon, __entry->nr_activate_file,
>  		__entry->nr_ref_keep, __entry->nr_unmap_fail,
>  		__entry->priority,
>  		show_reclaim_flags(__entry->reclaim_flags))
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
