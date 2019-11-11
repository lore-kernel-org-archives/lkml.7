Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F666C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C1820856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfKKFXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 00:23:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:45254 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfKKFXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 00:23:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 21:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="228824039"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2019 21:23:46 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
 scalable mode
To:     Qian Cai <cai@lca.pw>
References: <20191109034039.27964-1-baolu.lu@linux.intel.com>
 <472617D4-1652-45FB-90A4-0D45766DB78B@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f5b8521e-d88d-5439-34e2-f7b54a77c9d3@linux.intel.com>
Date:   Mon, 11 Nov 2019 13:20:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <472617D4-1652-45FB-90A4-0D45766DB78B@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/19 10:58 AM, Qian Cai wrote:
> 
> 
>> On Nov 8, 2019, at 10:43 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> +config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>> +    prompt "Enable Intel IOMMU scalable mode by default"
>> +    depends on INTEL_IOMMU
>> +    help
>> +      Selecting this option will enable the scalable mode if
>> +      hardware presents the capability. If this option is not
>> +      selected, scalable mode support could also be enabled
>> +      by passing intel_iommu=sm_on to the kernel.
>> +
> 
> Does it also make sense to mention which hardware presents this capability or how to check it?
> 

The scalable mode is defined in VT-d 3.0. The scalable mode capability
could be checked by reading /sys/devices/virtual/iommu/dmar*/intel-
iommu/ecap. It's currently not friendly for reading. You need to decode
it according to the spec.

Best regards,
baolu


