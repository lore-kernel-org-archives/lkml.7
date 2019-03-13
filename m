Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D2EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9096E217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfCMCKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 22:10:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:37412 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfCMCKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 22:10:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 19:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,472,1544515200"; 
   d="scan'208";a="126446678"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2019 19:10:05 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
 map/unmap
To:     Christoph Hellwig <hch@infradead.org>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
 <20190312060005.12189-5-baolu.lu@linux.intel.com>
 <20190312163845.GA13141@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e653341d-e001-7262-740b-2262842be06d@linux.intel.com>
Date:   Wed, 13 Mar 2019 10:04:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190312163845.GA13141@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/13/19 12:38 AM, Christoph Hellwig wrote:
> On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
>> This adds the APIs for bounce buffer specified domain
>> map() and unmap(). The start and end partial pages will
>> be mapped with bounce buffered pages instead. This will
>> enhance the security of DMA buffer by isolating the DMA
>> attacks from malicious devices.
> 
> Please reuse the swiotlb code instead of reinventing it.
> 

I don't think we are doing the same thing as swiotlb here. But it's
always a good thing to reuse code if possible. I considered this when
writing this code, but I found it's hard to do. Do you mind pointing
me to the code which I could reuse?

Best regards,
Lu Baolu
