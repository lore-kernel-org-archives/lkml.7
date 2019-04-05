Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15336C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE852175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfDEPlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbfDEPlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:41:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A8C21726;
        Fri,  5 Apr 2019 15:41:49 +0000 (UTC)
Date:   Fri, 5 Apr 2019 11:41:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix buffer_ref pipe ops
Message-ID: <20190405114148.2a8d75be@gandalf.local.home>
In-Reply-To: <20190405111855.466225c6@gandalf.local.home>
References: <20190404215925.253531-1-jannh@google.com>
        <20190405111855.466225c6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2019 11:18:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > Cc: stable@vger.kernel.org # v4.11

Instead of saying 4.11, can you specify the exact commit that this
fixes? Most of the splice code goes back to 3.7 or ever further.

Thanks!

-- Steve
