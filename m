Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338EC31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCB320861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfFQUXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:23:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFQUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:23:03 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcy8X-0004Us-6L; Mon, 17 Jun 2019 22:21:53 +0200
Date:   Mon, 17 Jun 2019 22:21:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Greear <greearb@candelatech.com>, stable@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Mark Gross <mgross@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [PATCH v3] Documentation: Add section about CPU vulnerabilities
 for Spectre
In-Reply-To: <c63945d34bfc9df2412f813d0b9b3a321a65de5d.1560795378.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906172217540.1963@nanos.tec.linutronix.de>
References: <c63945d34bfc9df2412f813d0b9b3a321a65de5d.1560795378.git.tim.c.chen@linux.intel.com>
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

Tim,

On Mon, 17 Jun 2019, Tim Chen wrote:

> +Spectre variant 1 attacks take advantage of speculative execution of
> +conditional branches, while Spectre variant 2 attacks use speculative
> +execution of indirect branches to leak privileged memory. See [1] [5]
> +[7] [10] [11].

It would be great to actually link these [N] to the actual http link at the
bottom. No idea what's the best way to do that.

Jonathan?

> +Mitigation control on the kernel command line
> +---------------------------------------------
> +
> +Spectre variant 2 mitigation can be disabled or force enabled at the
> +kernel command line.

The below renders horribly when converted to HTML

You probably want to wrap these into a table

> +	nospectre_v2	[X86] Disable all mitigations for the Spectre variant 2
> +			(indirect branch prediction) vulnerability. System may
> +			allow data leaks with this option, which is equivalent
> +			to spectre_v2=off.
> +
> +
> +        spectre_v2=     [X86] Control mitigation of Spectre variant 2
> +			(indirect branch speculation) vulnerability.
> +			The default operation protects the kernel from
> +			user space attacks.

Maybe Jonathan has a better idea.

Other than those formatting detail, this looks really good. Well done!

Thanks,

	tglx
