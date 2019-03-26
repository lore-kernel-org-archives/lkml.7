Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DCDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62AC2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfCZBBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:01:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:56268 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfCZBBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:01:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 18:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="134715453"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 18:01:05 -0700
Subject: Re: [RFC PATCH 3/3] arch/x86/acrn: add hypercall for acrn_hypervisor
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
 <1551924251-19466-4-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1903221644530.1729@nanos.tec.linutronix.de>
 <01363028D91B0B448414F51B4258CAA574CD3DF5@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.21.1903250928131.1798@nanos.tec.linutronix.de>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <3f0f2bb5-5721-59c1-fddb-5609ebb55589@intel.com>
Date:   Tue, 26 Mar 2019 08:59:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903250928131.1798@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年03月25日 16:30, Thomas Gleixner wrote:
> On Mon, 25 Mar 2019, Zhao, Yakui wrote:
>>
>>> -----Original Message-----
>>> From: Thomas Gleixner [mailto:tglx@linutronix.de]
>>> Sent: Saturday, March 23, 2019 12:02 AM
>>> To: Zhao, Yakui <yakui.zhao@intel.com>
>>> Cc: linux-kernel@vger.kernel.org; x86@kernel.org; Chen, Jason CJ
>>> <jason.cj.chen@intel.com>
>>> Subject: Re: [RFC PATCH 3/3] arch/x86/acrn: add hypercall for acrn_hypervisor
> 
> 
> Can you please fix your mail client not to copy the full email headers on
> the reply?
> 
> The simple: On $DATE, someone wrote: like the below is sufficient.

thanks for the reminder.

> 
>>>> +static inline long acrn_hypercall0(unsigned long hcall_id) {
>>>> +
>>>> +	/* x86-64 System V ABI register usage */
>>>
>>> Well, yes. But can you please provide a link to the hypercall specification in the
>>> changelog?
>>>
>>> Also instead of repeating the same comment over and over, explain the calling
>>> convention in a top level comment.
>>
>> This is the low-level implementation of low-level hypercall. It is similar to
>> Kvm_hypercall1/2/3 in arch/x86/include/asm/kvm_para.h.
>> Does it make sense that the below comments are added before acrn_hypercall0/1/2?
>> /*
>>   * Hypercalls for ACRN Guest
>>   *
>>   * Hypercall number is passed in r8 register.
>>   * Return value will be placed in rax.
>>   * Up to 2 arguments are passed in rdi, rsi.
>>   */
> 
> Yes, that's much more helpful.
> 
> Thanks,
> 
> 	tglx
> 
