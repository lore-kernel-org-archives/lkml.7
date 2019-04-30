Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2188C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA54C21734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfD3PqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:46:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:25343 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfD3PqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:46:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 08:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="295838005"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 30 Apr 2019 08:46:20 -0700
Received: from [10.254.90.156] (kliang2-mobl.ccr.corp.intel.com [10.254.90.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B145C580372;
        Tue, 30 Apr 2019 08:46:19 -0700 (PDT)
Subject: Re: [PATCH 3/4] perf cgroup: Add cgroup ID as a key of RB tree
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, tj@kernel.org, ak@linux.intel.com
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-4-git-send-email-kan.liang@linux.intel.com>
 <20190430090318.GK2623@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <11b8069a-f8e9-6246-3e49-1f7118f4377d@linux.intel.com>
Date:   Tue, 30 Apr 2019 11:46:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430090318.GK2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2019 5:03 AM, Peter Zijlstra wrote:
> On Mon, Apr 29, 2019 at 07:44:04AM -0700, kan.liang@linux.intel.com wrote:
> 
>> Add unique cgrp_id for each cgroup, which is composed by CPU ID and css
>> subsys-unique ID.
> 
> *WHY* ?! that doesn't make any kind of sense.. In fact you mostly then
> use the low word because most everything is already per CPU.
> 

I tried to assign an unique ID for each cgroup event.
But you are right, it looks like not necessary.
I will remove it.

Thanks,
Kan
