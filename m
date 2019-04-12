Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC36C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AECD2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfDLBmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:42:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:35885 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfDLBmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:42:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 18:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,339,1549958400"; 
   d="scan'208";a="130677578"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 11 Apr 2019 18:42:45 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/9] vfio/mdev: IOMMU aware mediated device
To:     Joerg Roedel <joro@8bytes.org>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
 <20190411151917.GA29810@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0beedc65-fc26-5f17-6f0f-6e0c0aa022a3@linux.intel.com>
Date:   Fri, 12 Apr 2019 09:36:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190411151917.GA29810@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 4/11/19 11:19 PM, Joerg Roedel wrote:
> Hi Lu Baolu,
> 
> thanks for these patches!
> 
> On Mon, Mar 25, 2019 at 09:30:27AM +0800, Lu Baolu wrote:
>> Lu Baolu (9):
>>    iommu: Add APIs for multiple domains per device
>>    iommu/vt-d: Make intel_iommu_enable_pasid() more generic
>>    iommu/vt-d: Add per-device IOMMU feature ops entries
>>    iommu/vt-d: Move common code out of iommu_attch_device()
>>    iommu/vt-d: Aux-domain specific domain attach/detach
>>    iommu/vt-d: Return ID associated with an auxiliary domain
> 
> I applied the patches above to my tree. The first patch is in a new
> branch called 'api-features' and the other are in the x86/vt-d branch.

Thank you!

> 
>>    vfio/mdev: Add iommu related member in mdev_device
>>    vfio/type1: Add domain at(de)taching group helpers
>>    vfio/type1: Handle different mdev isolation type
> 
> Can you please address the minor concern on these patches, add all
> review and acks and re-send?

Sure. I will resend these soon.

> 
> Thanks,
> 
> 	Joerg

Best regards,
Lu Baolu
