Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3933C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8540E206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCEByE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCEByD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:54:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD1B206B6;
        Tue,  5 Mar 2019 01:54:02 +0000 (UTC)
Date:   Mon, 4 Mar 2019 20:54:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Slavomir Kaslev <kaslevs@vmware.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] fs: Make splice() and tee() take into account
 O_NONBLOCK flag on pipes
Message-ID: <20190304205401.0823f3f7@gandalf.local.home>
In-Reply-To: <CAHk-=wh0ikMcREn-RLh-7TEeL28wj1-bHNTRsqpW_7dPuO7cAA@mail.gmail.com>
References: <20190207154519.8635-1-kaslevs@vmware.com>
        <20190213094445.1774f959@gandalf.local.home>
        <20190219121212.6c46b979@gandalf.local.home>
        <20190304105836.33f80dc3@gandalf.local.home>
        <CAHk-=wipy3J4r-dLim3QvNA2jVPi2uPCi=rTDiMYikBi5OiKnQ@mail.gmail.com>
        <CAHk-=wh0ikMcREn-RLh-7TEeL28wj1-bHNTRsqpW_7dPuO7cAA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Replying again, but without Cc'ing Trump due to a bug in claws-mail ]

On Mon, 4 Mar 2019 16:09:22 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> Note that the "arguably buggy" argument is not an actual real argument

Note that "arguably buggy" just means that you can argue that it is
buggy. It doesn't actually mean that it *is* buggy ;-)

-- Steve
