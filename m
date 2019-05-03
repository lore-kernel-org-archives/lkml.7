Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B5EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696AD2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfECGeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:34:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49428 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfECGef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:34:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 74E411F453;
        Fri,  3 May 2019 06:34:35 +0000 (UTC)
Date:   Fri, 3 May 2019 06:34:35 +0000
From:   Eric Wong <e@80x24.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        omar.kilani@gmail.com, jbaron@akamai.com, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, dave@stgolabs.net
Subject: Re: [PATCH] signal: Adjust error codes according to
 restore_user_sigmask()
Message-ID: <20190503063435.446aqcckbc6ri7xx@dcvr>
References: <20190503033440.cow6xm4p4hezgkxv@linux-r8p5>
 <20190503034205.12121-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190503034205.12121-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> Sorry, I was trying a new setup at work. I should have tested it.
> My bad, I've checked this one.

Thanks.  This is good w.r.t. epoll_pwait and ppoll when applied
to 5.0.11 (no fs/io_uring.c).

Can't think of anything which uses pselect or aio on my system;
but it looks right to me.

> I've removed the questionable reported-by, since we're not sure if
> it is actually the same issue.

Yes, I hope Omar can test this, too.

Thanks again, all!
