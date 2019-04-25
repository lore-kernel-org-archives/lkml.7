Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1147C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3C120878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfDYQFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbfDYQFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:05:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23AD220878;
        Thu, 25 Apr 2019 16:05:46 +0000 (UTC)
Date:   Thu, 25 Apr 2019 12:05:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/2] printk: lock console_sem before we unregister
 boot consoles
Message-ID: <20190425120543.09d0bd4e@gandalf.local.home>
In-Reply-To: <20190425092003.oj2p2o5rzrbnlah3@pathway.suse.cz>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
        <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
        <20190424144924.lw5sgl7qa2yrpxsj@pathway.suse.cz>
        <20190425035233.GA8532@jagdpanzerIV>
        <20190425064321.GA27270@jagdpanzerIV>
        <20190425092003.oj2p2o5rzrbnlah3@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 11:20:03 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > 
> > Petr, Steven, would you prefer to have it as two separate patches - one
> > removes the comment; the other one moves pr_info("console enabled") - or
> > as one patch? It's sort of trivial enough to be in just one patch, but
> > I also can submit it as separate changes.  
> 
> One patch is enough from my point of view. The moved pr_info()
> solves the problem that is described by the comment.

+1

-- Steve
