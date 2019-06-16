Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F765C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3AB21473
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560706508;
	bh=1h3jZouseIXDp8oe6J+7C7oDId1qiqDUQ4znGoNuApg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DMrsTkvOxP+YVWR9Gq6NPtPO6hmzexc1713gcSrAjoYP3BXw6i++xTeoAmDZXLgxN
	 /TIFmmEZ0AsEXz9wmGn+xaRacIDFoD5oa8YjkfWU9Po75y+gM6d+jNmAJwVV+yPOJV
	 ssLf4jVsS4KOhzyNhyB0WjZcDC9j8gshEbzcBhag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfFPRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 13:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfFPRfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:35:06 -0400
Subject: Re: [GIT pull] ras fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560706506;
        bh=1h3jZouseIXDp8oe6J+7C7oDId1qiqDUQ4znGoNuApg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J/pR/rHejtdEqEY8dWMifff9UwwGuuWeTXxPn75m1kOeuNMGgQVlvOu7Y+nynZRvC
         +B5wp9/n8XUul+vfdpHFlr149ivkEX0enhkY9T3PEHxkCVEh/5DUR703r94gch/+NE
         VjVcWVRlx9CjNoY2ZAeOI5DPlih4UmdZiW7o45sc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156068459205.30217.15980952927216488865.tglx@nanos.tec.linutronix.de>
References: <156068459205.30217.15980952927216488865.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156068459205.30217.15980952927216488865.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 ras-urgent-for-linus
X-PR-Tracked-Commit-Id: 0ade0b6240c4853cf9725924c46c10f4251639d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f763cf8e47d3aa4b081e0537d060c12818de8d0f
Message-Id: <156070650619.13049.13703785219077848000.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jun 2019 17:35:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jun 2019 11:29:52 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f763cf8e47d3aa4b081e0537d060c12818de8d0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
