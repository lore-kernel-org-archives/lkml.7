Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC09C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC27C20842
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551921636;
	bh=iJNoZLPGuK3q1aCxUJnUyqO/x2SMPPe+f8Io+toqJhQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RIGZZuqAbKzPxtfp4hxgvwnNbOeqxhvpEcJtn+9HjvjPa+WCePZQDU/P6IsreKyXu
	 f/kUZ9CrVHk55hChuTGdGTEHHoNFi3/Kuz0HZ8MRdzS5qE4Bx2ZK5BlnuFB1QRvNLA
	 DIbY+rxk/mhSJq3gV01bzp7PryKNtIG38+6Ouoes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCGBUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbfCGBUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:20:18 -0500
Subject: Re: [GIT PULL] TTY/Serial patches for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551921618;
        bh=iJNoZLPGuK3q1aCxUJnUyqO/x2SMPPe+f8Io+toqJhQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R+2qugSyo5ar4jzgAsz/b72OSjHa1KNNQzOhfKrKMqVKi4A5qjdxml5FDLapWskMC
         p2C1IR4fcsJWQzYDcqwwfSGwxIzZ8TkaXg5QNEmiQ+upUqf5sxrMUJOvjwHL84Brwa
         Bt0toM943sK9GJqWqxG5qS8Nj1X5Q1vyUHTLngT4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306103447.GA10773@kroah.com>
References: <20190306103447.GA10773@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306103447.GA10773@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc1
X-PR-Tracked-Commit-Id: f694936c3b5a4c140ded5b673555d95aedc866b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67e79a6dc2664a3ef85113440e60f7aaca3c7815
Message-Id: <155192161799.31671.6067363492654032131.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 01:20:17 +0000
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

The pull request you sent on Wed, 6 Mar 2019 11:34:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67e79a6dc2664a3ef85113440e60f7aaca3c7815

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
