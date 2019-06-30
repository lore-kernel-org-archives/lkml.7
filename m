Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E713C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 13:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406B420665
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 13:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF3NDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 09:03:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:23627 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfF3NDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:03:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2019 06:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,434,1557212400"; 
   d="scan'208";a="165096721"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2019 06:03:43 -0700
Date:   Sun, 30 Jun 2019 21:03:47 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        "tipbuild@zytor.com" <tipbuild@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, "lkp@01.org" <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [LKP] [x86/hotplug] e1056a25da:
 WARNING:at_arch/x86/kernel/apic/apic.c:#setup_local_APIC
Message-ID: <20190630130347.GB93752@shbuild999.sh.intel.com>
References: <20190620021856.GP7221@shao2-debian>
 <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de>
 <58ea508f-dc2e-8537-fe96-49cca0a7c799@intel.com>
 <alpine.DEB.2.21.1906250821220.32342@nanos.tec.linutronix.de>
 <f5c36f89-61bf-a82e-3d3b-79720b2da2ef@intel.com>
 <alpine.DEB.2.21.1906251330330.32342@nanos.tec.linutronix.de>
 <20190628063231.GA7766@shbuild999.sh.intel.com>
 <alpine.DEB.2.21.1906280929010.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906290912390.1802@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906301334290.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906301334290.1802@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sun, Jun 30, 2019 at 01:35:39PM +0200, Thomas Gleixner wrote:
> On Sat, 29 Jun 2019, Thomas Gleixner wrote:
> > On Fri, 28 Jun 2019, Thomas Gleixner wrote:
> > > On Fri, 28 Jun 2019, Feng Tang wrote:
> > > That function just 'works' by chance not by design. I'll stare into it and
> > > fix it up for real.
> > > 
> > > Thank you very much for that information. Your debug was spot on!
> > 
> > I rewrote that function so it actually handles that case correctly along
> > with some other things which were broken and force pushed the WIP.x86/ipi
> > branch.
> > 
> > Can you please run exactly that test again against that new version and
> > verify that this is fixed now?
> 
> Just found another issue with that thing. Don't waste your time on it. I'll
> come back to you when I'm done.

Ok. I noticed that the ipi branch has been merged to tip/master.

Thanks,
Feng

> 
> Thanks,
> 
> 	tglx
