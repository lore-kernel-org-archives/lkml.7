Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E08C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9758F20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="frkBLgvm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gPTr+dtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfC2Knl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:43:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfC2Knk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:43:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C8A1C60AA3; Fri, 29 Mar 2019 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553856219;
        bh=llaMkjdyBdsEZbV7SmieM0AVvKTgsZ3IEIReE0vnbNU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=frkBLgvmcVdrmO11L6fHF85mHsyNCRtZdzSmodmeJ5o9Uf0aAxeWsOrYsCe9+tTRR
         9oBT9oCuNgSFMhrg2AWs62PBZPTgPpXeOGtT21vbEt6cUcUdPk5NpXZath//i/RQFV
         mhy5fnaD5w1mOHbWLVEcFQwfvKUWM8phbmWmL4Hc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3AE0608CC;
        Fri, 29 Mar 2019 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553856215;
        bh=llaMkjdyBdsEZbV7SmieM0AVvKTgsZ3IEIReE0vnbNU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gPTr+dtCIr2NUcXjeoHgxRysKE60tI7EJ8q2W9F90xWGIhU7G89CRI2xWh/huk0lX
         qI0HG98Y99V47Ght1sJRfE+dZphqbuvIyZkidPLUWpzenWLRA20irm1WlMjKJXd4Oc
         XTTM+jb4FXU3c0KGBplaF37asK09qwK1Lh3oyawc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3AE0608CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v4 2/2] drivers/base/memory.c: Rename the misleading
 parameter
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, rafael@kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, osalvador@suse.de, rppt@linux.ibm.com,
        willy@infradead.org, fanc.fnst@cn.fujitsu.com
References: <20190329082915.19763-1-bhe@redhat.com>
 <20190329082915.19763-2-bhe@redhat.com>
 <20190329093659.GG7627@MiWiFi-R3L-srv>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <029aac79-37d6-c118-b2b4-f536d0368d60@codeaurora.org>
Date:   Fri, 29 Mar 2019 16:13:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329093659.GG7627@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 3:06 PM, Baoquan He wrote:
> The input parameter 'phys_index' of memory_block_action() is actually
> the section number, but not the phys_index of memory_block. This is
> a relict from the past when one memory block could only contain one
> section.
>
> Rename it to start_section_nr.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/base/memory.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index cb8347500ce2..9ea972b2ae79 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -231,13 +231,14 @@ static bool pages_correctly_probed(unsigned long start_pfn)
>    * OK to have direct references to sparsemem variables in here.
>    */
>   static int
> -memory_block_action(unsigned long phys_index, unsigned long action, int online_type)
> +memory_block_action(unsigned long start_section_nr, unsigned long action,
> +		    int online_type)
>   {
>   	unsigned long start_pfn;
>   	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>   	int ret;
>   
> -	start_pfn = section_nr_to_pfn(phys_index);
> +	start_pfn = section_nr_to_pfn(start_section_nr);
>   
>   	switch (action) {
>   	case MEM_ONLINE:
> @@ -251,7 +252,7 @@ memory_block_action(unsigned long phys_index, unsigned long action, int online_t
>   		break;
>   	default:
>   		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
> -		     "%ld\n", __func__, phys_index, action, action);
> +		     "%ld\n", __func__, start_section_nr, action, action);
>   		ret = -EINVAL;
>   	}
>   
