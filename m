Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFF7C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F52222CE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfKET75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:59:57 -0500
Received: from foss.arm.com ([217.140.110.172]:58398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfKET75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:59:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFEB14F2;
        Tue,  5 Nov 2019 11:59:56 -0800 (PST)
Received: from [10.162.40.121] (a075563-lin.blr.arm.com [10.162.40.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33DFF3FB40;
        Mon,  4 Nov 2019 23:02:20 -0800 (PST)
Subject: Re: [PATCHv2 1/8] ftrace: add ftrace_init_nop()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        James.Bottomley@HansenPartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-2-mark.rutland@arm.com>
 <daad0785-a33f-3cfb-cf0f-657b6c677257@arm.com>
 <20191104081136.645e9b1a@grimm.local.home>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <ca7dd81e-5d98-c0f6-3d84-4f2cc20f4676@arm.com>
Date:   Tue, 5 Nov 2019 12:29:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191104081136.645e9b1a@grimm.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/19 6:41 PM, Steven Rostedt wrote:
> On Sat, 2 Nov 2019 17:49:00 +0530
> Amit Daniel Kachhap <amit.kachhap@arm.com> wrote:
> 
>> Now that ftrace_init_nop is also an arch implemented function so it may
>> be added in Documentation/trace/ftrace-design.rst along with
>> ftrace_make_nop.
>> In general also, adding some description about patchable-function-entry
>> in kernel Documentation will be useful.
> 
> I think this part is outside the scope of this patch set. Honestly, I
> need to chisel out some time to rewrite the ftrace-design document, as
> that's been long needed. But that can come at a later time. I'm
> currently rewriting some of it now, so it will be best to not waste
> effort to update a document that will soon become stale. ;-)
Yes it makes sense.

Thanks,
Amit
> 
> -- Steve
> 
