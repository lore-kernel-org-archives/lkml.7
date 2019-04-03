Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04427C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC7920882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfDCHqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:46:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfDCHqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:46:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4B96AE21;
        Wed,  3 Apr 2019 07:46:00 +0000 (UTC)
Subject: Re: [PATCH] mm: __pagevec_lru_add_fn: typo fix
To:     Peng Fan <peng.fan@nxp.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "ldr709@gmail.com" <ldr709@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
References: <20190402095609.27181-1-peng.fan@nxp.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <38b6976a-9529-5ce5-f0f8-03dbf7548437@suse.cz>
Date:   Wed, 3 Apr 2019 09:45:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190402095609.27181-1-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 11:43 AM, Peng Fan wrote:
> There is no function named munlock_vma_pages, correct it to
> munlock_vma_page.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 301ed4e04320..3a75722e68a9 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -867,7 +867,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
>  	SetPageLRU(page);
>  	/*
>  	 * Page becomes evictable in two ways:
> -	 * 1) Within LRU lock [munlock_vma_pages() and __munlock_pagevec()].
> +	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
>  	 * 2) Before acquiring LRU lock to put the page to correct LRU and then
>  	 *   a) do PageLRU check with lock [check_move_unevictable_pages]
>  	 *   b) do PageLRU check before lock [clear_page_mlock]
> 

