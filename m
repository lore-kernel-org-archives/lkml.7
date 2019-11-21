Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191FBC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14B1208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574342809;
	bh=LXjoDLB7N1CUlHGskpTHMcf3kjxecn82NmlwzjdOsmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SBORt/oLGMG/j90z7QGnG+mak6FbKilBczLLi2hNf6evxOYveQbUMrD8eYf6gVztq
	 vmeJZps7rV0kt4C9/ps9vOUpspdWqieon6/ti0GyOE+hym4mEmLeWeUZd9C3NywAIv
	 w7EOh/eskTPFEdBSGs5jghYuPzosbR1C8xJmo+Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKUN0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfKUN0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:26:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A652D2075E;
        Thu, 21 Nov 2019 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342807;
        bh=LXjoDLB7N1CUlHGskpTHMcf3kjxecn82NmlwzjdOsmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcyvpiRldAc+hmqJAVUpY2xDL/V5qMc38XNiuqlL8lBb33bbNrh/ptGJGF1xG+rRg
         Q8KiIbt4Dmpsd5phFwAQ/excbkG+W+j0gNSB9iVXJFqkE3k5D+3VH/nO0+KWdYiL0r
         FB3tRMjLOqHMDy/DVwCaLWi62b0QiRlCiW3rgisg=
Date:   Thu, 21 Nov 2019 14:26:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix !DEBUG_FS debugfs_create_automount
Message-ID: <20191121132644.GA475684@kroah.com>
References: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
 <20191121115232.GC427938@kroah.com>
 <20191121124413687.NRXY.44544.ppp.dion.ne.jp@dmta0002.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121124413687.NRXY.44544.ppp.dion.ne.jp@dmta0002.auone-net.jp>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:44:13PM +0900, Kusanagi Kouichi wrote:
> On 2019-11-21 12:52:32 +0100, Greg Kroah-Hartman wrote:
> > 
> > Has this always been a problem, or did it just show up due to some other
> > kernel change?
> > 
> 
> The latter. Please see https://lkml.org/lkml/2019/11/21/11

So it is fine for this to go into 5.5-rc1 then, right?  I'll queue it up
that way.

thanks,

greg k-h
