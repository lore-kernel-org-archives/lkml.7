Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF25C04AB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B1720840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YFPe9L12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfFGAoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 20:44:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15867 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFGAoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:44:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf9b35e0000>; Thu, 06 Jun 2019 17:44:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 17:44:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 17:44:16 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 00:44:16 +0000
Subject: Re: [PATCH 2/5] mm/hmm: Clean up some coding style and comments
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-3-rcampbell@nvidia.com>
 <20190606155719.GA8896@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <3a91e9a7-e533-863b-ee5f-c34f1e10433c@nvidia.com>
Date:   Thu, 6 Jun 2019 17:44:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606155719.GA8896@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559868254; bh=+Mit/5a+rC2Wlxiu6u6imSr0LN6DP+ltnocf5OY9+X8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YFPe9L12IwlVFW/uqZXMuLBzFKRY4kU3BNWs7W76LnhmesrNFPJru/HQ0xy/VzFq7
         iFqW/b8g6EGJGXC3ipAcfMEEgdVqJ+2B5Qrod5NcuYzHnGO2makj85RecVap7Qahsq
         BGrWOKjjUAkZ9dSKp0uN3V8bf9uCsZsafyvSRsDFxFbttruxdRiTJU0P0vlCIES0Jy
         UoY9M63J7l2A0EenhMJegmbfcEg45stvVce39dcwAUUokWhazrFOCWYNSymbJwfZMD
         dh2Q/lRs3T5Mp7NDJS/TJOPEhmq8AGBKL4clWVFq1oVY9AUEPnTAWftTnLu646cdCo
         uu6whBYo7fVGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/19 8:57 AM, Jason Gunthorpe wrote:
> On Mon, May 06, 2019 at 04:29:39PM -0700, rcampbell@nvidia.com wrote:
>> @@ -924,6 +922,7 @@ int hmm_range_register(struct hmm_range *range,
>>   		       unsigned page_shift)
>>   {
>>   	unsigned long mask = ((1UL << page_shift) - 1UL);
>> +	struct hmm *hmm;
>>   
>>   	range->valid = false;
>>   	range->hmm = NULL;
> 
> I was finishing these patches off and noticed that 'hmm' above is
> never initialized.
> 
> I added the below to this patch:
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 678873eb21930a..8e7403f081f44a 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -932,19 +932,20 @@ int hmm_range_register(struct hmm_range *range,
>   	range->start = start;
>   	range->end = end;
>   
> -	range->hmm = hmm_get_or_create(mm);
> -	if (!range->hmm)
> +	hmm = hmm_get_or_create(mm);
> +	if (!hmm)
>   		return -EFAULT;
>   
>   	/* Check if hmm_mm_destroy() was call. */
> -	if (range->hmm->mm == NULL || range->hmm->dead) {
> -		hmm_put(range->hmm);
> +	if (hmm->mm == NULL || hmm->dead) {
> +		hmm_put(hmm);
>   		return -EFAULT;
>   	}
>   
>   	/* Initialize range to track CPU page table updates. */
> -	mutex_lock(&range->hmm->lock);
> +	mutex_lock(&hmm->lock);
>   
> +	range->hmm = hmm;
>   	list_add_rcu(&range->list, &hmm->ranges);
>   
>   	/*
> 
> Which I think was the intent of adding the 'struct hmm *'. I prefer
> this arrangement as it does not set an leave an invalid hmm pointer in
> the range if there is a failure..
> 
> Most probably the later patches fixed this up?
> 
> Please confirm, thanks
> 
> Regards,
> Jason
> 

Yes, you understand correctly. That was the intended clean up.
I must have split my original patch set incorrectly.
