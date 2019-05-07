Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20B320825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557258926;
	bh=oGddtjJv+ITElMVnkfbN7CuIkFotXoTbAFX+BeQy75o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zINdZJ4KnVWPssQfjFlTXSVO/5VcBhA3Y3kneiFWAvLIb/RfMOqZJCpBEKbrnNCse
	 zCIQb5VRZUKNFliQ44qi2FEcIlsHYaBxC3zn6FHhDit4SRT3QQHJd4Os9Gik9eYjoq
	 3z5r3WpiGbSOV/NWJH/Kvw4xpc6SsAm0f1NubiE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfEGTzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfEGTzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:14 -0400
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258914;
        bh=oGddtjJv+ITElMVnkfbN7CuIkFotXoTbAFX+BeQy75o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t06UFE0mUoCvjg2blF4vIBLSiAgcviqlYQHbuN5UQ1qQxqryXrS0M1VsPkcLz/srG
         tVqDm2rFXUcIW+lcHQ2FOk+xRLZ3khga1M9y+daSLNDeX5HsMrPLNCav8NPw40q4kA
         0yyPyJQiVSLVr7e4/kEXCy1VhzAV5BO5p4XYhQGk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506180521.GA30749@embeddedor>
References: <20190506180521.GA30749@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506180521.GA30749@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/Wimplicit-fallthrough-5.2-rc1
X-PR-Tracked-Commit-Id: ccaa75187a5f1d8131b424160eb90a8a94be287f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4b52b881cf08e13d110eac811d4becc0775abbf
Message-Id: <155725891412.4809.11579272937203075937.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 19:55:14 +0000
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 13:05:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4b52b881cf08e13d110eac811d4becc0775abbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
