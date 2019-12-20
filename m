Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B9AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23D62082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfLTWql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:46:41 -0500
Received: from utopia.booyaka.com ([74.50.51.50]:56689 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfLTWql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:46:41 -0500
Received: (qmail 14788 invoked by uid 1019); 20 Dec 2019 22:46:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Dec 2019 22:46:39 -0000
Date:   Fri, 20 Dec 2019 22:46:39 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
cc:     Patrick Staehlin <me@packi.ch>, Ingo Molnar <mingo@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anders Roxell <anders.roxell@linaro.org>,
        Alan Kao <alankao@andestech.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Zong Li <zong@andestech.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Wilson <jimw@sifive.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC/RFT 2/2] RISC-V: kprobes/kretprobe support
In-Reply-To: <alpine.DEB.2.21.9999.1912200313100.3767@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.999.1912202244070.7752@utopia.booyaka.com>
References: <20181113195804.22825-1-me@packi.ch> <20181113195804.22825-3-me@packi.ch> <20181114003730.06f810517a270070734df4ce@kernel.org> <20181114074951.0902699286fdf8652f2878a4@kernel.org> <05082ba4-33d6-a95c-e049-78791dafc009@packi.ch>
 <alpine.DEB.2.21.9999.1912200313100.3767@viisi.sifive.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019, Paul Walmsley wrote:

> Are you still working on these kprobes/kretprobe patches for RISC-V?

Just saw the reply that contained the original off-list messages:

https://lore.kernel.org/linux-riscv/20181113195804.22825-1-me@packi.ch/T/#mdfae8698806243c76f88f1da8594c23756523e82

Looking forward to what comes in early January.

I know the BPF guys have some test cases that are blocked by missing 
kprobes/tracepoint support:

https://lore.kernel.org/linux-riscv/20191216091343.23260-1-bjorn.topel@gmail.com/



- Paul
