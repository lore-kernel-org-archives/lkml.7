Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7016E217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfDJHIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:08:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:48100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfDJHIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:08:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 00:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="314619164"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2019 00:08:43 -0700
Subject: Re: [RFC PATCH v3 1/4] x86: Add new config symbol to unify
 conditional definition of hv_irq_callback_count
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-2-git-send-email-yakui.zhao@intel.com>
 <20190408093526.GD15689@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <abd83e30-5772-dcd0-7994-4f1166f6fa89@intel.com>
Date:   Wed, 10 Apr 2019 15:06:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190408093526.GD15689@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月08日 17:35, Borislav Petkov wrote:
> Subject: x86/kconfig: Add ...
> 
> On Mon, Apr 08, 2019 at 04:12:08PM +0800, Zhao Yakui wrote:
>> Now the CONFIG_HYPERV and CONFIG_XEN can be used to control the definition
>> /usage of hv_irq_callback_count. If another linux guest also needs to use
>> the hv_irq_callback_count, current conditional definition looks unreadable.
> 
> Rewrite that to:
> 
> "Add a special Kconfig symbol X86_HV_CALLBACK_VECTOR which guests using
> the hypervisor interrupt callback counter can select and thus enable
> that counter. Select it when xen or hyperv support is enabled.
> 
> No functional changes."
> 
> with that fixed you can add:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Thanks for your review.
Will update the title and commit log as you suggested.

Thanks

> 
> Thx.
> 
