Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EDEC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EB520811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WhcgmAeA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FUxNFofr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfC2Kkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:40:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfC2Kkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7FBEB608FC; Fri, 29 Mar 2019 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553856051;
        bh=6UJq9H0yEsYd4R3+jgGK+moeeQ9mNyIzO2VgN16P4jY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WhcgmAeAnZz3C7CB+VmrjQ8m3NAZiyNsaIcraLxp6ILqvOkOMv25Fb4E/M+CkLMGu
         FqRgMMUYAcC94cxAzLeOuW76OwSW5+7Eh7tzFPqHC0MUDOl6laC00uc90P4/4/MSlN
         dTr0BbzHbKZkd9K8JFUH4jwHC4MIuhxkj3rGeI3Y=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12D8060237;
        Fri, 29 Mar 2019 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553856050;
        bh=6UJq9H0yEsYd4R3+jgGK+moeeQ9mNyIzO2VgN16P4jY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FUxNFofrBoBRI4jRCz0ejj8mWMH2UTW9p9rtjXXMxXRH5HaXvujViOhIguMQ34U5S
         jchS215FqJt+hNpohVdWo//mQqHdfEhIvObgIaFcnPRnP87pbjFnWIi5PIOgwwgSlb
         9oX43OCtJ4BlCvXicGVeKQUNy0g7ptMlHY8ry7fw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12D8060237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3 1/2] mm/sparse: Clean up the obsolete code comment
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, rafael@kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, osalvador@suse.de, rppt@linux.ibm.com,
        willy@infradead.org, fanc.fnst@cn.fujitsu.com
References: <20190329082915.19763-1-bhe@redhat.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1a1ff1d0-3bfa-4f06-1534-c49c63a8b58d@codeaurora.org>
Date:   Fri, 29 Mar 2019 16:10:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329082915.19763-1-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 1:59 PM, Baoquan He wrote:
> The code comment above sparse_add_one_section() is obsolete and
> incorrect, clean it up and write new one.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
> v2->v3:
>    Normalize the code comment to use '/**' at 1st line of doc
>    above function.
> v1-v2:
>    Add comments to explain what the returned value means for
>    each error code.
>   mm/sparse.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 69904aa6165b..363f9d31b511 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -684,10 +684,19 @@ static void free_map_bootmem(struct page *memmap)
>   #endif /* CONFIG_MEMORY_HOTREMOVE */
>   #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>   
> -/*
> - * returns the number of sections whose mem_maps were properly
> - * set.  If this is <=0, then that means that the passed-in
> - * map was not consumed and must be freed.
> +/**
> + * sparse_add_one_section - add a memory section
> + * @nid: The node to add section on
> + * @start_pfn: start pfn of the memory range
> + * @altmap: device page map
> + *
> + * This is only intended for hotplug.
> + *
> + * Returns:
> + *   0 on success.
> + *   Other error code on failure:
> + *     - -EEXIST - section has been present.
> + *     - -ENOMEM - out of memory.
>    */
>   int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>   				     struct vmem_altmap *altmap)
