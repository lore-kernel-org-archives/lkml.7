Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C394CC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 12:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DD32133D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 12:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFPMeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 08:34:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41744 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfFPMeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 08:34:24 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcUMN-0000Fi-RF; Sun, 16 Jun 2019 14:34:12 +0200
Date:   Sun, 16 Jun 2019 14:34:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for
 FSGSBASE
In-Reply-To: <alpine.DEB.2.21.1906161038160.1760@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906161433390.1760@nanos.tec.linutronix.de>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com> <1557309753-24073-19-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de> <EEACF240-4772-417A-B516-95D9003D0D11@intel.com>
 <89BE934A-A392-4CED-83E5-CA4FADDAE6DF@intel.com> <alpine.DEB.2.21.1906161038160.1760@nanos.tec.linutronix.de>
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

On Sun, 16 Jun 2019, Thomas Gleixner wrote:
> On Sun, 16 Jun 2019, Bae, Chang Seok wrote:
> > On Jun 14, 2019, at 13:07, Bae, Chang Seok <chang.seok.bae@intel.com<mailto:chang.seok.bae@intel.com>> wrote:
> > 
> > 
> > On Jun 13, 2019, at 23:54, Thomas Gleixner <tglx@linutronix.de<mailto:tglx@linutronix.de>> wrote:
> > 
> > +The GS segment has no common use and can be used freely by
> > +applications. There is no storage class specifier similar to __thread which
> > +would cause the compiler to use GS based addressing modes. Newer versions
> > +of GCC and Clang support GS based addressing via address space identifiers.
> > +
> > +Clang does not provide these address space identifiers, but it provides
> > +an attribute based mechanism:
> > +
> > 
> > These two sentences seem to conflict with each other; Clang needs to be clarified
> > above.
> > 
> > Thanks for the write-up. Just preparing v8 right now. Will send out shortly.
> 
> Please dont. Send me a delta patch against the documentation. I have queued
> all the other patches already internally. I did not push it out because I
> wanted to have proper docs.

Fixed it up already. About to push it out.

Thanks,

	tglx
