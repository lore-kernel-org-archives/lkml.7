Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D418C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E652184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfCNIao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:30:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:49886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbfCNIao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:30:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D52EEAD4E;
        Thu, 14 Mar 2019 08:30:42 +0000 (UTC)
Subject: Re: [PATCH] mm: compaction: show gfp flag names in
 try_to_compact_pages tracepoint
To:     Yafang Shao <laoar.shao@gmail.com>, mhocko@suse.com,
        jrdr.linux@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com
References: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <75d7cff9-add2-20f4-ae3e-2d99048c6614@suse.cz>
Date:   Thu, 14 Mar 2019 09:30:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/19 5:38 AM, Yafang Shao wrote:
> show the gfp flag names instead of the gfp_mask could make the trace
> more convenient.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/trace/events/compaction.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
> index 6074eff..e66afb818 100644
> --- a/include/trace/events/compaction.h
> +++ b/include/trace/events/compaction.h
> @@ -189,9 +189,9 @@
>  		__entry->prio = prio;
>  	),
>  
> -	TP_printk("order=%d gfp_mask=0x%x priority=%d",
> +	TP_printk("order=%d gfp_mask=%s priority=%d",
>  		__entry->order,
> -		__entry->gfp_mask,
> +		show_gfp_flags(__entry->gfp_mask),
>  		__entry->prio)
>  );
>  
> 

