Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B104C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B59216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfEJQnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfEJQnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:43:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0680D21479;
        Fri, 10 May 2019 16:43:16 +0000 (UTC)
Date:   Fri, 10 May 2019 12:43:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC][PATCH 0/2 v2] tracing/x86_32: Remove non DYNAMIC_FTRACE
 and mcount support
Message-ID: <20190510124315.3df0d4bb@gandalf.local.home>
In-Reply-To: <20190510163519.794235443@goodmis.org>
References: <20190510163519.794235443@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 12:35:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This will allow also allow us to remove klp_check_compiler_support()

One writes sentences like the above when someone walks in and asks a
question in the middle of writing a sentence.

-- Steve
