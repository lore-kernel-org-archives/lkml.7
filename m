Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0FBC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 01:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1693A2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 01:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKXBLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 20:11:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfKXBLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 20:11:10 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D6420679;
        Sun, 24 Nov 2019 01:11:09 +0000 (UTC)
Date:   Sat, 23 Nov 2019 20:11:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kusanagi Kouichi <slash@ac.auone-net.jp>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix !DEBUG_FS debugfs_create_automount
Message-ID: <20191123201105.1352cd22@oasis.local.home>
In-Reply-To: <20191122151926.GA2083897@kroah.com>
References: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
        <20191121115232.GC427938@kroah.com>
        <20191121124413687.NRXY.44544.ppp.dion.ne.jp@dmta0002.auone-net.jp>
        <20191121132644.GA475684@kroah.com>
        <20191121185540.1465a308@oasis.local.home>
        <20191122151926.GA2083897@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 16:19:26 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > As the following patch also relies on this fix, can you add this too:
> > 
> >  https://lore.kernel.org/lkml/20191120104350753.EWCT.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp/
> > 
> > And add my Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Now queued up, thanks!

Thanks, and FYI, I ran this through all my tests and it passed (both patches together).

-- Steve
