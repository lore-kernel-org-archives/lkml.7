Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C02C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BB62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfCYIat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:30:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44978 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbfCYIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:30:49 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8L0I-0005At-SX; Mon, 25 Mar 2019 09:30:47 +0100
Date:   Mon, 25 Mar 2019 09:30:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
Subject: RE: [RFC PATCH 3/3] arch/x86/acrn: add hypercall for
 acrn_hypervisor
In-Reply-To: <01363028D91B0B448414F51B4258CAA574CD3DF5@SHSMSX101.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1903250928131.1798@nanos.tec.linutronix.de>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com> <1551924251-19466-4-git-send-email-yakui.zhao@intel.com> <alpine.DEB.2.21.1903221644530.1729@nanos.tec.linutronix.de>
 <01363028D91B0B448414F51B4258CAA574CD3DF5@SHSMSX101.ccr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Zhao, Yakui wrote:
> 
> >-----Original Message-----
> >From: Thomas Gleixner [mailto:tglx@linutronix.de]
> >Sent: Saturday, March 23, 2019 12:02 AM
> >To: Zhao, Yakui <yakui.zhao@intel.com>
> >Cc: linux-kernel@vger.kernel.org; x86@kernel.org; Chen, Jason CJ
> ><jason.cj.chen@intel.com>
> >Subject: Re: [RFC PATCH 3/3] arch/x86/acrn: add hypercall for acrn_hypervisor


Can you please fix your mail client not to copy the full email headers on
the reply?

The simple: On $DATE, someone wrote: like the below is sufficient.

> >> +static inline long acrn_hypercall0(unsigned long hcall_id) {
> >> +
> >> +	/* x86-64 System V ABI register usage */
> >
> >Well, yes. But can you please provide a link to the hypercall specification in the
> >changelog?
> >
> >Also instead of repeating the same comment over and over, explain the calling
> >convention in a top level comment.
> 
> This is the low-level implementation of low-level hypercall. It is similar to 
> Kvm_hypercall1/2/3 in arch/x86/include/asm/kvm_para.h.
> Does it make sense that the below comments are added before acrn_hypercall0/1/2?
> /*
>  * Hypercalls for ACRN Guest
>  * 
>  * Hypercall number is passed in r8 register.
>  * Return value will be placed in rax. 
>  * Up to 2 arguments are passed in rdi, rsi.
>  */   

Yes, that's much more helpful.

Thanks,

	tglx
