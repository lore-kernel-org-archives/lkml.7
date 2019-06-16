Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3788BC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEF020644
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfFPQdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:33:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfFPQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:33:09 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcY5Q-0002Eq-Tn; Sun, 16 Jun 2019 18:32:57 +0200
Date:   Sun, 16 Jun 2019 18:32:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 01/18] x86/fsgsbase/64: Fix ARCH_SET_FS/GS behaviors
 for a remote task
In-Reply-To: <9040CFCD-74BD-4C17-9A01-B9B713CF6B10@intel.com>
Message-ID: <alpine.DEB.2.21.1906161830590.1760@nanos.tec.linutronix.de>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com> <1557309753-24073-2-git-send-email-chang.seok.bae@intel.com> <74F4F506-2913-4013-9D81-A0C69FA8CDF1@intel.com> <6420E1A5-B5AD-4028-AA91-AA4D5445AC83@intel.com>
 <9040CFCD-74BD-4C17-9A01-B9B713CF6B10@intel.com>
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

On Sun, 16 Jun 2019, Bae, Chang Seok wrote:
> > On Jun 14, 2019, at 13:11, Bae, Chang Seok <chang.seok.bae@intel.com> wrote:
> 
> Looks build error was reported with this. Sorry again for the noise.

Well. This has not built when it was posted. Can't you run your stuff
through the Intel zero day infrastructure _BEFORE_ posting?

Thanks,

	tglx
