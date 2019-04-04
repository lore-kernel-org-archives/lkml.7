Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73549C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B99B206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDDFVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:21:08 -0400
Received: from foss.arm.com ([217.140.101.70]:51832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDFVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:21:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B22B8A78;
        Wed,  3 Apr 2019 22:21:07 -0700 (PDT)
Received: from [10.162.40.100] (p8cg001049571a15.blr.arm.com [10.162.40.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC0153F721;
        Wed,  3 Apr 2019 22:21:01 -0700 (PDT)
Subject: Re: [PATCH 1/6] arm64/mm: Enable sysfs based memory hot add interface
To:     Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        logang@deltatee.com, cai@lca.pw
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-2-git-send-email-anshuman.khandual@arm.com>
 <4b9dd2b0-3b11-608c-1a40-9a3d203dd904@redhat.com>
 <e5665673-60ab-eee8-bc05-53dafb941039@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <514d246d-2619-08a9-bd1d-92d6b70b5a01@arm.com>
Date:   Thu, 4 Apr 2019 10:51:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e5665673-60ab-eee8-bc05-53dafb941039@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2019 06:42 PM, Robin Murphy wrote:
> On 03/04/2019 09:20, David Hildenbrand wrote:
>> On 03.04.19 06:30, Anshuman Khandual wrote:
>>> Sysfs memory probe interface (/sys/devices/system/memory/probe) can accept
>>> starting physical address of an entire memory block to be hot added into
>>> the kernel. This is in addition to the existing ACPI based interface. This
>>> just enables it with the required config CONFIG_ARCH_MEMORY_PROBE.
>>>
>>
>> We recently discussed that the similar interface for removal should
>> rather be moved to a debug/test module
>>
>> I wonder if we should try to do the same for the sysfs probing
>> interface. Rather try to get rid of it than open the doors for more users.
> 
> Agreed - if this option even exists in a released kernel, there's a risk that distros will turn it on for the sake of it, and at that point arm64 is stuck carrying the same ABI baggage as well.

True. Only if we really dont like that interface.

> 
> If users turn up in future with a desperate and unavoidable need for the legacy half-an-API on arm64, we can always reconsider adding it at that point. It was very much deliberate that my original hot-add support did not include a patch like this one.

Sure. Will drop this one next time around.
