Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85441C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA402147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDHOZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHOZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:25:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69DBA21473;
        Mon,  8 Apr 2019 14:25:33 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:25:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V2 2/2] trace,x86: Add nmi to the irq_vectors class
Message-ID: <20190408102531.5bd824fb@gandalf.local.home>
In-Reply-To: <1da7473c-a602-9a49-35a1-6de43bb744b9@redhat.com>
References: <833f2a192b491649e4d46cec51028d07c96bbf5e.1554142415.git.bristot@redhat.com>
        <d9e0e9d14d2ef394cea974e2f47c0099b7d18839.1554142415.git.bristot@redhat.com>
        <alpine.DEB.2.21.1904052323200.1802@nanos.tec.linutronix.de>
        <9fc0399e-ab53-1074-623a-a826e2466277@redhat.com>
        <20190408094633.7ff8dbf4@gandalf.local.home>
        <1da7473c-a602-9a49-35a1-6de43bb744b9@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 15:57:07 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> > Just to remove confusion. Your example is to show that the new
> > tracepoints would have shown that the NMI was long due to the printk? As
> > running printk from NMI (even with the delayed output) isn't a normal
> > path.  
> 
> The example is "to show that the new tracepoints would have shown that the NMI
> was longer than what the existing tracepoint pointed." The example was not the
> best, I agree.. but... it serves to illustrate the idea.

Sure, just wanted to verify that was your intent.

Thanks,

-- Steve
