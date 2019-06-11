Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B038C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D436A20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391380AbfFKOiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:38:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58340 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387486AbfFKOiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:38:50 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hahvA-00052j-8k; Tue, 11 Jun 2019 16:38:44 +0200
Date:   Tue, 11 Jun 2019 16:38:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>
cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 2/4] x86: simplify _TIF_SYSCALL_EMU handling
In-Reply-To: <20190523090618.13410-3-sudeep.holla@arm.com>
Message-ID: <alpine.DEB.2.21.1906111633400.1662@nanos.tec.linutronix.de>
References: <20190523090618.13410-1-sudeep.holla@arm.com> <20190523090618.13410-3-sudeep.holla@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019, Sudeep Holla wrote:

$Subject: Please use the proper prefix and start the sentence with an upper
case letter.

  x86/entry: Simplify _TIF_SYSCALL_EMU handling

> The usage of emulated/_TIF_SYSCALL_EMU flags in syscall_trace_enter
> seems to be bit overcomplicated than required. Let's simplify it.

s/seems to be bit overcomplicated/is more complicated/

 Either you are sure that it is overengineered, then say so. If not, then
 you should not touch the code at all.

s/Let's simplify it.//

 'Let's do X.' is a popular, but technically useless phrase.

> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

This is a nice simplification indeed! With the changelog fixed:

     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
