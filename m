Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC8AC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EA4216B7
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564335023;
	bh=jmyG8VqilhLk7zNtnR/FdfJc0ah5n8GjBaZ5EchVWDk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=odKjNemZNr0rzXCR+NQJuLp8xc/p2F6C5w4r2O5EaaLjt4V7ziY6AJvoTp/+T0ovn
	 ciIqDbUc/OXNHME+3YmHcJ/0pMGn1UZY7pA3BzvLvUaZqSwSTf1EPlLN+qJWISGrC6
	 Q27ZxtNFRXIvIotzAxu/vkX8JhPTuduAOu57geZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfG1RaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfG1RaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:30:19 -0400
Subject: Re: [GIT PULL] USB fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564335018;
        bh=jmyG8VqilhLk7zNtnR/FdfJc0ah5n8GjBaZ5EchVWDk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mwzOxTp/vmZplJ+oxoI94Bt8L+1NcOgy8AqccGD1DvuOCqEr0lz9+h2fNpbXrhJeq
         dNf5xwd32T+f4Sh/aG9zy/WtE9l2NJmk3eC55tc5+31T43t5b3ldamsQKx8ZiMx7Rk
         vAUC2hMYNn/kkxuqgoPKM0t1xwPgwP0WWBZXoFm8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190728115928.GA15888@kroah.com>
References: <20190728115928.GA15888@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190728115928.GA15888@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc2
X-PR-Tracked-Commit-Id: d39b5bad8658d6d94cb2d98a44a7e159db4f5030
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29af915cabd4d51a2306008f84ee447f3a0d4e8f
Message-Id: <156433501848.9558.8653102684901126956.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 17:30:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jul 2019 13:59:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29af915cabd4d51a2306008f84ee447f3a0d4e8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
