Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5050C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A468220730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfKOQVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:21:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:29366 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfKOQVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:21:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 08:21:06 -0800
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="195434252"
Received: from tzanussi-mobl.amr.corp.intel.com (HELO [10.252.195.108]) ([10.252.195.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 15 Nov 2019 08:21:06 -0800
Subject: Re: [PATCH] trace/synthetic_events: increase SYNTH_FIELDS_MAX
To:     Steven Rostedt <rostedt@goodmis.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20191115091730.9192-1-dedekind1@gmail.com>
 <20191115105227.341c238e@gandalf.local.home>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <8751ffdd-ea8c-4aa5-663d-0d7d0fd0886d@linux.intel.com>
Date:   Fri, 15 Nov 2019 10:21:05 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191115105227.341c238e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve and Artem,

On 11/15/2019 9:52 AM, Steven Rostedt wrote:
> On Fri, 15 Nov 2019 11:17:30 +0200
> Artem Bityutskiy <dedekind1@gmail.com> wrote:
> 
>> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>>
>> Increase the maximum allowed count of synthetic event fields from 16 to 32
>> in order to allow for larger-than-usual events.
> 
> I'm fine with this, Tom are you OK with it?

Yeah, looks good to me.  Thanks for the patch, Artem.

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Tom

> 
> -- Steve
> 
>>
>> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>> ---
>>   kernel/trace/trace_events_hist.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
>> index 7482a1466ebf..f49d1a36d3ae 100644
>> --- a/kernel/trace/trace_events_hist.c
>> +++ b/kernel/trace/trace_events_hist.c
>> @@ -23,7 +23,7 @@
>>   #include "trace_dynevent.h"
>>   
>>   #define SYNTH_SYSTEM		"synthetic"
>> -#define SYNTH_FIELDS_MAX	16
>> +#define SYNTH_FIELDS_MAX	32
>>   
>>   #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
>>   
> 
