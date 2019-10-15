Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4533AECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D88520872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571159105;
	bh=5UnBc2PiR3Q8d/aNwx6hf4QIsamCL7FWSKNhppsN5cg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=reUapawQ25qCnUIjKnmWrxnocHPkwt2kvHyb+Ecy4EmBYIRRDD5HqaGd9TcjaUP3s
	 oJxpqs0whgrQEXfFZeQlRHx/ZHB+o1nYJjIwYKKHVZw7KI/SddyoCUrxJQ+1/T6d7j
	 LhcJPacn58uuh4a/iO3Grh+mu7PePO3K5S+dYXZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfJORFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfJORFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:05:03 -0400
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571159102;
        bh=5UnBc2PiR3Q8d/aNwx6hf4QIsamCL7FWSKNhppsN5cg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=see+LZhhheD/Ddn23TgTxmskUOLrTGG9LFVgM9qa0k1jX0RCVS4H3BpftqWWVQLvs
         vI8nzXhFVi0DVkDh9vgLbakFY3R+JY0cwUtXXLPup+9TB+x6Gl10ILpiEzDI83nVwS
         EWfMs4G4FwIMI+OyFWeWN/uhbcekRnyNtB/5K7rw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191015123830.GA1797@ls3530.fritz.box>
References: <20191015123830.GA1797@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191015123830.GA1797@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.4-2
X-PR-Tracked-Commit-Id: c32c47aa364096124c9c69c1a44918433832562b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02755af0f322fd1d2d7995c1e9fd6f9668511560
Message-Id: <157115910290.6841.17729342283243489680.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Oct 2019 17:05:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Oct 2019 14:38:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02755af0f322fd1d2d7995c1e9fd6f9668511560

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
