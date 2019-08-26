Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14224C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDBD2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbfHZOZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:25:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:12659 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbfHZOZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:25:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 07:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="379669787"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2019 07:25:10 -0700
Received: from [10.251.95.75] (abudanko-mobl.ccr.corp.intel.com [10.251.95.75])
        by linux.intel.com (Postfix) with ESMTP id F1E3A5800BD;
        Mon, 26 Aug 2019 07:25:04 -0700 (PDT)
Subject: Re: BoF on LPC 2019 : Linux Perf advancements for compute intensive
 and server systems
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        "Jin, Yao" <yao.jin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jonatan Corbet <corbet@lwn.net>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <43216530-4410-6cc4-aa4a-51fa7e7c1b0c@linux.intel.com>
 <20190826135536.GA24801@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <da687997-6280-2613-a389-f7b94c600c2b@linux.intel.com>
Date:   Mon, 26 Aug 2019 17:25:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826135536.GA24801@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26.08.2019 16:55, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 26, 2019 at 02:36:48PM +0300, Alexey Budankov escreveu:
>>
>> Hi,
>>
>> There is a BoF session scheduled on Linux Plumbers Conference 2019 event.
>> If you plan attend the event feel free to join and discuss about the BoF 
>> topic and beyond:
>>
>> Linux Perf advancements for compute intensive and server systems:

<SNIP>

> 
> All those are already merged, after long reviewing phases and lots of
> testing, right?

Right. These changes now constitute parts of the Linux kernel source tree.

~Alexey

> 
> I think the next step for people working in this area, in preparation
> for this BoF, is to list what are their current efforts, like Ian et all
> did in:
> 
>   https://linuxplumbersconf.org/event/4/contributions/291/
> 
> - Arnaldo
>  
>> Best regards,
>> Alexey
>>
>> [1] https://marc.info/?l=linux-kernel&m=154149439404555&w=2
>> [2] https://marc.info/?l=linux-kernel&m=154817912621465&w=2
>> [3] https://marc.info/?l=linux-kernel&m=155293062518459&w=2
>> [4] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> 
