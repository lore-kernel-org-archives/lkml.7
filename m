Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF01C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F3820989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557199522;
	bh=agyJXpORaqnO7sWm0VEpzZlUM0VHrPGkECLl9eYIWBA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pgpI0ex/dMzHWkgByUljmjx5+m4RJ1Rgwhbk6GvrMdar/+AlzR3y7cMC9mBmrCfeS
	 kQlLoo9NlycJmrVH+qH6SoNJ/+fZP19zei3PERW0jMkFo8EzsvpdybnGT0l+tvyQ7m
	 0seNxo3VeVN8lV2u9pRYt6h5OWrsu5ig8A1JkXto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfEGDZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfEGDZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:25:04 -0400
Subject: Re: [GIT PULL] EDAC pile for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557199503;
        bh=agyJXpORaqnO7sWm0VEpzZlUM0VHrPGkECLl9eYIWBA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X9Eu1ezTN8VLnCSzQkK60rYCWJhyi52GAoNpHr459kRDGVVBp40Py0n8OuqzSwc34
         D3tyet7yzXOOFIhKV+GASoexUVpHpKQD0uO4/a0vBbiM2iWG4nni8f6XifV3CBQIJJ
         ilycvGCMpLRiApjd6Hdws/4QmU/pD/8HN2PcH2h8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506083732.GB6094@zn.tnic>
References: <20190506083732.GB6094@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506083732.GB6094@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git
 tags/edac_for_5.2
X-PR-Tracked-Commit-Id: 8de9930a4618811edfaebc4981a9fafff2af9170
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 275b103a26e218b3d739e5ab15be6b40303a1428
Message-Id: <155719950375.20841.17232583243112373429.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 03:25:03 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 10:37:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/275b103a26e218b3d739e5ab15be6b40303a1428

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
