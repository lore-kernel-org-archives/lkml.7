Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640692085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfHSNcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:32:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfHSNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:32:04 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzhlN-0004b4-S3; Mon, 19 Aug 2019 15:31:57 +0200
Date:   Mon, 19 Aug 2019 15:31:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mike Lothian <mike@fireburn.co.uk>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to
 be reserved
In-Reply-To: <CAHbf0-E9ye1a0uuU4p-bRJhgEpQhceo6X-qR8hoBWoiOHajh2A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908191530560.2147@nanos.tec.linutronix.de>
References: <20190723130513.GA25290@kroah.com> <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de> <20190723134454.GA7260@kroah.com> <20190724153416.GA27117@kroah.com> <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de> <20190724155735.GC5571@kroah.com>
 <alpine.DEB.2.21.1907241801320.1791@nanos.tec.linutronix.de> <20190724161634.GB10454@kroah.com> <alpine.DEB.2.21.1907242153320.1791@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907242208590.1791@nanos.tec.linutronix.de> <20190725062447.GB5647@kroah.com>
 <CAHbf0-FenMwa6uMqpD_fJZLU3YKviOcMe_pBh8oWmUPoUYk_LA@mail.gmail.com> <CAHbf0-GpJY6SGz=9yXEh28vvBuHP-c_fKqP6u60Ag3et6FCPrg@mail.gmail.com> <alpine.DEB.2.21.1908191504570.2147@nanos.tec.linutronix.de>
 <CAHbf0-E9ye1a0uuU4p-bRJhgEpQhceo6X-qR8hoBWoiOHajh2A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019, Mike Lothian wrote:
>
> I'm using GCC 9.2, binutils 2.32. I used to use the gold linker but
> I've just switched back to using ld.bfd based on this discussion
> 
> My .config can be found at:
> https://raw.githubusercontent.com/FireBurn/KernelStuff/master/dot_config_tip

Does this combo successfully build 5.2 or is this a general problem?

Thanks,

	tglx
