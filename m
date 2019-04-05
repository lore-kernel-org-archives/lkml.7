Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F298C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0495E2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfDESdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:33:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49464 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDESdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:33:09 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCTeF-0002AS-Dg; Fri, 05 Apr 2019 20:33:07 +0200
Date:   Fri, 5 Apr 2019 20:33:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Len Brown <lenb@kernel.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
In-Reply-To: <20190226062012.23746-1-lenb@kernel.org>
Message-ID: <alpine.DEB.2.21.1904052031250.1802@nanos.tec.linutronix.de>
References: <20190226062012.23746-1-lenb@kernel.org>
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

On Tue, 26 Feb 2019, Len Brown wrote:

> This patch series does 4 things.
> 
> 1. Parses the new CPUID.1F leaf to discover multi-die/package topology
> 
> 2. Export multi-die topology inside the kernel
> 
> 3. Update 3 places (coretemp, pkgtemp, rapl) that that need to know
>    the difference between die and package-scope MSR.
> 
>    (Note: Kan Liang has a patch series on top of this one to similarly
>    make the uncore perf code multi-die/package aware.)
> 
> 4. Export multi-die topology to user-space via sysfs

Aside of the few nitpicks (which apply to several patches) this looks very
nice.

Thanks,

	tglx
