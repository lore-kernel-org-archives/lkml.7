Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49648C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200192070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfC0Lte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:49:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53306 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbfC0Lte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:49:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B9CA374;
        Wed, 27 Mar 2019 04:49:33 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0307E3F557;
        Wed, 27 Mar 2019 04:49:30 -0700 (PDT)
Subject: Re: [PATCH v7 9/10] KVM: arm64: docs: document KVM support of pointer
 authentication
To:     Dave Martin <Dave.Martin@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        linux-kernel@vger.kernel.org
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-10-git-send-email-amit.kachhap@arm.com>
 <23e4a9d4-e9e1-2c1f-32ce-e7fd96080437@arm.com>
 <20190327104428.GV3567@e103592.cambridge.arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <bdd480a4-44b3-7ddf-44f5-5b55e6251ced@arm.com>
Date:   Wed, 27 Mar 2019 17:19:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190327104428.GV3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/27/19 4:14 PM, Dave Martin wrote:
> On Mon, Mar 25, 2019 at 08:05:49PM +0000, Kristina Martsenko wrote:
>> On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
>>> This adds sections for KVM API extension for pointer authentication.
>>> A brief description about usage of pointer authentication for KVM guests
>>> is added in the arm64 documentations.
>>>
>>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: kvmarm@lists.cs.columbia.edu
>>
>> I think it makes sense to also update the Kconfig symbol description for
>> CONFIG_ARM64_PTR_AUTH, since it currently only mentions userspace
>> support, but now the option also enables KVM guest support.
>>
>> It's also worth mentioning that CONFIG_ARM64_VHE=y is required for guest
>> support.
> 
> Is it worth making this dependency explicit in Kconfig?
Currently there is discrepancy that userspace supports ptrauth in both 
nVHE/VHE mode and KVM guest only in VHE mode. I suppose adding explicit 
dependency flag here makes both of them similar.

Thanks,
Amit D
> 
> For SVE, I have
> 
> config ARM64_SVE
> 	depends on !KVM || ARM64_VHE
> 
> to implement this.
> 
> Cheers
> ---Dave
> 
