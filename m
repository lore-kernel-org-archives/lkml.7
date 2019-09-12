Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF35C49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F2A2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfILCyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:54:10 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7222 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727576AbfILCyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:54:10 -0400
X-IronPort-AV: E=Sophos;i="5.64,495,1559491200"; 
   d="scan'208";a="75335186"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Sep 2019 10:54:08 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id A7D104CE14E8;
        Thu, 12 Sep 2019 10:53:55 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 12 Sep 2019 10:54:14 +0800
Subject: Re: [PATCH] mm/memblock: fix typo in memblock doc
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20190911030856.18010-1-caoj.fnst@cn.fujitsu.com>
 <20190911144230.GB6429@linux.ibm.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <59f571f6-785c-7f6e-fd03-5cfc76da27be@cn.fujitsu.com>
Date:   Thu, 12 Sep 2019 10:54:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911144230.GB6429@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: A7D104CE14E8.A8432
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 10:42 PM, Mike Rapoport wrote:
> On Wed, Sep 11, 2019 at 11:08:56AM +0800, Cao jin wrote:
>> elaboarte -> elaborate
>> architecure -> architecture
>> compltes -> completes
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  mm/memblock.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 7d4f61ae666a..0d0f92003d18 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -83,16 +83,16 @@
>>   * Note, that both API variants use implict assumptions about allowed
>>   * memory ranges and the fallback methods. Consult the documentation
>>   * of :c:func:`memblock_alloc_internal` and
>> - * :c:func:`memblock_alloc_range_nid` functions for more elaboarte
>> + * :c:func:`memblock_alloc_range_nid` functions for more elaborate
> 
> While on it, could you please replace the
> :c:func:`memblock_alloc_range_nid` construct with
> memblock_alloc_range_nid()?
> 
> And that would be really great to see all the :c:func:`foo` changed to
> foo().
> 

Sure. BTW, do you want convert all the markups too?

    :c:type:`foo` -> struct foo
    %FOO -> FOO
    ``foo`` -> foo
    **foo** -> foo

-- 
Sincerely,
Cao jin


