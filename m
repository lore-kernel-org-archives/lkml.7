Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D53C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557EB25981
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfE3NUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:20:18 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:10539 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726372AbfE3NUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:20:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TT0Pbqg_1559222413;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TT0Pbqg_1559222413)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 May 2019 21:20:14 +0800
Subject: Re: [PATCH 3/3] mm: shrinker: make shrinker not depend on memcg kmem
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559047464-59838-4-git-send-email-yang.shi@linux.alibaba.com>
 <20190530120820.l5crrblgybcii63f@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a19af445-8830-285c-2fbc-a5425ca06a6b@linux.alibaba.com>
Date:   Thu, 30 May 2019 21:20:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190530120820.l5crrblgybcii63f@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/19 8:08 PM, Kirill A. Shutemov wrote:
> On Tue, May 28, 2019 at 08:44:24PM +0800, Yang Shi wrote:
>> @@ -81,6 +79,7 @@ struct shrinker {
>>   /* Flags */
>>   #define SHRINKER_NUMA_AWARE	(1 << 0)
>>   #define SHRINKER_MEMCG_AWARE	(1 << 1)
>> +#define SHRINKER_NONSLAB	(1 << 3)
> Why 3?

My fault, it is a typo. Should be 2.

>

