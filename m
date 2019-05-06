Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA3CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E62120835
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186036;
	bh=KxAwLzZPyLzWp0YHpq3inUaQd4XyxwnGiOlanuSqrXE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nqU/ZPQGUwbZtGNrufMol5sw0QdEg8lDJCxn4TY5YCUWpVLoBy0zSTqovuW+nwc37
	 o0iw8FDgnf99gvHG4MuKJ3sJAI/ygttI10uW1sXorSy11Qo5YrIlZA5pZDNoMRkpk9
	 nOR9TQ4kWprBLrOTaKinGvVb6w/qmiMyHC7B+Tqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEFXkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfEFXkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:13 -0400
Subject: Re: [GIT PULL] x86/platform changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186013;
        bh=KxAwLzZPyLzWp0YHpq3inUaQd4XyxwnGiOlanuSqrXE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ae9jmxIA3MoxL7AmpjlM9HvzYOqrFhfciFqIkfgvfUqIT3jztoteWssh8iuBAJtE5
         o+7SpP1hyyn20Arvo6LHk+HqyXaXQmOdPdaEO3AkxJCnnrcQsYedEZbE3hkk7YO4U6
         TFQClp8ch2d5OCrO+h1v9xSqAwGUj/v5hfB5PvbQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506104423.GA86522@gmail.com>
References: <20190506104423.GA86522@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506104423.GA86522@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-platform-for-linus
X-PR-Tracked-Commit-Id: 14e581c381b942ce5463a7e61326d8ce1c843be7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba3934de557a2074b89d67e29e5ce119f042d057
Message-Id: <155718601320.9113.7582072535477698964.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:13 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:44:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba3934de557a2074b89d67e29e5ce119f042d057

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
