Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E692EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64F9214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfDYFr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:47:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:22350 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfDYFr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:47:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 22:47:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="340619087"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga006.fm.intel.com with ESMTP; 24 Apr 2019 22:47:25 -0700
Subject: Re: [RFC PATCH v5 0/4] x86: Add the support of ACRN guest under x86
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1904250020140.1762@nanos.tec.linutronix.de>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <0309f41e-2ffe-1209-c9d4-81479828774e@intel.com>
Date:   Thu, 25 Apr 2019 13:44:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904250020140.1762@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月25日 06:20, Thomas Gleixner wrote:
> On Wed, 24 Apr 2019, Zhao Yakui wrote:
> 
>> ACRN is a flexible, lightweight reference hypervisor, built with real-time
>> and safety-criticality in mind, optimized to streamline embedded development
>> through an open source platform. It is built for embedded IOT with small
>> footprint and real-time features. More details can be found
>> in https://projectacrn.org/
>>
>> This is the patch set that allows the Linux to work on ACRN hypervisor and it can
>> work with the following patch set to manage the Linux guest on ACRN hypervisor. It
>> includes the detection of ACRN hypervisor, upcall notification vector from
>> hypervisor, hypercall. The hypervisor detection is similar to Xen/VMWARE/Hyperv.
>> ACRN also uses the upcall notification mechanism similar to that in Xen/Microsoft
>> HyperV when it needs to send the notification to Linux OS. The hypercall provides
>> the mechanism that can be used to query/configure the ACRN hypervisor by Linux guest.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for the review.
I will remove the RFC in the next version.

Thanks
    Yakui

> 
