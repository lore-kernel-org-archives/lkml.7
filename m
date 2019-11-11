Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943FEC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C2920818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfKKFCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 00:02:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:29912 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfKKFCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 00:02:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 21:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="228820402"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2019 21:01:22 -0800
Cc:     baolu.lu@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] iommu/vt-d: Turn off translations at shutdown
To:     Deepa Dinamani <deepa.kernel@gmail.com>
References: <20191110172744.12541-1-deepa.kernel@gmail.com>
 <9e2e95e2-37ac-c0d6-d438-bd09ba7064bd@linux.intel.com>
 <CABeXuvofh-z97=iq9S7E1igbzyWwNU-MPbuCjNa_gzC3Q=L7hg@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <155325c9-5c7b-9fb1-edaf-2c22d67f207c@linux.intel.com>
Date:   Mon, 11 Nov 2019 12:58:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABeXuvofh-z97=iq9S7E1igbzyWwNU-MPbuCjNa_gzC3Q=L7hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/19 11:21 AM, Deepa Dinamani wrote:
> On Sun, Nov 10, 2019 at 5:35 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi,
>>
>> On 11/11/19 1:27 AM, Deepa Dinamani wrote:
>>> The intel-iommu driver assumes that the iommu state is
>>> cleaned up at the start of the new kernel.
>>> But, when we try to kexec boot something other than the
>>> Linux kernel, the cleanup cannot be relied upon.
>>> Hence, cleanup before we go down for reboot.
>>>
>>> Keeping the cleanup at initialization also, in case BIOS
>>> leaves the IOMMU enabled.
>>
>> Do you mind shining more light on this statement? I can't get your point
>> here. Currently iommu_shutdown() only happens for reboot, right?
> 
> In this part, I'm saying that I'm leaving intel_iommu_init() alone.
> I'm not taking out disabling the iommu from intel_iommu_init(). This
> will help when BIOS has enabled the IOMMU and for whatever reason, the
> kernel is booting with IOMMU off.

Okay, thanks for the explanation.

> 
> -Deepa
> 

Best regards,
baolu
