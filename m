Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8041DC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637AB218CA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfGELQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:16:17 -0400
Received: from foss.arm.com ([217.140.110.172]:36334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbfGELQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:16:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070222B;
        Fri,  5 Jul 2019 04:16:16 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A6613F703;
        Fri,  5 Jul 2019 04:16:14 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
 <20190626073533.GA24199@infradead.org>
 <20190626123139.GB20635@lakrids.cambridge.arm.com>
 <20190626153829.GA22138@infradead.org> <20190626154532.GA3088@mellanox.com>
 <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
 <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org>
 <20190704195934.GA23542@mellanox.com>
 <de2286d9-6f5c-a79c-dcee-de4225aca58a@arm.com>
 <20190704141358.495791a385f7dd762cb749c2@linux-foundation.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <63abcc24-2b2d-b148-36bf-01dd730948c6@arm.com>
Date:   Fri, 5 Jul 2019 12:16:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190704141358.495791a385f7dd762cb749c2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2019 22:13, Andrew Morton wrote:
> On Thu, 4 Jul 2019 21:54:36 +0100 Robin Murphy <robin.murphy@arm.com> wrote:
> 
>>>> mm-clean-up-is_device__page-definitions.patch
>>>> mm-introduce-arch_has_pte_devmap.patch
>>>> arm64-mm-implement-pte_devmap-support.patch
>>>> arm64-mm-implement-pte_devmap-support-fix.patch
>>>
>>> This one we discussed, and I thought we agreed would go to your 'stage
>>> after linux-next' flow (see above). I think the conflict was minor
>>> here.
>>
>> I can rebase and resend tomorrow if there's an agreement on what exactly
>> to base it on - I'd really like to get this ticked off for 5.3 if at all
>> possible.
> 
> I took another look.  Yes, it looks like the repairs were simple.
> 
> Let me now try to compile all this...

Thanks, the revised patches look OK to me, and I've confirmed that 
today's -next builds and boots for arm64.

Cheers,
Robin.
