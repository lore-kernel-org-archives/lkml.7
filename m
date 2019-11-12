Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66804C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444D421783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKLFvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:51:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:5504 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfKLFvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:51:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 21:51:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="229230691"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2019 21:51:06 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
 scalable mode
To:     Qian Cai <cai@lca.pw>
References: <f5b8521e-d88d-5439-34e2-f7b54a77c9d3@linux.intel.com>
 <77EC0C76-22C1-4982-8E0A-9AD7223B3410@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fefea7dd-8cde-889d-0883-7d94b8d85f20@linux.intel.com>
Date:   Tue, 12 Nov 2019 13:48:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <77EC0C76-22C1-4982-8E0A-9AD7223B3410@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/19 10:05 PM, Qian Cai wrote:
> 
> 
>> On Nov 11, 2019, at 12:23 AM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> The scalable mode is defined in VT-d 3.0. The scalable mode capability
>> could be checked by reading /sys/devices/virtual/iommu/dmar*/intel-
>> iommu/ecap. It's currently not friendly for reading. You need to decode
>> it according to the spec.
> 
> This looks like some perfect information to put in the Kconfig description.
> 

Okay. Will add it in the next version.

Best regards,
baolu
