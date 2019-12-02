Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE77EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9692070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575320720;
	bh=5rgGyS0Ie1a+WHSCN+fY6M52xXC7X3TjSl90U7zC+tk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aNUfW8xjo4LcDde0qbCiAFEtNxXdXdN177KU+JG1Dk9tM015XTlpBOvIGWROgoLoQ
	 A0zvgfw7jLChYMk7q5DUUMl/2jychqvnIaJ66NTNyFmYANUDeGEkExKVF3dcVmBfdo
	 +QRHDdUGakN8AX5K1Wx1buZ+qCRjoH5JrLKcuTZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfLBVFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbfLBVFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:05:17 -0500
Subject: Re: [PULL] Documentation for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575320717;
        bh=5rgGyS0Ie1a+WHSCN+fY6M52xXC7X3TjSl90U7zC+tk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hruUrgFVeJ74DMD12inQErLofxL7PnbZhoQ+xMrQQSUzlrFp+RS8FBG2nfZ5EW1X3
         huBCdrDBUhzAL25QSyeDffp+Zco/1UMWvu+7ghkYofjEwAcuS0kLLyIn5bg0jHWSBK
         Bac0DiOS7QobKHO3kTInUY1XjWH7Z1gORqtEdJwE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191126093002.06ece6dd@lwn.net>
References: <20191126093002.06ece6dd@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191126093002.06ece6dd@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.5
X-PR-Tracked-Commit-Id: 22abcd7569618271cc3609da24bbc0e7541248a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36bb9778fd11173f2dd1484e4f6797365e18c1d8
Message-Id: <157532071722.29263.11542218044846923178.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 21:05:17 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 09:30:02 -0700:

> git://git.lwn.net/linux.git tags/docs-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36bb9778fd11173f2dd1484e4f6797365e18c1d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
