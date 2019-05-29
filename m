Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFBFC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8972173B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE2DMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 23:12:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:41169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfE2DMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 23:12:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 20:12:16 -0700
X-ExtLoop1: 1
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.245]) ([10.239.196.245])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2019 20:12:13 -0700
Subject: Re: [PATCH v2 1/3] KVM: x86: add support for user wait instructions
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     rkrcmar@redhat.com, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jingqi.liu@intel.com
References: <20190524075637.29496-1-tao3.xu@intel.com>
 <20190524075637.29496-2-tao3.xu@intel.com>
 <419f62f3-69a8-7ec0-5eeb-20bed69925f2@redhat.com>
 <c1b27714-2eb8-055e-f26c-e17787d83bb6@intel.com>
 <b5daf72d-d764-baa4-8e7f-b09dff417786@redhat.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <daf8ebd7-47bb-e4d8-fc67-38af8811000c@intel.com>
Date:   Wed, 29 May 2019 11:12:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b5daf72d-d764-baa4-8e7f-b09dff417786@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/2019 10:38 AM, Paolo Bonzini wrote:
> On 29/05/19 04:05, Tao Xu wrote:
>>>
>>
>> Thank you Paolo, but I have another question. I was wondering if it is
>> appropriate to enable X86_FEATURE_WAITPKG when QEMU uses "-overcommit
>> cpu-pm=on"?
> 
> "-overcommit" only establishes the behavior of KVM, it doesn't change
> the cpuid bits.  So you'd need "-cpu" as well.
> 
> Paolo
> 
OK I got it. Thank you for your review.

