Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F052C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DA720828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfF0O0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:26:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56172 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0O0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:26:31 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgVM1-000615-M2; Thu, 27 Jun 2019 16:26:25 +0200
Date:   Thu, 27 Jun 2019 16:26:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rong Chen <rong.a.chen@intel.com>
cc:     tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [LKP] [x86/hotplug] e1056a25da:
 WARNING:at_arch/x86/kernel/apic/apic.c:#setup_local_APIC
In-Reply-To: <4b9cec2c-2bbe-1ea2-b4c9-35ce24ebd06f@intel.com>
Message-ID: <alpine.DEB.2.21.1906271615310.32342@nanos.tec.linutronix.de>
References: <20190620021856.GP7221@shao2-debian> <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de> <58ea508f-dc2e-8537-fe96-49cca0a7c799@intel.com> <alpine.DEB.2.21.1906250821220.32342@nanos.tec.linutronix.de> <f5c36f89-61bf-a82e-3d3b-79720b2da2ef@intel.com>
 <alpine.DEB.2.21.1906251330330.32342@nanos.tec.linutronix.de> <4b9cec2c-2bbe-1ea2-b4c9-35ce24ebd06f@intel.com>
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

Rong, Fengguang,

On Wed, 26 Jun 2019, Rong Chen wrote:
> On 6/25/19 7:32 PM, Thomas Gleixner wrote:
> > > I have tested commit e0b179bc1a ("x86/apic/x2apic: Add conditional IPI
> > > shorthands support"), the problem is still exist.
> > the head of that branch is:
> > 
> >        4f3f6d6a7f8e ("x86/apic/x2apic: Add conditional IPI shorthands
> > support")
> > 
> > This is WIP and force pushed. There are no incremental changes. Could you
> > please check again?
> 
> The problem is still exist.

I went through hoops and loops to get that lkp muck running, but as many
different machines I tried on it never reproduced.

So I need a bit of help from you folks. Can you please provide me:

   1) The exact host kernel version
   2) The config file
   3) The exact kvm-qemu version

Also it would be interesting whether 4f3f6d6a7f8e from that WIP.x86/ipi
branch in tip has the same issue on other host machines.

Another data point would be whether it depends on a particular compiler
version.
      
Thanks in advance,

	tglx

P.S: the instructions for reproducing the issue in that robot mail are
incomplete because there is no information how to bring the module into
that initrd... I somehow figured it out.
