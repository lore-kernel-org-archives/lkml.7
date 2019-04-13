Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8808C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7790218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555128306;
	bh=RiiApz0uHFfNGo5gqq0yWfnyMK/3vUvHu36mqtoBdUE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=upl1qr+qD2tfdp0M4UagaKG3Rb0AG/njgzUWJBy4bnou4wTIrlYvVD9iw+CP4PXro
	 lRW3waKvF3aoHpA9iULQnPVthMOzz44BFKk0xFDP8TwK9SPLkHuHdEz3M0GkZPvruR
	 dcS4ocfphbBa0sZ81uKiqL0J4ApPcANandk6uixo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfDMEFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 00:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfDMEFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 00:05:05 -0400
Subject: Re: [GIT PULL] core/urgent fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555128304;
        bh=RiiApz0uHFfNGo5gqq0yWfnyMK/3vUvHu36mqtoBdUE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qNZAFmRRf2dVPC0ume2WD9SwW1JsBBuDQOqyrsR21bBs6jHg9y49FtTGPLOjWj+H+
         9+J2ffb7PcURebLS7qZCyXb3UNZWIf8lXAfBwEDfmD5OG9JSAHLquJDieF88kp7kO0
         VpJ/C2eiqyCAKyIOwMwdDL9N0fY0eer4efiust60=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412101630.GA89501@gmail.com>
References: <20190412101630.GA89501@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412101630.GA89501@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 4fa5ecda2bf96be7464eb406df8aba9d89260227
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54c63a75581f4b8d5d4b5660424f926510cfd98c
Message-Id: <155512830465.12181.16863216000065970566.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 04:05:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 12:16:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54c63a75581f4b8d5d4b5660424f926510cfd98c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
