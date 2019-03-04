Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E496BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE42D2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfCDP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:58:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbfCDP6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:58:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D7D206B6;
        Mon,  4 Mar 2019 15:58:38 +0000 (UTC)
Date:   Mon, 4 Mar 2019 10:58:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Slavomir Kaslev <kaslevs@vmware.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] fs: Make splice() and tee() take into account
 O_NONBLOCK flag on pipes
Message-ID: <20190304105836.33f80dc3@gandalf.local.home>
In-Reply-To: <20190219121212.6c46b979@gandalf.local.home>
References: <20190207154519.8635-1-kaslevs@vmware.com>
        <20190213094445.1774f959@gandalf.local.home>
        <20190219121212.6c46b979@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 12:12:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 13 Feb 2019 09:44:45 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Does anyone have any issues or comments about this patch?  
> 
> I'm going to start pinging people once a week, looking for comments on
> this patch ;-)
> 

I'm still just hearing crickets about this? Should I just send this
directly to Linus or Andrew?

-- Steve
