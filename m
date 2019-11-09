Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C7CC17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069D52084D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKIAi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 19:38:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:9228 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfKIAi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 19:38:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 16:38:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; 
   d="scan'208";a="213338067"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2019 16:38:24 -0800
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To:     Deepa Dinamani <deepa.kernel@gmail.com>
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
 <f3d7138b-b254-3c6d-b865-d3b6889aa896@linux.intel.com>
 <CABeXuvpHYTU8qT5_+vxGUfLN34b6n-dF_5=KfRYp4eY22D8CKA@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2f09d7f4-6c9a-91f1-4618-c196f46870b9@linux.intel.com>
Date:   Sat, 9 Nov 2019 08:35:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABeXuvpHYTU8qT5_+vxGUfLN34b6n-dF_5=KfRYp4eY22D8CKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/9/19 6:28 AM, Deepa Dinamani wrote:
>>> +     x86_platform.iommu_shutdown = intel_iommu_shutdown;
>>
>> How about moving it to detect_intel_iommu() in drivers/iommu/dmar.c? And
> 
> Ok, makes sense to move it along with the init handler.
> 
>> make sure that it's included with CONFIG_X86_64.
> 
> You mean CONFIG_X86 like the init that is already there?
> 
> #ifdef CONFIG_X86
>      if (!ret)
>          x86_init.iommu.iommu_init = intel_iommu_init;
> #endif
> 

Yes.

Also, change the title to "iommu/vt-d: Turn off ..."

Best regards,
baolu
