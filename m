Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9098BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5243F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556575806;
	bh=YKMsjr2Pl5ZVWI+GFbJC6l3R7niMMQuNDS9f+IO50hI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=E+MmsLIId746162VrtJhHM7Mw6DruyZ8K7hp0OyOjIXqXwS1DrEM5YkNHC/6ky91D
	 PozxymTr5900HzUEQH3xWT4I+tXfcj2VX0mCy6Tl7p+rMGSEWf4dKX2RUMfn+K8OHT
	 aS5uaIz9N6R5JyBXQnIDufsbF6/Ii6yzopvTprlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfD2WKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfD2WKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:10:04 -0400
Subject: Re: [GIT PULL] seccomp fixes for v5.1-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556575804;
        bh=YKMsjr2Pl5ZVWI+GFbJC6l3R7niMMQuNDS9f+IO50hI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QSisNpw9nbUtIfrgvLv7YAAEFBvBb7uUjmoVflHkX8KoBXxcabcpKWdhoB16Z7eg2
         z4t74e6uH/E6cSVMzYWDm/BDGHzfm84rgSkDWLr8kkMQqgpbELcDiV71CJOo493k9h
         IS0XlzVUVOAI9nh8YfH8xPxbIQ4xHG4gI7AQcPXE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190429195836.GA30688@beast>
References: <20190429195836.GA30688@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190429195836.GA30688@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/seccomp-v5.1-rc8
X-PR-Tracked-Commit-Id: 7a0df7fbc14505e2e2be19ed08654a09e1ed5bf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83a50840e72a5a964b4704fcdc2fbb2d771015ab
Message-Id: <155657580394.929.13197122571033546186.pr-tracker-bot@kernel.org>
Date:   Mon, 29 Apr 2019 22:10:03 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>,
        syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com,
        Tycho Andersen <tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 29 Apr 2019 12:58:36 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83a50840e72a5a964b4704fcdc2fbb2d771015ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
