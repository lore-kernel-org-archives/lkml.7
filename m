Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFFCC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA76321907
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569089732;
	bh=ti+qmkfQ9p0whpjxawYmXFHbQHdzcbzIxQ1CN/5lKgE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=G6XDn8OHNYrbQqhStmi7U4wYzcbE0QWqpgI1Mi+l/lkr9i3ffKHzvAIVGtVxqqhRO
	 d4rj/XWDQszSj5R+p4ZAYge3mxTsBZpUU3FnbUrnHmPpexrlpo4q0ufp1GaTOx7hfA
	 OhmzaXtz4ksDzDMJA9aQyTcqxAvuQ6+QCrJyDYF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfIUSPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731797AbfIUSP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 14:15:26 -0400
Subject: Re: [GIT PULL] UML updates for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089726;
        bh=ti+qmkfQ9p0whpjxawYmXFHbQHdzcbzIxQ1CN/5lKgE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vvNlErjJnBddxcWBmx5kwH/BudZAnGh33g2ofQeEyWEQhe3c58C4ETB+wtb0Tyw8b
         t8idsbdOTujH+8mkRtVYjwAOF0ecuoUqrGkdl8BMYTLx40S3Cc3KGXeLKEvQsCGqjy
         iqSXudSt/yLifqlMj5lmtdU69H4lIX6YfT/A4Jb4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <466534311.3528.1569051399653.JavaMail.zimbra@nod.at>
References: <466534311.3528.1569051399653.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <466534311.3528.1569051399653.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.4-rc1
X-PR-Tracked-Commit-Id: 73625ed66389d4c620520058d828f43a93ab4d0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dca3432ee063b70a4cfb3f0857d0aeef7b84fa8
Message-Id: <156908972643.32474.17755196014521384085.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 18:15:26 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Sep 2019 09:36:39 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dca3432ee063b70a4cfb3f0857d0aeef7b84fa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
