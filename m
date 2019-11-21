Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD2EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7812F2068D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKUXzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfKUXzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:55:43 -0500
Received: from oasis.local.home (unknown [66.170.99.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D4C920643;
        Thu, 21 Nov 2019 23:55:42 +0000 (UTC)
Date:   Thu, 21 Nov 2019 18:55:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kusanagi Kouichi <slash@ac.auone-net.jp>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix !DEBUG_FS debugfs_create_automount
Message-ID: <20191121185540.1465a308@oasis.local.home>
In-Reply-To: <20191121132644.GA475684@kroah.com>
References: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
        <20191121115232.GC427938@kroah.com>
        <20191121124413687.NRXY.44544.ppp.dion.ne.jp@dmta0002.auone-net.jp>
        <20191121132644.GA475684@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 14:26:44 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Nov 21, 2019 at 09:44:13PM +0900, Kusanagi Kouichi wrote:
> > On 2019-11-21 12:52:32 +0100, Greg Kroah-Hartman wrote:  
> > > 
> > > Has this always been a problem, or did it just show up due to some other
> > > kernel change?
> > >   
> > 
> > The latter. Please see https://lkml.org/lkml/2019/11/21/11  
> 
> So it is fine for this to go into 5.5-rc1 then, right?  I'll queue it up
> that way.

As the following patch also relies on this fix, can you add this too:

 https://lore.kernel.org/lkml/20191120104350753.EWCT.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp/

And add my Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I'm haven't run these through my tests yet, but I'm going to (which
takes 13 hours), just to make sure, but I don't expect it to find
anything. But if it does, I'll let you know.

Thanks!

-- Steve
