Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76377C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CD920656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfFYLcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:32:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41902 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfFYLcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:32:19 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfjgD-00052H-4e; Tue, 25 Jun 2019 13:32:05 +0200
Date:   Tue, 25 Jun 2019 13:32:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rong Chen <rong.a.chen@intel.com>
cc:     tipbuild@zytor.com, "H. Peter Anvin" <hpa@zytor.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [LKP] [x86/hotplug] e1056a25da:
 WARNING:at_arch/x86/kernel/apic/apic.c:#setup_local_APIC
In-Reply-To: <f5c36f89-61bf-a82e-3d3b-79720b2da2ef@intel.com>
Message-ID: <alpine.DEB.2.21.1906251330330.32342@nanos.tec.linutronix.de>
References: <20190620021856.GP7221@shao2-debian> <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de> <58ea508f-dc2e-8537-fe96-49cca0a7c799@intel.com> <alpine.DEB.2.21.1906250821220.32342@nanos.tec.linutronix.de>
 <f5c36f89-61bf-a82e-3d3b-79720b2da2ef@intel.com>
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
> On 6/25/19 2:24 PM, Thomas Gleixner wrote:
> > > On 6/22/19 3:08 AM, Thomas Gleixner wrote:
> > > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp
> > > > > 2 -m
> > > > > 2G
> > > > I cannot reproduce that issue. What's the underlying hardware machine?
> > > brand: Genuine Intel(R) CPU 000 @ 2.27GHz
> > > model: Westmere-EX
> > > memory: 256G
> > > nr_node: 4
> > > nr_cpu: 80
> > Ok. I'll try to find something similar. Can please you rerun that test on
> > that particular configuration with the updated branch?
> > 
> >     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/ipi
> > 
> I have tested commit e0b179bc1a ("x86/apic/x2apic: Add conditional IPI
> shorthands support"), the problem is still exist.

the head of that branch is:

      4f3f6d6a7f8e ("x86/apic/x2apic: Add conditional IPI shorthands support")

This is WIP and force pushed. There are no incremental changes. Could you
please check again?

Thanks,

	tglx
