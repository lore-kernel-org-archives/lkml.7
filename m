Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A7C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C2720645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfE1O0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:26:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:6133 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfE1O0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:26:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 07:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,523,1549958400"; 
   d="scan'208";a="179219799"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2019 07:26:17 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 77AC3580372;
        Tue, 28 May 2019 07:26:16 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] perf/x86: Disable non generic regs for
 software/probe events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, acme@redhat.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, jolsa@redhat.com, eranian@google.com
References: <1558984077-7773-1-git-send-email-kan.liang@linux.intel.com>
 <20190528085601.GL2623@hirez.programming.kicks-ass.net>
 <7c8d8998-4722-e059-d378-b8517193e32f@linux.intel.com>
 <20190528140518.GU2623@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <1151b99d-6e08-9943-346c-38dc1b32e15a@linux.intel.com>
Date:   Tue, 28 May 2019 10:26:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528140518.GU2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 10:05 AM, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 09:33:40AM -0400, Liang, Kan wrote:
>> Uncore PMU doesn't support sampling. It will return -EINVAL.
>> There is no regs support for counting. The request will be ignored.
>>
>> I think current check for uncore is good enough.
> 
> breakpoints then.. There's also no guarantee you covered all software
> events, and the core rewrite will allow other per-task/sampling PMUs
> too.
> 
> The approach you take is just not complete, don't do that.
> 

OK. I will send V3 base on your proposed patches.

Thanks,
Kan
