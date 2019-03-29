Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DA3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F07C2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iJkMOYRB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iJkMOYRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfC2N4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:56:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfC2N4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:56:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D954D60790; Fri, 29 Mar 2019 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553867763;
        bh=cnNB3qaJHM8BWoA+KLPu416FHg8Km0nQ8IFlokqnLFQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iJkMOYRB+0mbTBjFI1QThShFIy5Zyc53/U11ovPbnbc7xOB/8wVpQL/8G8nAkx4ZL
         J2DMcFvaHC6YsDCQ6Kzaw9oq+YFEMfkYaCOAiDcZKjb9vH/Iy8FbEbtkwOxCdzSxIq
         dKaG/t+NZ+rOMwb7dITbbBL7HSN6+B85ESzThgQc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B01A760735;
        Fri, 29 Mar 2019 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553867763;
        bh=cnNB3qaJHM8BWoA+KLPu416FHg8Km0nQ8IFlokqnLFQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iJkMOYRB+0mbTBjFI1QThShFIy5Zyc53/U11ovPbnbc7xOB/8wVpQL/8G8nAkx4ZL
         J2DMcFvaHC6YsDCQ6Kzaw9oq+YFEMfkYaCOAiDcZKjb9vH/Iy8FbEbtkwOxCdzSxIq
         dKaG/t+NZ+rOMwb7dITbbBL7HSN6+B85ESzThgQc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B01A760735
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v1] mm: balloon: drop unused function stubs
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>, linux-mm@kvack.org
References: <20190329122649.28404-1-david@redhat.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <931b7a25-94c9-5a13-423e-27ef41655603@codeaurora.org>
Date:   Fri, 29 Mar 2019 19:25:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329122649.28404-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 5:56 PM, David Hildenbrand wrote:
> These are leftovers from the pre-"general non-lru movable page" era.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/balloon_compaction.h | 15 ---------------
>   1 file changed, 15 deletions(-)


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

>
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index f111c780ef1d..f31521dcb09a 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -151,21 +151,6 @@ static inline void balloon_page_delete(struct page *page)
>   	list_del(&page->lru);
>   }
>   
> -static inline bool __is_movable_balloon_page(struct page *page)
> -{
> -	return false;
> -}
> -
> -static inline bool balloon_page_movable(struct page *page)
> -{
> -	return false;
> -}
> -
> -static inline bool isolated_balloon_page(struct page *page)
> -{
> -	return false;
> -}
> -
>   static inline bool balloon_page_isolate(struct page *page)
>   {
>   	return false;
