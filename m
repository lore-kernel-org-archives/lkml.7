Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F6DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C721741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfK1Jla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:41:30 -0500
Received: from foss.arm.com ([217.140.110.172]:32828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK1Jla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:41:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A16D51FB;
        Thu, 28 Nov 2019 01:41:29 -0800 (PST)
Received: from [10.163.1.7] (unknown [10.163.1.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1560D3F52E;
        Thu, 28 Nov 2019 01:41:26 -0800 (PST)
Subject: Re: [v2 PATCH] mm: khugepaged: add trace status description for
 SCAN_PAGE_HAS_PRIVATE
To:     Yang Shi <yang.shi@linux.alibaba.com>, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1574793844-2914-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <caff6b97-fca8-4155-386a-cdd69717fef9@arm.com>
Date:   Thu, 28 Nov 2019 15:12:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1574793844-2914-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2019 12:14 AM, Yang Shi wrote:
> The commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem)
> FS") introduced a new khugepaged scan result: SCAN_PAGE_HAS_PRIVATE, but
> the corresponding description for trace events were not added.
> 
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v2: *Adopted the comments from Anshuman Khandual

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> 
>  include/trace/events/huge_memory.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index dd4db33..d82a0f4 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -31,7 +31,8 @@
>  	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
>  	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
>  	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
> -	EMe(SCAN_TRUNCATED,		"truncated")			\
> +	EM( SCAN_TRUNCATED,		"truncated")			\
> +	EMe(SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
>  
>  #undef EM
>  #undef EMe
> 
