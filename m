Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB192C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1E72083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFUTJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:09:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFUTJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:09:00 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heOu6-0005FG-3C; Fri, 21 Jun 2019 21:08:54 +0200
Date:   Fri, 21 Jun 2019 21:08:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kernel test robot <rong.a.chen@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, tipbuild@zytor.com, lkp@01.org
Subject: Re: [x86/hotplug] e1056a25da:
 WARNING:at_arch/x86/kernel/apic/apic.c:#setup_local_APIC
In-Reply-To: <20190620021856.GP7221@shao2-debian>
Message-ID: <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de>
References: <20190620021856.GP7221@shao2-debian>
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

On Thu, 20 Jun 2019, kernel test robot wrote:

> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: e1056a25daa6460c95e92d7d6853d05ad62458f7 ("x86/hotplug: Silence APIC and NMI when CPU is dead")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git WIP.x86/ipi
> 
> in testcase: locktorture
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 
> test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
> test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G

I cannot reproduce that issue. What's the underlying hardware machine?

Thanks,

	tglx
