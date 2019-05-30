Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B1C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AF025AA0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfE3OVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:21:49 -0400
Received: from foss.arm.com ([217.140.101.70]:37432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3OVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:21:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B323A78;
        Thu, 30 May 2019 07:21:48 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9C853F59C;
        Thu, 30 May 2019 07:21:47 -0700 (PDT)
Subject: Re: [PATCH 2/3] x86/vdso: Allow clock specific mult and shift values
To:     Huw Davies <huw@codeweavers.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20190411101205.10006-1-huw@codeweavers.com>
 <20190411101205.10006-3-huw@codeweavers.com>
 <alpine.DEB.2.21.1904141229380.4917@nanos.tec.linutronix.de>
 <20190415093042.GA21726@merlot.physics.ox.ac.uk>
 <alpine.DEB.2.21.1904151148160.17231@nanos.tec.linutronix.de>
 <82a61daf-f6f9-8be0-2157-e9f9d7ba1cdf@arm.com>
 <20190415121431.GA22003@merlot.physics.ox.ac.uk>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d7fd1ac4-c0fc-7d6c-ff7d-38079e65a1f0@arm.com>
Date:   Thu, 30 May 2019 15:21:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415121431.GA22003@merlot.physics.ox.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huw,

On 15/04/2019 13:14, Huw Davies wrote:
> On Mon, Apr 15, 2019 at 11:15:56AM +0100, Vincenzo Frascino wrote:
>> On 15/04/2019 10:51, Thomas Gleixner wrote:
>>> On Mon, 15 Apr 2019, Huw Davies wrote:
>>>> On Sun, Apr 14, 2019 at 12:53:32PM +0200, Thomas Gleixner wrote:
>>>>> See https://lkml.kernel.org/r/alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de
>>>>> for an alternate solution to this problem, which avoids this and just gives
>>>>> CLOCK_MONOTONIC_RAW a separate storage space alltogether.
>>>>
>>>> I can certainly do this for the x86 vdso.  Would that be useful or
>>>> should I wait for Vincenzo's work on the generic vdso first?
>>>
>>> Depends. If Vincenzo comes along with his new version soon, then you might
>>> get this for free :)
>>>
>>> Vincenzo, what's the state of your work?
>>>
>>
>> I am mostly done with the development, the only thing missing is the integration
>> of the generic update_vsyscall. After this is complete, I will need to do some
>> testing and extract the performance numbers.
>>
>> Considering that I will be on Easter holiday from this Wednesday till the end of
>> April, I think v6 will be ready around second week of May.
> 
> Hi Vincenzo,
> 
> Great!  In which case there's not much point in me changing the x86
> vdso---it'll just end up making more work for you.
> 
> Let me know if there's anything I can help with.
> 

I wanted to let you know that I just posted my updated patchset for unifying
vdso. I should have tested it enough (I hope :) ), but if your help offer is
still valid, and you want to give it a go, you are more than welcome.

Please let me know if you find any issue.

> Huw.
> 

-- 
Regards,
Vincenzo
