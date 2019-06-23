Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6DA2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFXDBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:01:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfFXDBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:01:44 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfBBe-0007Rm-T9; Mon, 24 Jun 2019 00:42:15 +0200
Date:   Mon, 24 Jun 2019 00:42:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 5/5] x86/umwait: Document umwait control sysfs
 interfaces
In-Reply-To: <1560994438-235698-6-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1906232305360.32342@nanos.tec.linutronix.de>
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com> <1560994438-235698-6-git-send-email-fenghua.yu@intel.com>
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

On Wed, 19 Jun 2019, Fenghua Yu wrote:
> +Description:	Umwait control
> +
> +		enable_c02: Read/write interface to control umwait C0.2 state
> +			Read returns C0.2 state status:
> +				0: C0.2 is disabled
> +				1: C0.2 is enabled
> +
> +			Write 'Yy1' or [oO][nN] for on to enable C0.2 state.

  Write 'Yy1' ? You meant [Yy1] I assume.

> +			Write 'Nn0' or [oO][fF] for off to disable C0.2 state.
  
What about avoiding all that unreadable confusion?

                        Write 'y' or '1'  or 'on' to enable C0.2 state.
                        Write 'n' or '0'  or 'of' to disable C0.2 state.

                        The interface is case insensitive.
Thanks,

	tglx
