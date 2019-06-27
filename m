Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53620C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322D82085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfF0MVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:21:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53495 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0MVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:21:10 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgTOl-00021l-R5; Thu, 27 Jun 2019 14:21:07 +0200
Date:   Thu, 27 Jun 2019 14:21:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 1/2] x86/vdso: Move mult and shift into struct
 vgtod_ts
In-Reply-To: <0643ba97-1b1b-8e14-c2cc-dcdf9cfd8479@nokia.com>
Message-ID: <alpine.DEB.2.21.1906271417420.32342@nanos.tec.linutronix.de>
References: <20190605144116.28553-1-alexander.sverdlin@nokia.com> <20190605144116.28553-2-alexander.sverdlin@nokia.com> <alpine.DEB.2.21.1906231008170.32342@nanos.tec.linutronix.de> <df6b6311-ac67-857f-5a81-aee4eabd9f47@nokia.com>
 <alpine.DEB.2.21.1906241135450.32342@nanos.tec.linutronix.de> <01ab4388-f259-e801-8c8a-f39b5abcfb52@nokia.com> <alpine.DEB.2.21.1906271405400.32342@nanos.tec.linutronix.de> <0643ba97-1b1b-8e14-c2cc-dcdf9cfd8479@nokia.com>
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

Alexander,

On Thu, 27 Jun 2019, Sverdlin, Alexander (Nokia - DE/Ulm) wrote:
> On 27/06/2019 14:07, Thomas Gleixner wrote:
> > 
> > Did you use the git tree? If not, it would be interesting to have a test
> > against that as well because that's the final version.
> 
> I've applied the following list:
> 
> 3acf4be23528 (tip/timers/vdso) arm64: vdso: Fix compilation with clang older than 8

> If you expect a difference, I can re-test using your tree as-is.

That's the tip of tree. All good.

> > The increase for mono and realtime is impressive. Which CPU is that?
> 
> This time it was
> 
> processor	: 3
> vendor_id	: AuthenticAMD
> cpu family	: 21
> model		: 96
> model name	: AMD PRO A10-8700B R6, 10 Compute Cores 4C+6G

Interesting. Need to find something similar in my fleet and figure out what
changed that so much.

Thanks!

	tglx
