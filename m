Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25068C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FBE206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfECKfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:35:08 -0400
Received: from foss.arm.com ([217.140.101.70]:58090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfECKfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:35:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934EF374;
        Fri,  3 May 2019 03:35:07 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0F653F557;
        Fri,  3 May 2019 03:35:05 -0700 (PDT)
Subject: Re: [PATCH v6 02/12] mm/sparsemem: Introduce common definitions for
 the size and mask of a section
To:     Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
 <CAPcyv4g+KNu=upejy7Xm=jWR0cdhygPAdSRbkfFGpJeHFGc4+w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bd76cb2f-7cdc-f11b-11ec-285862db66f3@arm.com>
Date:   Fri, 3 May 2019 11:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g+KNu=upejy7Xm=jWR0cdhygPAdSRbkfFGpJeHFGc4+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2019 01:41, Dan Williams wrote:
> On Thu, May 2, 2019 at 7:53 AM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>>
>> On Wed, Apr 17, 2019 at 2:52 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>>
>>> Up-level the local section size and mask from kernel/memremap.c to
>>> global definitions.  These will be used by the new sub-section hotplug
>>> support.
>>>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Jérôme Glisse <jglisse@redhat.com>
>>> Cc: Logan Gunthorpe <logang@deltatee.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> Should be dropped from this series as it has been replaced by a very
>> similar patch in the mainline:
>>
>> 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
>>   mm/memremap: Rename and consolidate SECTION_SIZE
> 
> I saw that patch fly by and acked it, but I have not seen it picked up
> anywhere. I grabbed latest -linus and -next, but don't see that
> commit.
> 
> $ git show 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
> fatal: bad object 7c697d7fb5cb14ef60e2b687333ba3efb74f73da

Yeah, I don't recognise that ID either, nor have I had any notifications 
that Andrew's picked up anything of mine yet :/

Robin.
