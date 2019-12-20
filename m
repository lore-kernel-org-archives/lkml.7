Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B73C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1076F21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLTFqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:46:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:17673 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfLTFqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:46:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 21:46:41 -0800
X-IronPort-AV: E=Sophos;i="5.69,334,1571727600"; 
   d="scan'208";a="218719131"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.10.199]) ([10.251.10.199])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Dec 2019 21:46:41 -0800
Subject: Re: [PATCH] x86/resctrl: Fix potential memory leak
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20191219223834.233692-1-shakeelb@google.com>
 <1da649da-6527-d4c2-7d12-40126856ae75@intel.com>
 <CALvZod7zi+t9A=4_L-iiD3JhFpGU0Jt-=Q1_ee=7=7KAUMykVA@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <47f3789b-65cb-172e-ae56-ac8477613a5c@intel.com>
Date:   Thu, 19 Dec 2019 21:46:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CALvZod7zi+t9A=4_L-iiD3JhFpGU0Jt-=Q1_ee=7=7KAUMykVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On 12/19/2019 5:54 PM, Shakeel Butt wrote:
> On Thu, Dec 19, 2019 at 3:27 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 12/19/2019 2:38 PM, Shakeel Butt wrote:
>>> The set_cache_qos_cfg() is leaking memory when the given level is not
>>> RDT_RESOURCE_L3 or RDT_RESOURCE_L2. Fix that.
>>
>> I think it would be valuable to those considering whether they need to
>> backport to know that RDT_RESOURCE_L3 and RDT_RESOURCE_L2 are currently
>> the only possible levels with which this function is called. It is thus
>> not currently possible for this leak to occur. Indeed a valuable safety
>> to add in case this code may change in the future. Thank you very much.
>>
> 
> Do you want me to add that info the commit and resend the v2 of the patch?
> 

Yes please.

Thank you very much

Reinette
