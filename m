Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BBFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8C32154A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK1F0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 00:26:37 -0500
Received: from foss.arm.com ([217.140.110.172]:59070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK1F0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 00:26:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6628C30E;
        Wed, 27 Nov 2019 21:26:36 -0800 (PST)
Received: from [10.163.1.7] (unknown [10.163.1.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0932C3F6C4;
        Wed, 27 Nov 2019 21:26:33 -0800 (PST)
Subject: Re: [PATCH v2] mm: fix comments related to node reclaim
To:     Hao Lee <haolee.swjtu@gmail.com>, akpm@linux-foundation.org
Cc:     mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20191126141346.GA22665@haolee.github.io>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <688fe7f3-f94c-6e67-9c35-0d6cf1096e02@arm.com>
Date:   Thu, 28 Nov 2019 10:57:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191126141346.GA22665@haolee.github.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2019 07:43 PM, Hao Lee wrote:
> As zone reclaim has been replaced by node reclaim, this patch fixes related
> comments.
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  include/linux/mmzone.h      | 2 +-
>  include/uapi/linux/sysctl.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9e47289a4511..7e3208f4f5bc 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -747,7 +747,7 @@ typedef struct pglist_data {
>  
>  #ifdef CONFIG_NUMA
>  	/*
> -	 * zone reclaim becomes active if more unmapped pages exist.
> +	 * node reclaim becomes active if more unmapped pages exist.
>  	 */
>  	unsigned long		min_unmapped_pages;
>  	unsigned long		min_slab_pages;
> diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
> index 87aa2a6d9125..27c1ed2822e6 100644
> --- a/include/uapi/linux/sysctl.h
> +++ b/include/uapi/linux/sysctl.h
> @@ -195,7 +195,7 @@ enum
>  	VM_MIN_UNMAPPED=32,	/* Set min percent of unmapped pages */
>  	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
>  	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
> -	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
> +	VM_MIN_SLAB=35,		 /* Percent pages ignored by node reclaim */
>  };

This looks good to me but wondering if this sort of change could qualify
for a stand alone patch or should be carried along with other functional
changes. Will leave it upto others to decide.

>  
>  
> 
