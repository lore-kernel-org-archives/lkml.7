Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E507EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B4022CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbfHWMAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:00:47 -0400
Received: from foss.arm.com ([217.140.110.172]:33230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbfHWMAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:00:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9DB6337;
        Fri, 23 Aug 2019 05:00:45 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B17E73F246;
        Fri, 23 Aug 2019 05:00:44 -0700 (PDT)
Subject: Re: [RFC v4 00/18] objtool: Add support for arm64
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190822195627.mzi3c4sjqnvnzaho@treble>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <0493722d-2c6e-c91e-1f8e-7c6674b299c7@arm.com>
Date:   Fri, 23 Aug 2019 13:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822195627.mzi3c4sjqnvnzaho@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On 8/22/19 8:56 PM, Josh Poimboeuf wrote:
> On Fri, Aug 16, 2019 at 01:23:45PM +0100, Raphael Gault wrote:
>> Hi,
>>
>> Changes since RFC V3:
>> * Rebased on tip/master: Switch/jump table had been refactored
>> * Take Catalin Marinas comments into account regarding the asm macro for
>>    marking exceptions.
>>
>> As of now, objtool only supports the x86_64 architecture but the
>> groundwork has already been done in order to add support for other
>> architectures without too much effort.
>>
>> This series of patches adds support for the arm64 architecture
>> based on the Armv8.5 Architecture Reference Manual.
>>
>> Objtool will be a valuable tool to progress and provide more guarentees
>> on live patching which is a work in progress for arm64.
>>
>> Once we have the base of objtool working the next steps will be to
>> port Peter Z's uaccess validation for arm64.
> 
> Hi Raphael,
> 
> Sorry about the long delay.  I have some comments coming shortly.
> 
> One general comment: I noticed that several of the (mostly minor)
> suggested changes I made for v1 haven't been fixed.
> 
> I'll try to suggest them again here for v4, so you don't need to go back
> and find them.  But in the future please try to incorporate all the
> comments from previous patch sets before posting new versions.  I'm sure
> it wasn't intentional, as you did acknowledge and agree to most of the
> changes.  But it does waste people's time and goodwill if you neglect to
> incorporate their suggestions.  Thanks.
> 

Indeed, sorry about that.

Thanks for you comments, I will do my best to address them shortly. 
However, I won't have access to my professional emails for a little 
while and probably won't be able to work on this before at least a week. 
I'll try to have a new soon though and use my personal email.

Thanks,

-- 
Raphael Gault
