Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D2AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039DF20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1CTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfH1CTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:19:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC1320674;
        Wed, 28 Aug 2019 02:19:40 +0000 (UTC)
Date:   Tue, 27 Aug 2019 22:19:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: TAB nomination for Steven Rostedt
Message-ID: <20190827221938.0552eacb@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to nominate myself, Steven Rostedt, for election to the
Linux Foundation Technical Advisory Board (TAB).

Candidate statement:

I have been highly involved with the Linux kernel community since 2004,
as a developer, a user, maintainer and educator. When I first came onto
the board, my platform was to help bridge various parts of the Linux
ecosystem. I've been working to help developers reach across their
realms of expertise and unite with other developers in order to have
better integration of the tools within the GNU and Linux systems. Being
part of the advisory board to the Linux Foundation has facilitate this
goal. I am also on the planning committee for Linux Plumbers and have
become the Microconference Chair. As such I have succeeded in bringing
in developers to host a Database microconference for the first time at
Plumbers. The combination of being both on the TAB as well as a
Plumbers committee member has be extremely useful in my goal of
bringing all those that interact with Linux closer together. I would
like to continue this work for at least one more term.

Little more about me:

I'm one of the original developers of the PREEMPT_RT patch (which looks
to finally be merged into mainline). I'm the original author and
current maintainer of Ftrace, the official tracer of the Linux kernel.
I've created ktest.pl that lives in the kernel proper under the tools
directory which is a testing framework that was written to help
developers run their own tests. I'm also the one that added "make
localmodconfig" that brings your kernel compile time down tremendously!

-- Steve
