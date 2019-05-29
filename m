Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E226C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3094021019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfE2M65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:58:57 -0400
Received: from foss.arm.com ([217.140.101.70]:45536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2M65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:58:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D0C80D;
        Wed, 29 May 2019 05:58:56 -0700 (PDT)
Received: from [10.162.41.181] (p8cg001049571a15.blr.arm.com [10.162.41.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1BA63F59C;
        Wed, 29 May 2019 05:58:54 -0700 (PDT)
Subject: Re: [PATCH 0/4] arm64/mm: Fixes and cleanups for do_page_fault()
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
 <20190529124120.GF4485@fuggles.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e5834e61-d6ac-39cc-6cbf-70b80b841db0@arm.com>
Date:   Wed, 29 May 2019 18:29:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190529124120.GF4485@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2019 06:11 PM, Will Deacon wrote:
> Hi Anshuman,
> 
> On Wed, May 29, 2019 at 06:04:41PM +0530, Anshuman Khandual wrote:
>> This series contains some fixes and cleanups for page fault handling in
>> do_page_fault(). This has been boot tested on arm64 platform along with
>> some stress test but just build tested on others.
> 
> These all seem to be cleanups, which is fine, but I just wanted to make
> sure I'm not missing something that should be aiming for 5.2. Are there
> actually fixes in this series?

The following one might qualify (I would not insist though) but right now
this is not very problematic.

- arm64/mm: Drop mmap_sem before calling __do_kernel_fault() 

> 
> (in future, it's best to post fixes separately so I don't miss them)

Sure will do.
