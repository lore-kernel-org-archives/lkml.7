Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64974C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3915F21929
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568830826;
	bh=jG5mJJ5nzSJDfltv449Kp1WjCxbR2JKx4z0mKg5kw2U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=v/wjMGM3vSLT3NRAqPMt0nZCc8L+JyrfluPsMSGlC2QA1ElDxITx2CR+vdIkR+CQ5
	 CQ04xWZc9uMe6ojwYr994UDX6VAgOO/OZWL8hb0tcR/wxWjjvmlFUk0qUX7j3E/OR2
	 /JlaYWusKNR1UG4vDdZm+XKKtS+2xwgKEan0jWcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbfIRSUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388010AbfIRSUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:20:24 -0400
Subject: Re: [GIT PULL] USB patches for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568830823;
        bh=jG5mJJ5nzSJDfltv449Kp1WjCxbR2JKx4z0mKg5kw2U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Sp4AbsZME4u3OKE+UuoFsv7cob7UR6BlgBWNEOhirf4SwIa6p3pnDfYxktF00WSKR
         2vvc3V05mqBbsb+8nO6nYZyLaw9kLtCaJqyGNimy/1RDQ3G90ZO1is9wQf1Ye0vSYV
         R4sL2gTZqLHSJAzsNdLJ8XFxHbSlSeWSz/YK2SMg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190918114705.GA1899329@kroah.com>
References: <20190918114705.GA1899329@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190918114705.GA1899329@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc1
X-PR-Tracked-Commit-Id: fb9617edf6c0e1b86a6595cd92dd3f84595221d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6b48dad92aedaa9bdc013ee495cb5b1bbdf1f11
Message-Id: <156883082372.23903.16474540613402621360.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 18:20:23 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Sep 2019 13:47:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6b48dad92aedaa9bdc013ee495cb5b1bbdf1f11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
