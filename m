Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214B3C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E254A21734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfEARk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:40:56 -0400
Received: from foss.arm.com ([217.140.101.70]:34662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfEARkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:40:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CAEE80D;
        Wed,  1 May 2019 10:40:55 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A513F719;
        Wed,  1 May 2019 10:40:53 -0700 (PDT)
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <4550408f-39ff-7bf9-0072-a0898c6c2f60@redhat.com>
 <fd5b8c6c-05f0-307b-aaa2-0938337014a8@arm.com>
 <20190430132405.62902350@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <e3f1d619-1421-fd19-72ce-dadb56b07aaa@arm.com>
Date:   Wed, 1 May 2019 18:40:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430132405.62902350@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2019 21:24, Jacob Pan wrote:
> On Thu, 25 Apr 2019 11:41:05 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> On 25/04/2019 11:17, Auger Eric wrote:
>>>> +/**
>>>> + * ioasid_alloc - Allocate an IOASID
>>>> + * @set: the IOASID set
>>>> + * @min: the minimum ID (inclusive)
>>>> + * @max: the maximum ID (exclusive)
>>>> + * @private: data private to the caller
>>>> + *
>>>> + * Allocate an ID between @min and @max (or %0 and %INT_MAX).
>>>> Return the  
>>> I would remove "(or %0 and %INT_MAX)".  
>>
>> Agreed, those where the default values of idr, but the xarray doesn't
>> define a default max value. By the way, I do think squashing patches 6
>> and 7 would be better (keeping my SOB but you can change the author).
>>
> I will squash 6 and 7 in v3. I will just add my SOB but keep the
> author if that is OK.

Sure, that works

Thanks,
Jean
