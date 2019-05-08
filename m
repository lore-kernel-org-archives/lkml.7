Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BD4C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FE3214AE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEHCKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfEHCKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:10:09 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF6E21019;
        Wed,  8 May 2019 02:10:08 +0000 (UTC)
Date:   Tue, 7 May 2019 22:10:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] tracing: probeevent: Fix probe argument parser
 and handler
Message-ID: <20190507221006.17126aff@oasis.local.home>
In-Reply-To: <155723732200.9149.10482668315693777743.stgit@devnote2>
References: <155723732200.9149.10482668315693777743.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 May 2019 22:55:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd version of series to fix several bugs in probe event
> argument parser and handler routines.
> 
> In this version I updated patch [1/3] according to Steve's comment.
> 
> 
> I got 2 issues reported by Andreas, see
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899098.html
> 
> One issue is already fixed by Andreas (Thanks!) but $comm handling
> issue still exists on uprobe event. [1/3] fixes it.
> And I found other issues around that, [2/3] is just a trivial cleanup,
> [3/3] fixes $comm type issue which occurs not only uprobe events but
> also on kprobe events. Anyway, after this series applied, $comm must
> be "string" type and not be an array.
>

Thanks Masami,

I applied these to my queue.

-- Steve
