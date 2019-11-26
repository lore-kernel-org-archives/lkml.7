Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80296C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C44C2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfKZRiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:38:14 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41624 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727826AbfKZRiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:38:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tj9oAor_1574789888;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tj9oAor_1574789888)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Nov 2019 01:38:10 +0800
Subject: Re: [PATCH] mm: khugepaged: add trace status description for
 SCAN_PAGE_HAS_PRIVATE
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        songliubraving@fb.com, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1574706428-36212-1-git-send-email-yang.shi@linux.alibaba.com>
 <729623eb-df56-c436-2ca3-8f73772f539c@arm.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <e0244439-88f2-6f9b-a64e-3454951c6d32@linux.alibaba.com>
Date:   Tue, 26 Nov 2019 09:38:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <729623eb-df56-c436-2ca3-8f73772f539c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/19 12:57 AM, Anshuman Khandual wrote:
>
> On 11/25/2019 11:57 PM, Yang Shi wrote:
>> The commit 99cb0dbd47a15d395bf3faa78dc122bc5efe3fc0 ("mm,thp: add
> Reduce the commit SHA ID here to just 12 digits instead ?

Yes, sure.

>
>> read-only THP support for (non-shmem) FS") instroduced a new khugepaged
> s/instroduced/introduced/

Will fix.

>
>> scan result: SCAN_PAGE_HAS_PRIVATE, but the corresponding description
>> for trance events were not added.
> s/trance/trace/

My fat finger :-(

>
>> Cc: Song Liu <songliubraving@fb.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   include/trace/events/huge_memory.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
>> index dd4db33..d49fbce 100644
>> --- a/include/trace/events/huge_memory.h
>> +++ b/include/trace/events/huge_memory.h
>> @@ -31,7 +31,8 @@
>>   	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
>>   	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
>>   	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
>> -	EMe(SCAN_TRUNCATED,		"truncated")			\
>> +	EM( SCAN_TRUNCATED,		"truncated")			\
>> +	EMe(SCAN_PAGE_HAS_PRIVATE,	"has_private")			\
> Majority of the SCAN_PAGE_* scan results have page_ in the front. Hence we
> should just follow same pattern here and make it 'page_has_private' instead.

Some do start with "page_", anyway either is fine to me.

>
>>   
>>   #undef EM
>>   #undef EMe
>>

