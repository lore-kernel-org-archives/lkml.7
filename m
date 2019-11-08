Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF7C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C008D222C6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfKHDJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:09:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:31364 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfKHDJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:09:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 19:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,280,1569308400"; 
   d="scan'208";a="228055691"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 07 Nov 2019 19:09:52 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To:     Deepa Dinamani <deepa.kernel@gmail.com>, joro@8bytes.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
 <CABeXuvpYE9FCdX-FXTEg-rN_dtoxVn5+2psgU_AxPUPk38fQEw@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b84d1349-f5e3-c778-4490-d81a7c82b30a@linux.intel.com>
Date:   Fri, 8 Nov 2019 11:07:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABeXuvpYE9FCdX-FXTEg-rN_dtoxVn5+2psgU_AxPUPk38fQEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/8/19 5:27 AM, Deepa Dinamani wrote:
> On Thu, Nov 7, 2019 at 12:59 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> +static void intel_iommu_shutdown(void)
>> +       if (no_iommu || dmar_disabled)
>> +               return;
> 
> This check is actually not required here, as the handler is only
> installed after these have been checked in intel_iommu_init.
> I can remove this in the next version of the patch, but I'll wait a
> few days for comments.

This is probably still necessary if moving to detect_intel_iommu().

Best regards,
baolu

> 
> -Deepa
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
