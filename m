Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9252C4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F8B2190F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570920908;
	bh=0mjWQWyQLOm5KOj3ES7NaUhzZvbfQHrrg+Gd7osy5LI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MgWjBE3QlawaVYYCx/e5e/VKRnLvGYlDn6S7+SOcJeWWTY1STVKN/Ki0HFKtecsHF
	 Dg1Q5ynj2KGVUi75pfU6BECJoWSCQC18YtmG0rvuIWijFKhteuezq0sVaGLa1EGVOV
	 M2brEmvnVqVX5Ch7eqvbUI31mgIRiAdRpXcaN9ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfJLWzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbfJLWzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:55:06 -0400
Subject: Re: [GIT PULL] TTY/Serial fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570920906;
        bh=0mjWQWyQLOm5KOj3ES7NaUhzZvbfQHrrg+Gd7osy5LI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jlIcdauXlmhsRVCdBm5wa/aHjZRn+h4kXfTCpuORWIjtR8qgQH6QEHnPLR1BDgemk
         y0SS2jv+isHyJgNs72tLor1SOUzY+7VEoun0JLrzygpcvFpGR+XiFuTBNEBxi3ruV+
         6Cd78VOtpjKZ/fSYqh736aygeLEA9haiGJaaN+tA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012161614.GA2191633@kroah.com>
References: <20191012161614.GA2191633@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012161614.GA2191633@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.4-rc3
X-PR-Tracked-Commit-Id: 10deeac921647c929c67752d377f22e632d55d1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82c87e7d4068d0fc368c3e7356a94e7b87c29544
Message-Id: <157092090627.32460.7017728602784776573.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 18:16:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82c87e7d4068d0fc368c3e7356a94e7b87c29544

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
