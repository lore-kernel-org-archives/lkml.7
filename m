Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBECC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2152146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDEUXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:23:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDEUXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:23:10 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCVMh-0004BJ-DA; Fri, 05 Apr 2019 22:23:07 +0200
Date:   Fri, 5 Apr 2019 22:23:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baoquan He <bhe@redhat.com>
cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, bp@alien8.de, hpa@zytor.com, dyoung@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH v3 1/3] x86/boot: Add xloadflags bits for 5-level kernel
 checking
In-Reply-To: <20190312103051.18086-2-bhe@redhat.com>
Message-ID: <alpine.DEB.2.21.1904052220480.1802@nanos.tec.linutronix.de>
References: <20190312103051.18086-1-bhe@redhat.com> <20190312103051.18086-2-bhe@redhat.com>
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

On Tue, 12 Mar 2019, Baoquan He wrote:

> Add two bits XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.
> Bit XLF_5LEVEL indicates if 5-level related code is contained
> in this kernel.
> Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.
> 
> They are being used in later patch to check if kexec/kdump kernel
> is loaded in right place.

Only XLF_5LEVEL is checked. So what's the second flag for?

Thanks,

	tglx
