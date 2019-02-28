Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBEDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B8D218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbfB1UTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:19:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:14293 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbfB1UTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:19:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 12:19:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="130185066"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2019 12:19:48 -0800
Received: from [10.251.86.205] (abudanko-mobl.ccr.corp.intel.com [10.251.86.205])
        by linux.intel.com (Postfix) with ESMTP id EDB195805B4;
        Thu, 28 Feb 2019 12:19:45 -0800 (PST)
Subject: Re: [PATCH v4 02/10] perf record: implement
 -f,--mmap-flush=<threshold> option
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
 <4abe0a4f-a0a9-f8e2-d2d1-e24846de15c9@linux.intel.com>
 <20190228184445.GE9508@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ec3bb670-9af9-e974-e260-8e22c7f7d116@linux.intel.com>
Date:   Thu, 28 Feb 2019 23:19:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228184445.GE9508@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.02.2019 21:44, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 28, 2019 at 12:00:41PM +0300, Alexey Budankov escreveu:
>>
>> Implemented -f,--mmap-flush option that specifies threshold to postpone
>> and/or trigger the move of data from mmaped kernel buffers to a storage.
>> The option can be used to avoid capturing every single byte of data into
>> the stored trace. The default option value is 1.
> 
> Can you add something here explain more clearly what this means, and
> also on the tools/perf/Documentation/perf-record.txt file? Something
> like a paragraph explaining when is that there is a mmap flush normally,
> or rephrase what you wrote if you think you said that.

Will try to rephrase and may be provide some description of 
cases that this option can specifically address.

Thanks,
Alexey

> 
> - Arnaldo
> 
>  
<SNIP>
