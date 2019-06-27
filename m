Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0023C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C7B208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF0Wxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:53:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60025 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfF0Wxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:53:39 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgdGo-00029T-R0; Fri, 28 Jun 2019 00:53:35 +0200
Date:   Fri, 28 Jun 2019 00:53:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: Re: [patch 26/29] x86/hpet: Consolidate clockevent functions
In-Reply-To: <alpine.DEB.2.21.1906280041160.32342@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906280052380.32342@nanos.tec.linutronix.de>
References: <20190623132340.463097504@linutronix.de> <20190623132436.461437795@linutronix.de> <20190626211753.GB101255@gmail.com> <alpine.DEB.2.21.1906280041160.32342@nanos.tec.linutronix.de>
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

On Fri, 28 Jun 2019, Thomas Gleixner wrote:
> On Wed, 26 Jun 2019, Ingo Molnar wrote:
> > 
> >  s/hpet_clkevt_msi_resume
> >   /hpet_clkevt_tick_resume
> > 
> > ... unless the name variations have some hidden purpose and meaning?
> 
> Historical but we want to preserve some of the old stuff for sentimental
> reasons.

The msi_resume naming actually has a real reason as there is also the
legacy_resume one.

Thanks,

	tglx
