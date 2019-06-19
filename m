Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18984C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3712085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfFSVPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:15:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:47171 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfFSVPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:15:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 14:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="182863442"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2019 14:15:35 -0700
Received: from [10.254.89.31] (kliang2-mobl.ccr.corp.intel.com [10.254.89.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2880658088A;
        Wed, 19 Jun 2019 14:15:34 -0700 (PDT)
Subject: Re: WARNING in perf_reg_value
To:     Vince Weaver <vincent.weaver@maine.edu>,
        syzbot <syzbot+10189b9b0f8c4664badd@syzkaller.appspotmail.com>
Cc:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de,
        eranian@google.com, hpa@zytor.com, jolsa@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, x86@kernel.org
References: <000000000000734545058bb27ebb@google.com>
 <alpine.DEB.2.21.1906191605380.10498@macbook-air>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8ec677d7-f891-1c8b-33bd-16506974fafb@linux.intel.com>
Date:   Wed, 19 Jun 2019 17:15:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906191605380.10498@macbook-air>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2019 4:07 PM, Vince Weaver wrote:
> On Wed, 19 Jun 2019, syzbot wrote:
> 
>> syzbot found the following crash on:
>>
>> HEAD commit:    0011572c Merge branch 'for-5.2-fixes' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12c38d66a00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
>> dashboard link: https://syzkaller.appspot.com/bug?extid=10189b9b0f8c4664badd
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1434b876a00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e6c876a00000
> 
> the perf_fuzzer found this issue about a month ago, and patches were
> posted that fixed the issue (I've been unable to reproduce when running
> with a patched kernel).

Here are the patches posted.
https://lkml.org/lkml/2019/5/28/1022

Thanks,
Kan

> 
> Any reason they haven't been applied?
> 
> Vince
> 
