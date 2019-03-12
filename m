Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B4F2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfCLPWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfCLPWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:22:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648462054F;
        Tue, 12 Mar 2019 15:22:11 +0000 (UTC)
Date:   Tue, 12 Mar 2019 11:22:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Valdis =?UTF-8?B?S2zEk3RuaWVrcw==?= <valdis.kletnieks@vt.edu>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace/trace_kprobe.c - fix comment format
Message-ID: <20190312112209.6516b48c@gandalf.local.home>
In-Reply-To: <8869c042-aba9-f29b-db16-342d64769e04@infradead.org>
References: <2812.1552381112@turing-police>
        <20190312110151.00e0df4d@gandalf.local.home>
        <8869c042-aba9-f29b-db16-342d64769e04@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 08:14:52 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> > NACK.
> > 
> > This isn't a kernel doc comment, and I don't want to make it one when
> > it is not. Just ignore that warning.
> > 
> > -- Steve  
> 
> Huh?  The patch doesn't do that -- it does the opposite of that.
> I.e., begin a non-kernel-doc comment with /* instead of /**.

Ah, my head swapped the "-" to the "+". I thought the patch
was adding the extra '*'. Nevermind, I'll take it.

Thanks for pointing that out.

Also, I'll change the subject to:

 trace/probes: Remove kernel doc style from non kernel doc comment

-- Steve
