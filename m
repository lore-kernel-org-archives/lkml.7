Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974BAC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682BF2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfEOP6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:58:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:26191 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEOP6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:58:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 08:58:17 -0700
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 15 May 2019 08:58:16 -0700
Date:   Wed, 15 May 2019 08:56:37 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [RFC PATCH v3 11/21] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20190515155637.GC10526@ranerica-svr.sc.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1557842534-4266-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <62576937-50fc-fded-784b-d691e455dfc1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62576937-50fc-fded-784b-d691e455dfc1@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 07:26:58AM -0700, Randy Dunlap wrote:
> On 5/14/19 7:02 AM, Ricardo Neri wrote:
> > diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> > index 15d0fbe27872..376a5db81aec 100644
> > --- a/arch/x86/Kconfig.debug
> > +++ b/arch/x86/Kconfig.debug
> > @@ -169,6 +169,17 @@ config IOMMU_LEAK
> >  config HAVE_MMIOTRACE_SUPPORT
> >  	def_bool y
> >  
> > +config X86_HARDLOCKUP_DETECTOR_HPET
> > +	bool "Use HPET Timer for Hard Lockup Detection"
> > +	select SOFTLOCKUP_DETECTOR
> > +	select HARDLOCKUP_DETECTOR
> > +	select HARDLOCKUP_DETECTOR_CORE
> > +	depends on HPET_TIMER && HPET && X86_64
> > +	help
> > +	  Say y to enable a hardlockup detector that is driven by an High-
> 
> 	                                                       by a
> 
I'll correct.

Thanks and BR,
Ricardo
