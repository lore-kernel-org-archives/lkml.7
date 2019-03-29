Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580E320693
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CnIIlDxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfC2Jkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:40:52 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:25957 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfC2Jkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1553852450; x=1585388450;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UqD7KQpC2Q6OSONr0aK3ErBm2UEDd0xfy6kjO3kwT50=;
  b=CnIIlDxN11oUpb6D35jtkXajhfbH7UC3BMumeJxkrp6U+fkFcp/ubIP/
   jPCnzW+SBgtUhOYBKdPY/p6CEgR8ZPSYFyVKZt9eCRaHgfWUHvbdzXxSD
   pjyN8x5EwoSqj11CWdpFvZQqyYAAFy5VUGPnZ4eJJEWO+ZIKYmnb2Ykuo
   k=;
X-IronPort-AV: E=Sophos;i="5.60,284,1549929600"; 
   d="scan'208";a="393629002"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Mar 2019 09:40:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2T9ejNO116429
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 29 Mar 2019 09:40:48 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Mar 2019 09:40:47 +0000
Received: from [10.95.75.73] (10.43.162.118) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 29 Mar
 2019 09:40:44 +0000
Subject: Re: [PATCH] lib/scatterlist: Remove leftover from sg_page_iter
 comment
To:     Mukesh Ojha <mojha@codeaurora.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@mellanox.com>
References: <1553800491-28583-1-git-send-email-galpress@amazon.com>
 <8e313491-8859-d47f-f104-6d2d783cd63a@codeaurora.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a232e623-b998-0d67-68ac-4e38ea9c4709@amazon.com>
Date:   Fri, 29 Mar 2019 12:40:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <8e313491-8859-d47f-f104-6d2d783cd63a@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.118]
X-ClientProxiedBy: EX13D17UWB001.ant.amazon.com (10.43.161.252) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-Mar-19 11:36, Mukesh Ojha wrote:
> 
> On 3/29/2019 12:44 AM, Gal Pressman wrote:
>> Commit d901b2760dc6 ("lib/scatterlist: Provide a DMA page iterator")
>> added the sg DMA iterator but a leftover remained in the sg_page_iter
>> documentation, remove it.
>>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>>   include/linux/scatterlist.h | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
>> index b4be960c7e5d..30a9a55c28ba 100644
>> --- a/include/linux/scatterlist.h
>> +++ b/include/linux/scatterlist.h
>> @@ -340,11 +340,11 @@ int sg_alloc_table_chained(struct sg_table *table, int
>> nents,
>>    * sg page iterator
>>    *
>>    * Iterates over sg entries page-by-page.  On each successful iteration, you
>> - * can call sg_page_iter_page(@piter) to get the current page and its dma
>> - * address.
> 
> 
> It took me a while till i exact found what you meant by left over.
> 
> could have been more specific in the commit,but
> 
> Looks  good to me to be removed.
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

You're right, should've been more specific.
Should I resubmit?

> 
> -Mukesh
> 
> 
>>   @piter->sg will point to the sg holding this page and
>> - * @piter->sg_pgoffset to the page's page offset within the sg. The iteration
>> - * will stop either when a maximum number of sg entries was reached or a
>> - * terminating sg (sg_last(sg) == true) was reached.
>> + * can call sg_page_iter_page(@piter) to get the current page.
>> + * @piter->sg will point to the sg holding this page and @piter->sg_pgoffset to
>> + * the page's page offset within the sg. The iteration will stop either when a
>> + * maximum number of sg entries was reached or a terminating sg
>> + * (sg_last(sg) == true) was reached.
>>    */
>>   struct sg_page_iter {
>>       struct scatterlist    *sg;        /* sg holding the page */
