Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5D3C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 23:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544FA21743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565480409;
	bh=JA+ZT3JI+/jjjxIL0hinEb4OG1Y5ayUm4l3uzlEM36M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GSjJMbg9lnZiQaKn3W0a+ujpMbYjF3nb67v/LKvQylLZPeccL3Zay5AdYbmxEOOqV
	 S9nBXB/GP99XT1GIGaKPqKUxcoefEDO3X0+WplZlMlGwc6E50y3yuPdj/JFer5aG4O
	 HkexnJNiSnlX0dKHNnJctWlj/cbU75m9f/7WasYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHJXkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 19:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfHJXkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 19:40:07 -0400
Subject: Re: [GIT pull] x86/urgent for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565480406;
        bh=JA+ZT3JI+/jjjxIL0hinEb4OG1Y5ayUm4l3uzlEM36M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M8t0Wvv69BP47HRYCxb9dfAB1K9W+T/nRLZjaReV21E9UXiaJGRin7DCDEnBVNefn
         LUo3naxs3s1jZnCS5tnKa6c4l0SFAoPd9+pQcAWnAjZo/dnUO+s/RNoqBvz+v3zKty
         BeV1rb/nBg5yFtBRaS9trAj3C2jAMnbwu60EvHgc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156546731195.17538.5037114068802413527.tglx@nanos.tec.linutronix.de>
References: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
 <156546731195.17538.5037114068802413527.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156546731195.17538.5037114068802413527.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 04f5bda84b0712d6f172556a7e8dca9ded5e73b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d8f809cb55a8fc0ebfae27984215e4a0b201984
Message-Id: <156548040667.7293.17945458526492713422.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 23:40:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 20:01:51 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d8f809cb55a8fc0ebfae27984215e4a0b201984

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
