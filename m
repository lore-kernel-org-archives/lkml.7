Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD9CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B3F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbfJ2Pcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:32:45 -0400
Received: from foss.arm.com ([217.140.110.172]:53424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389319AbfJ2Pco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:32:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 385511F1;
        Tue, 29 Oct 2019 08:32:44 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B1733F71F;
        Tue, 29 Oct 2019 08:32:43 -0700 (PDT)
Subject: Re: [PATCH] arm64: cpufeature: Export Armv8.6 Matrix feature to
 userspace
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Dave.Martin@arm.com
References: <20191025171056.30641-1-julien.grall@arm.com>
 <20191029111517.GE11590@willie-the-truck>
 <f58cb01f-4543-6041-df2d-7ca7ba887bc9@arm.com>
 <20191029113606.GB12103@willie-the-truck>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <6f175c28-1ac0-3da0-bbfa-a811a4adfed7@arm.com>
Date:   Tue, 29 Oct 2019 15:32:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029113606.GB12103@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 29/10/2019 11:36, Will Deacon wrote:
> On Tue, Oct 29, 2019 at 11:26:41AM +0000, Julien Grall wrote:
>> On 29/10/2019 11:15, Will Deacon wrote:
>>> On Fri, Oct 25, 2019 at 06:10:56PM +0100, Julien Grall wrote:
>>>> This patch provides support for reporting the presence of Armv8.6
>>>> Matrix and its optional features to userspace.
>>>
>>> Are you sure this is 8.6 and not earlier?
>>
>> This was introduced by Armv8.6 see [1] but allowed to be used by Armv8.2 and
>> onwards.
> 
> That doesn't mean an awful lot though, especially then the features are
> referred to in the docs as things like "ARMv8.2-F64MM".

It is arguable. The feature were announced for Armv8.6 but made available for 
previous release.

Anyway, I can remove the "Armv8.6" bits if that's the concern.

Cheers,

-- 
Julien Grall
