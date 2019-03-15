Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B133C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF952063F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCOXbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:31:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:37273 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCOXbR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:31:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 16:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="134471578"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.211.155]) ([10.254.211.155])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2019 16:31:14 -0700
Subject: Re: [PATCH v1 0/3] perf: Support a new coresum event qualifier
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
References: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
 <20190315133443.GA5200@krava>
 <1d1d6263-9842-7d44-8edb-dcfbb5a2e6cc@linux.intel.com>
 <20190315232609.GM24002@tassilo.jf.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <5e46a9a5-8d85-d14a-4ed2-87feb7ab95e1@linux.intel.com>
Date:   Sat, 16 Mar 2019 07:31:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190315232609.GM24002@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2019 7:26 AM, Andi Kleen wrote:
>> Yes, the coresum's behavior is similar as --per-core option, just supports
>> at the event level. I'm OK with calling it 'per-core'.
>>
>> For example,
>> perf stat -e cpu/event=0,umask=0x3,per-core=1/
> 
> Please use percore, the - would need to be escaped in metric expressions.
> 
> -Andi
> 

Oh, yes, thanks for reminding. Will use 'percore' in next version.

Thanks
Jin Yao
