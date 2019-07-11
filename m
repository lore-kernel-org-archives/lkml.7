Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74082C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F14216C8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562879716;
	bh=UeF5BHYYoZDOWxsZax2UTwuARZdOY6fQlo9qCTC3d/Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jfP83Evg06do5DYtAM8fAEkBXPfZ5sp+lCmWaMdVlXrY9pVXRTpsw4unapnSul/gK
	 R2jpwKL8DE6zREVvt2o9yylsZwEcoiKZkdYTa2fdDCJOV+ND87ToteFyuJ8pz9GYLH
	 R2utMlo9TDNLhILVk0dRdsnqJWyyF04nOpNnoXfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfGKVPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbfGKVPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:15:11 -0400
Subject: Re: [GIT pull] timers/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562879710;
        bh=UeF5BHYYoZDOWxsZax2UTwuARZdOY6fQlo9qCTC3d/Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yYhiKgR/HqAhYN4QYkXNpUqMTBHxxvrtExiH0Kn0Z/JHrfoKzdK2KLGrR3LNtb6oo
         HLNHQzdAm2YwE7jKiupd/BM5x9BYdQW4oD47XAk05mzy+w29e5Vl5fyTUae8PUe6sL
         iCv7/zUOnSXtoAnAGltet61ZMVCC6mgHHnYvFB/g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156287535656.8320.9605793923078784342.tglx@nanos.tec.linutronix.de>
References: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
 <156287535656.8320.9605793923078784342.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156287535656.8320.9605793923078784342.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 0df1c9868c3a1916198ee09c323ca5932a0b8a11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7fe42a64a19a4140fb94bcf996035319cd3e6b9
Message-Id: <156287971038.8575.1459569125525893458.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 21:15:10 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 20:02:36 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7fe42a64a19a4140fb94bcf996035319cd3e6b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
