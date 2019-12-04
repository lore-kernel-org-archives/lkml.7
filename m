Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D8FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076542073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfLDTrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:47:20 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:33266 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbfLDTrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:47:20 -0500
Subject: Re: UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
To:     Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <02f44ed5-13ac-f9c6-1f35-129c41006900@linux.ee>
 <20191202170633.GN2844@hirez.programming.kicks-ass.net>
 <0676c6ec-4475-62dc-b202-a62deaedd2dd@linux.ee>
 <20191204121540.GE20746@krava>
 <20191204150656.GX2844@hirez.programming.kicks-ass.net>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <4ee9ffee-4f04-dec0-c4e8-244993eb8111@linux.ee>
Date:   Wed, 4 Dec 2019 21:47:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204150656.GX2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.12.19 17:06 Peter Zijlstra wrote:
> On Wed, Dec 04, 2019 at 01:15:40PM +0100, Jiri Olsa wrote:
>> On Tue, Dec 03, 2019 at 03:39:49PM +0200, Meelis Roos wrote:
>>>> Does something like so fix it?
>>>
>>> Unfortunately not (tested on top of todays git):
>>
>> hi,
>> which p6 model are you seeing this on?
>> how do you trigger that?
> 
> Triggers on any p6 model. I hacked up perf and used "qemu-system-x86_64
> -cpu pentium2".
> 
> The below seems to cure things.

Yes, works for me on Pentium M. The UBSAN warning is gone and everything seems to work as before.

Thank you!

-- 
Meelis Roos <mroos@linux.ee>
