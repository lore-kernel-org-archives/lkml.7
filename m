Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF1FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1027E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392699AbfFMQqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:46:13 -0400
Received: from foss.arm.com ([217.140.110.172]:34580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730311AbfFMFhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 01:37:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C1A428;
        Wed, 12 Jun 2019 22:37:15 -0700 (PDT)
Received: from [10.162.40.191] (p8cg001049571a15.blr.arm.com [10.162.40.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB5673F73C;
        Wed, 12 Jun 2019 22:37:11 -0700 (PDT)
Subject: Re: [PATCH V5 - Rebased] mm/hotplug: Reorder memblock_[free|remove]()
 calls in try_remove_memory()
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@arm.com, osalvador@suse.de,
        mhocko@suse.com, mark.rutland@arm.com
References: <36e0126f-e2d1-239c-71f3-91125a49e019@redhat.com>
 <1560252373-3230-1-git-send-email-anshuman.khandual@arm.com>
 <20190611151908.cdd6b73fd17fda09b1b3b65b@linux-foundation.org>
 <5b4f1f19-2f8d-9b8f-4240-7b728952b6fe@arm.com>
 <67f5c5ad-d753-77d8-8746-96cf4746b3e0@redhat.com>
 <20190612185450.73841b9f5af3a4189de6f910@linux-foundation.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <92ce901d-42dc-6872-1ff0-0ca13d5cefbe@arm.com>
Date:   Thu, 13 Jun 2019 11:07:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190612185450.73841b9f5af3a4189de6f910@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2019 07:24 AM, Andrew Morton wrote:
> On Wed, 12 Jun 2019 08:53:33 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>>>> ...
>>>>>
>>>>>
>>>>> - Rebased on linux-next (next-20190611)
>>>>
>>>> Yet the patch you've prepared is designed for 5.3.  Was that
>>>> deliberate, or should we be targeting earlier kernels?
>>>
>>> It was deliberate for 5.3 as a preparation for upcoming reworked arm64 hot-remove.
>>>
>>
>> We should probably add to the patch description something like "This is
>> a preparation for arm64 memory hotremove. The described issue is not
>> relevant on other architectures."
> 
> Please.  And is there any reason to merge it separately?  Can it be
> [patch 1/3] in the "arm64/mm: Enable memory hot remove" series?

Sure it can be. I will make this [patch 1/3] in the next version for
"arm64/mm: Enable memory hot remove". Apologies for the noise here.
