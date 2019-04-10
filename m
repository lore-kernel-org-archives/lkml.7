Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4339CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1025A206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfDJITq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:19:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:37536 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbfDJITq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:19:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 01:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="314636676"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2019 01:19:44 -0700
Subject: Re: [RFC PATCH v3 4/4] x86: Add hypercall for acrn_guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-5-git-send-email-yakui.zhao@intel.com>
 <20190408151010.GI15689@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <400e6c10-10c1-df8a-dcad-4a59c9d6ff9c@intel.com>
Date:   Wed, 10 Apr 2019 16:17:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190408151010.GI15689@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月08日 23:10, Borislav Petkov wrote:
> On Mon, Apr 08, 2019 at 04:12:11PM +0800, Zhao Yakui wrote:
>> When acrn_hypervisor is detected, the hypercall is needed so that the
>> acrn guest can query/config some settings. For example: it can be used
>> to query the resources in hypervisor and manage the CPU/memory/device/
>> interrupt for Guest system.
> 
> Good example.
> 
> What is "Guest system" and why is capitalized? Do you mean "the guest
> operating system" or simply "the guest"?

it means the "guest operating system".
It will be changed to "guest operating system".

> 
>> So the hypercall is added so that the kernel can communicate with the
> 
> "So add the hypercall so that..."
> 
>> low-level acrn-hypervisor.
> 
> Is it acrn_hypervisor or acrn-hypervisor or the ACRN hypervisor or ...?
> 
> Unify the naming pls.

Sure. They will be unified to "ACRN hypervisor" in next version.

> 
>> On x86 it is implemented by using vmacll when
> 
> During last review Thomas said:
> 
> "is implemented with the VMCALL instruction"
> 
> You still have it wrong. Which makes me think you haven't even gone over
> *all* review comments as this is the second missed review comment in a
> 4-patches set.
> 
> So I'm going to stop reviewing here and won't look at your patches until
> you incorporate *all* review comments from all people.
> 
