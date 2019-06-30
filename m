Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30213C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080C520673
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfF3SWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 14:22:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39215 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF3SWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 14:22:08 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hheSc-0005rI-Ro; Sun, 30 Jun 2019 20:21:59 +0200
Date:   Sun, 30 Jun 2019 20:21:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        "tipbuild@zytor.com" <tipbuild@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, "lkp@01.org" <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [LKP] [x86/hotplug] e1056a25da:
 WARNING:at_arch/x86/kernel/apic/apic.c:#setup_local_APIC
In-Reply-To: <20190630130347.GB93752@shbuild999.sh.intel.com>
Message-ID: <alpine.DEB.2.21.1906302021320.1802@nanos.tec.linutronix.de>
References: <20190620021856.GP7221@shao2-debian> <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de> <58ea508f-dc2e-8537-fe96-49cca0a7c799@intel.com> <alpine.DEB.2.21.1906250821220.32342@nanos.tec.linutronix.de> <f5c36f89-61bf-a82e-3d3b-79720b2da2ef@intel.com>
 <alpine.DEB.2.21.1906251330330.32342@nanos.tec.linutronix.de> <20190628063231.GA7766@shbuild999.sh.intel.com> <alpine.DEB.2.21.1906280929010.32342@nanos.tec.linutronix.de> <alpine.DEB.2.21.1906290912390.1802@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906301334290.1802@nanos.tec.linutronix.de> <20190630130347.GB93752@shbuild999.sh.intel.com>
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

On Sun, 30 Jun 2019, Feng Tang wrote:
> On Sun, Jun 30, 2019 at 01:35:39PM +0200, Thomas Gleixner wrote:
> > On Sat, 29 Jun 2019, Thomas Gleixner wrote:
> > > On Fri, 28 Jun 2019, Thomas Gleixner wrote:
> > > > On Fri, 28 Jun 2019, Feng Tang wrote:
> > > > That function just 'works' by chance not by design. I'll stare into it and
> > > > fix it up for real.
> > > > 
> > > > Thank you very much for that information. Your debug was spot on!
> > > 
> > > I rewrote that function so it actually handles that case correctly along
> > > with some other things which were broken and force pushed the WIP.x86/ipi
> > > branch.
> > > 
> > > Can you please run exactly that test again against that new version and
> > > verify that this is fixed now?
> > 
> > Just found another issue with that thing. Don't waste your time on it. I'll
> > come back to you when I'm done.
> 
> Ok. I noticed that the ipi branch has been merged to tip/master.

Yes, but it will be zapped there as well.

Thanks,

	tglx
