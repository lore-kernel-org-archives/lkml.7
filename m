Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B10C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03F720659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfFYGYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:24:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40643 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfFYGYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:24:05 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfes5-0005eQ-No; Tue, 25 Jun 2019 08:24:01 +0200
Date:   Tue, 25 Jun 2019 08:24:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rong Chen <rong.a.chen@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, tipbuild@zytor.com, lkp@01.org
Subject: Re: [x86/hotplug] e1056a25da:
 WARNING:at_arch/x86/kernel/apic/apic.c:#setup_local_APIC
In-Reply-To: <58ea508f-dc2e-8537-fe96-49cca0a7c799@intel.com>
Message-ID: <alpine.DEB.2.21.1906250821220.32342@nanos.tec.linutronix.de>
References: <20190620021856.GP7221@shao2-debian> <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de> <58ea508f-dc2e-8537-fe96-49cca0a7c799@intel.com>
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

Rong,

On Tue, 25 Jun 2019, Rong Chen wrote:
> On 6/22/19 3:08 AM, Thomas Gleixner wrote:
> > > 
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m
> > > 2G
> > I cannot reproduce that issue. What's the underlying hardware machine?
> 
> brand: Genuine Intel(R) CPU 000 @ 2.27GHz
> model: Westmere-EX
> memory: 256G
> nr_node: 4
> nr_cpu: 80

Ok. I'll try to find something similar. Can please you rerun that test on
that particular configuration with the updated branch?

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/ipi

please?

Thanks,

	tglx

