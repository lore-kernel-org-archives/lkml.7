Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A201C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E282E20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfCFV5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:57:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52527 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCFV5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:57:41 -0500
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1eXa-0006Dj-K4; Wed, 06 Mar 2019 22:57:30 +0100
Date:   Wed, 6 Mar 2019 22:57:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Louis Taylor <louis@kragniz.eu>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        fanc.fnst@cn.fujitsu.com, bhe@redhat.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Subject: Re: [PATCH] x86/KASLR: always return a value from
 process_mem_region
In-Reply-To: <CAKwvOdkjMv8xGTEagpbsbe3ky4eAXpUAXxkDUcZp9DN8xY5rYw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903062253380.1646@nanos.tec.linutronix.de>
References: <20190302184929.28971-1-louis@kragniz.eu> <alpine.DEB.2.21.1903062059570.1646@nanos.tec.linutronix.de> <20190306203725.GA23373@gmail.com> <CAKwvOdkjMv8xGTEagpbsbe3ky4eAXpUAXxkDUcZp9DN8xY5rYw@mail.gmail.com>
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

On Wed, 6 Mar 2019, Nick Desaulniers wrote:
> On Wed, Mar 6, 2019 at 12:38 PM Louis Taylor <louis@kragniz.eu> wrote:
> Looks like it was added.
> Looking at https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/boot,
> it looks like part of the commit message got cut off. `#endif, so move
> it there` is missing?

Ooops. git is doing something weird there. It doesn't like the #endif

Rephrased and pushed out.

Thanks,

	tglx


