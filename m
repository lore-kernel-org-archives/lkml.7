Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCCAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74383218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfB1QTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:19:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfB1QTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:19:10 -0500
Received: from vmware.local.home (unknown [38.88.19.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 155852133D;
        Thu, 28 Feb 2019 16:19:10 +0000 (UTC)
Date:   Thu, 28 Feb 2019 11:19:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix event filters and triggers to handle
 negative numbers
Message-ID: <20190228111908.3c949478@vmware.local.home>
In-Reply-To: <f0929165-bc75-c13a-7a20-43262ef8a496@virtuozzo.com>
References: <20180823102534.7642-1-ptikhomirov@virtuozzo.com>
        <20180823204849.3b4aede3@vmware.local.home>
        <f0929165-bc75-c13a-7a20-43262ef8a496@virtuozzo.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 09:11:37 +0000
Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:

> ping, looks like the patch was lost
> 
> On 8/24/18 3:48 AM, Steven Rostedt wrote:
> > On Thu, 23 Aug 2018 13:25:34 +0300
> > Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> >   
> >> Then tracing syscall exit event it is extremely useful to filter exit
> >> codes equal to some negative value, to react only to required errors.
> >> But negative numbers does not work:
> >>
> >> [root@snorch sys_exit_read]# echo "ret == -1" > filter
> >> bash: echo: write error: Invalid argument
> >> [root@snorch sys_exit_read]# cat filter
> >> ret == -1
> >>          ^
> >> parse_error: Invalid value (did you forget quotes)?  
> > 
> > Thanks for the patch. I'll apply it and then start testing it!

?!?

I remember applying this to my git queue (I don't reply like this
before doing so). Not sure how it got lost. All I can think of is that
it might have been added with commits that ended up failing the tests,
and got reverted with that code :-/

I'm currently traveling. Hopefully I remember tomorrow to add this.
Thanks for pointing this out, and I need to be a bit more careful when
reverting failed commits :-p

-- Steve
