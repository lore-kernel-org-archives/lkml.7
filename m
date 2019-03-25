Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8A2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE112075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfCYGMa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:12:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:22855 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfCYGMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:12:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 23:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="128374622"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga008.jf.intel.com with ESMTP; 24 Mar 2019 23:12:29 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 24 Mar 2019 23:12:28 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 24 Mar 2019 23:12:28 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.158]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.163]) with mapi id 14.03.0415.000;
 Mon, 25 Mar 2019 14:12:26 +0800
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
Subject: RE: [RFC PATCH 3/3] arch/x86/acrn: add hypercall for acrn_hypervisor
Thread-Topic: [RFC PATCH 3/3] arch/x86/acrn: add hypercall for
 acrn_hypervisor
Thread-Index: AQHU1Ioz/GfpoMDRuEeI4ug5HTPNy6YXYe6AgARzlrA=
Date:   Mon, 25 Mar 2019 06:12:25 +0000
Message-ID: <01363028D91B0B448414F51B4258CAA574CD3DF5@SHSMSX101.ccr.corp.intel.com>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
 <1551924251-19466-4-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1903221644530.1729@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903221644530.1729@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWU1OGQyYzctZDJiMi00ZWU2LTlmZDMtZmY3ZmIzZGY2ZGZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUGlLZVBIUjZMRElBSXMrWG1ZcDlaOE1uZzZNMnBoS1NwV1Nxb0VXRU9FVXJMSm1XXC9qRTdac0JncGtqbEpSVE8ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Thomas Gleixner [mailto:tglx@linutronix.de]
>Sent: Saturday, March 23, 2019 12:02 AM
>To: Zhao, Yakui <yakui.zhao@intel.com>
>Cc: linux-kernel@vger.kernel.org; x86@kernel.org; Chen, Jason CJ
><jason.cj.chen@intel.com>
>Subject: Re: [RFC PATCH 3/3] arch/x86/acrn: add hypercall for acrn_hypervisor
>
>On Thu, 7 Mar 2019, Zhao Yakui wrote:
>
>> When acrn_hypervisor is detected, the other module may communicate
>> with
>
>Which other module?
>
>> the hypervisor to query/config some settings. For example: it can be
>> used to query the resources in hypervisor and manage the
>> CPU/memory/device/ interrupt for Guest system.
>
>> +++ b/arch/x86/include/asm/acrn_hypercall.h
>> @@ -0,0 +1,85 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
>
>So the hypercall header is GPL-2.0+ and the acrn.c file is GPL-2.0. Not that I
>personally care, but is this intended?

Sorry for my fault. It should be GPL-2.0

>
>> +/*
>> + * acrn_hypercall.h : acrn hypervisor call API  */
>> +
>> +#ifndef __ACRN_HYPERCALL_H__
>> +#define __ACRN_HYPERCALL_H__
>> +
>> +#include <linux/errno.h>
>> +
>> +#ifdef CONFIG_ACRN
>> +
>> +static inline long acrn_hypercall0(unsigned long hcall_id) {
>> +
>> +	/* x86-64 System V ABI register usage */
>
>Well, yes. But can you please provide a link to the hypercall specification in the
>changelog?
>
>Also instead of repeating the same comment over and over, explain the calling
>convention in a top level comment.

This is the low-level implementation of low-level hypercall. It is similar to 
Kvm_hypercall1/2/3 in arch/x86/include/asm/kvm_para.h.
Does it make sense that the below comments are added before acrn_hypercall0/1/2?
/*
 * Hypercalls for ACRN Guest
 * 
 * Hypercall number is passed in r8 register.
 * Return value will be placed in rax. 
 * Up to 2 arguments are passed in rdi, rsi.
 */   

Of course I will also remove the redundant comments.

>
>> +	register signed long    result asm("rax");
>> +	register unsigned long  r8 asm("r8")  = hcall_id;
>
>I appreciate the attempt of making this tabular, but it's unreadable and has
>random white space in it. Also please use 'long' and not 'signed long'.

Ok. The type will be refined.


>
>	register unsigned long	r8	asm("r8") = hcall_id;
>	register long		result	asm("rax");
>
>> +
>> +	/* Execute vmcall */
>> +	asm volatile(".byte 0x0F,0x01,0xC1\n"
>> +			: "=r"(result)
>> +			:  "r"(r8));
>> +
>> +	/* Return result to caller */
>
>Please do not comment the obvious. It's entirely clear that this returns 'result'
>to the caller. Comments are there to explain what's not obvious.

Thanks for pointing out the issue.
I will remove the redundant comment.

>
>> +	return result;
>> +}
>
>Thanks,
>
>	tglx
