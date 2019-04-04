Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107EDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CCF206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDDFZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:25:42 -0400
Received: from foss.arm.com ([217.140.101.70]:51894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDFZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:25:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48BD6A78;
        Wed,  3 Apr 2019 22:25:41 -0700 (PDT)
Received: from [10.162.40.100] (p8cg001049571a15.blr.arm.com [10.162.40.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C48C3F721;
        Wed,  3 Apr 2019 22:25:34 -0700 (PDT)
Subject: Re: [PATCH 1/6] arm64/mm: Enable sysfs based memory hot add interface
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        logang@deltatee.com, pasha.tatashin@oracle.com, cai@lca.pw
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-2-git-send-email-anshuman.khandual@arm.com>
 <4b9dd2b0-3b11-608c-1a40-9a3d203dd904@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <fc9dadfa-6557-ecef-f027-7f3af098b55b@arm.com>
Date:   Thu, 4 Apr 2019 10:55:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4b9dd2b0-3b11-608c-1a40-9a3d203dd904@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2019 01:50 PM, David Hildenbrand wrote:
> On 03.04.19 06:30, Anshuman Khandual wrote:
>> Sysfs memory probe interface (/sys/devices/system/memory/probe) can accept
>> starting physical address of an entire memory block to be hot added into
>> the kernel. This is in addition to the existing ACPI based interface. This
>> just enables it with the required config CONFIG_ARCH_MEMORY_PROBE.
>>
> We recently discussed that the similar interface for removal should
> rather be moved to a debug/test module.

Can we maintain such a debug/test module mainline and enable it when required. Or
can have both add and remove interface at /sys/kernel/debug/ just for testing
purpose.

> 
> I wonder if we should try to do the same for the sysfs probing
> interface. Rather try to get rid of it than open the doors for more users.
> 

I understand your concern. Will drop this patch.
