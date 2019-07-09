Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF53C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F7021670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfGIPUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGIPUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:20:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4830A2166E;
        Tue,  9 Jul 2019 15:20:16 +0000 (UTC)
Date:   Tue, 9 Jul 2019 11:20:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Vincent Whitchurch <rabinv@axis.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Do not lose last line in kmsg dump
Message-ID: <20190709112003.184c03df@gandalf.local.home>
In-Reply-To: <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
References: <20190709081042.31551-1-vincent.whitchurch@axis.com>
        <20190709101230.GA16909@jagdpanzerIV>
        <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 16:29:39 +0200
Petr Mladek <pmladek@suse.com> wrote:

> Anyway, if nobody vetoes the patch, I would schedule it for 5.4.
> We are already in the merge window and it deserves some testing
> in linux-next.

+1

-- Steve
