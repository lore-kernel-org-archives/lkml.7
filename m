Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958CDC5B578
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F06208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfF1Do1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:44:27 -0400
Received: from foss.arm.com ([217.140.110.172]:39698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfF1DoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:44:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC1A92B;
        Thu, 27 Jun 2019 20:44:24 -0700 (PDT)
Received: from [10.162.40.144] (p8cg001049571a15.blr.arm.com [10.162.40.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BE923F706;
        Thu, 27 Jun 2019 20:44:20 -0700 (PDT)
Subject: Re: [PATCH] powerpc/64s/radix: Define arch_ioremap_p4d_supported()
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
References: <1561555260-17335-1-git-send-email-anshuman.khandual@arm.com>
 <87d0iztz0f.fsf@concordia.ellerman.id.au>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6d201cb8-4c39-b7ea-84e6-f84607cc8b4f@arm.com>
Date:   Fri, 28 Jun 2019 09:14:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87d0iztz0f.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2019 10:18 AM, Michael Ellerman wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>> Recent core ioremap changes require HAVE_ARCH_HUGE_VMAP subscribing archs
>> provide arch_ioremap_p4d_supported() failing which will result in a build
>> failure like the following.
>>
>> ld: lib/ioremap.o: in function `.ioremap_huge_init':
>> ioremap.c:(.init.text+0x3c): undefined reference to
>> `.arch_ioremap_p4d_supported'
>>
>> This defines a stub implementation for arch_ioremap_p4d_supported() keeping
>> it disabled for now to fix the build problem.
> 
> The easiest option is for this to be folded into your patch that creates
> the requirement for arch_ioremap_p4d_supported().
> 
> Andrew might do that for you, or you could send a v2.
> 
> This looks fine from a powerpc POV:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> cheers

Hello Stephen/Michael/Andrew,

On linux-next (next-20190627) this change has already been applied though a
merge commit 153083a99fe431 ("Merge branch 'akpm-current/current'"). So we
are good on this ? Or shall I send out a V2 for the original patch. Please
suggest. Thank you.

- Anshuman
