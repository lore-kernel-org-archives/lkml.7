Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FACC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CF72086A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575142811;
	bh=FAKuL0S0DRl5SVomXVMeTyFTKMQjz3YQ3essi+Iaegc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=djaQ5zMzoifBWymoFvvE8M9f0Z7LWcwrVQZrvNC+FNA5dcTD0Xp0nJi6+NVmqy+ff
	 ow4ETyCl8faZbezfmw7k6bso9KjkMvBOXiNnmKhbMw8+tHMymLVsx7uOASubAQOXGK
	 3cBLYFuG3OxKE2jv8f1WYH79j7aYpXotX6AHrF74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfK3TkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfK3TkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:06 -0500
Subject: Re: [GIT PULL] afs: Minor cleanups and a minor bugfix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142805;
        bh=FAKuL0S0DRl5SVomXVMeTyFTKMQjz3YQ3essi+Iaegc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JDQWc6yVZcd1xz079TJT3fbqfzfvSZxwD76+NqVYxBHZ/hVyEsOqjdNkHr6TNv6TG
         eARFZBJCy3N9z/XqV4rWhpOceQ21dhvRoM3vzqkvWhySMj2QNJd6qaUCDN1KJ/F3ZB
         r+iC33+3nUZEyElr9VHCM5ejFP2Ci/UmWvHE9aDs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <27497.1574808228@warthog.procyon.org.uk>
References: <27497.1574808228@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <27497.1574808228@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-next-20191121
X-PR-Tracked-Commit-Id: 4fe171bb81b13b40bf568330ec3716dfb304ced1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a55d362ffe7caf099a01f6d2ed49a6ea03a4a88
Message-Id: <157514280589.12928.10700973031954050508.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:05 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 22:43:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20191121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a55d362ffe7caf099a01f6d2ed49a6ea03a4a88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
