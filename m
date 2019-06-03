Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE7EC282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DED27A43
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFCAmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 20:42:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:65403 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCAmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 20:42:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 17:42:39 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2019 17:42:35 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, dima@arista.com, tmurphy@arista.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v4 10/15] iommu/vt-d: Probe DMA-capable ACPI name space
 devices
To:     Christoph Hellwig <hch@infradead.org>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
 <20190525054136.27810-11-baolu.lu@linux.intel.com>
 <20190529061626.GA26055@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <23d9d04c-c3fd-716e-dd66-eb5119aad4f9@linux.intel.com>
Date:   Mon, 3 Jun 2019 08:35:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529061626.GA26055@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/29/19 2:16 PM, Christoph Hellwig wrote:
> On Sat, May 25, 2019 at 01:41:31PM +0800, Lu Baolu wrote:
>> Some platforms may support ACPI name-space enumerated devices
>> that are capable of generating DMA requests. Platforms which
>> support DMA remapping explicitly declares any such DMA-capable
>> ACPI name-space devices in the platform through ACPI Name-space
>> Device Declaration (ANDD) structure and enumerate them through
>> the Device Scope of the appropriate remapping hardware unit.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Isn't this something that should be handled through the IOMMU API so
> that it covers other IOMMU types as well?
> 
> How does this scheme compare to the one implemented in
> drivers/acpi/arm64/iort.c?
> 

This part of code was added to be compatible with the past.

Yes. I've ever thought about this. But these devices sit on the acpi bus
together with other devices which are not DMA-capable. And on some
platforms these devices exist on the pci bus as well.

Best regards,
Baolu
