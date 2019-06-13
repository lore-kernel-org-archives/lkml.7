Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F20CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4712621537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfFMViH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfFMViH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:38:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA86208CA;
        Thu, 13 Jun 2019 21:38:05 +0000 (UTC)
Date:   Thu, 13 Jun 2019 17:38:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] livepatch: Fix ftrace module text permissions race
Message-ID: <20190613173804.37cd37f8@gandalf.local.home>
In-Reply-To: <20190531222527.535zt6qzqmad34ss@treble>
References: <bb69d4ac34111bbd9cb16180a6fafe471a88d80b.1559156299.git.jpoimboe@redhat.com>
        <20190530135414.taftuprranwtowry@pathway.suse.cz>
        <20190531191256.z5fm4itxewagd5xc@treble>
        <20190531222527.535zt6qzqmad34ss@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019 17:25:27 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Fri, May 31, 2019 at 02:12:56PM -0500, Josh Poimboeuf wrote:
> > > Anyway, the above is a separate problem. This patch looks
> > > fine for the original problem.  
> > 
> > Thanks for the review.  I'll post another version, with the above
> > changes and with the patches split up like Miroslav suggested.  
> 
> The latest patches are here:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=fix-livepatch-ftrace-race
> 
> If the bot likes them, I'll post them properly soon.
> 

Was this ever posted?

-- Steve
