Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C11BC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649CF2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfHPBYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:24:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:51063 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHPBYy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:24:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 18:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="171276632"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.32]) ([10.239.196.32])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2019 18:24:52 -0700
Subject: Re: [PATCH v4] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190813073037.3420-1-yao.jin@linux.intel.com>
 <20190815132302.GI30356@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <99d40f03-f438-d78d-992d-02a91974c4d5@linux.intel.com>
Date:   Fri, 16 Aug 2019 09:24:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815132302.GI30356@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2019 9:23 PM, Jiri Olsa wrote:
> On Tue, Aug 13, 2019 at 03:30:37PM +0800, Jin Yao wrote:
>> This patch prints the stddev and hist for the cycles diff of
>> program block. It can help us to understand if the cycles
>> is noisy or not.
>>
>> This patch is inspired by Andi Kleen's patch
>> https://lwn.net/Articles/600471/
> 
> now that we have sparks support, we could respin it ;-)
> 
> jirka
> 

The sparks can be used in more places for reporting the data noisy. :)

Thanks
Jin Yao
