Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995B3C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601292075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfDPAbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:31:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:55614 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfDPAbC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:31:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 17:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,355,1549958400"; 
   d="scan'208";a="162215408"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.108]) ([10.239.196.108])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2019 17:31:00 -0700
Subject: Re: [PATCH v4 3/4] perf stat: Support 'percore' event qualifier
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
 <1555077590-27664-4-git-send-email-yao.jin@linux.intel.com>
 <bba8359b-7986-0938-16ea-9bc179ef76cb@linux.ibm.com>
 <20190415192623.GD11294@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d7141fd1-ea29-e6fc-6738-798c46b99d6b@linux.intel.com>
Date:   Tue, 16 Apr 2019 08:31:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415192623.GD11294@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/2019 3:26 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 15, 2019 at 08:09:09PM +0530, Ravi Bangoria escreveu:
>>
>>
>> On 4/12/19 7:29 PM, Jin Yao wrote:
>>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>>> index 39c05f8..1e312c2 100644
>>> --- a/tools/perf/Documentation/perf-stat.txt
>>> +++ b/tools/perf/Documentation/perf-stat.txt
>>> @@ -43,6 +43,10 @@ report::
>>>   	  param1 and param2 are defined as formats for the PMU in
>>>   	  /sys/bus/event_source/devices/<pmu>/format/*
>>>   
>>> +	  'percore' is a event qualifier that sums up the event counts for both
>>> +	  hardware threads in a core.
>>
>> s/both/all/  :
>>
>>    $ lscpu | grep Thread
>>    Thread(s) per core:    4
>>
>>
>> Apart from that, for the series:
>> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Yeah I had fixed up that already, fixed up the patch description this
> time around, "both" was being used there as well, changed to "all".
> 
> Thanks, added your Tested-by tag, appreciated.
> 
> - Arnaldo
> 

Thanks Ravi, Thanks Arnaldo!
