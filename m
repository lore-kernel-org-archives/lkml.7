Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B42C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B514821903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552771522;
	bh=XmshS0jNCiVI1VVru3Sg+L5v/a0Mf/eSuhlQfTr0Udg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q/n+DgjSlzeZHGHj/SxpGbcxVgD02niC0t19IbGPY3TNuz0nWY6G5MLKQ9UmNN5LJ
	 u58yALuCv53Zgr4U2+7QUTuccQN3pzlmHEqQgu8hTh1TTGnIO11FYKpf6+gkuEkxnA
	 LFSiMyp90sG8iydq3cbLj+l8nNqtBdFkvUWfWbQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfCPVZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfCPVZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 17:25:19 -0400
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.0+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552771519;
        bh=XmshS0jNCiVI1VVru3Sg+L5v/a0Mf/eSuhlQfTr0Udg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kLGky8nuc9bn97ib9i2MOlg5wnR2hO6Ubk8qnNjapfjbBU3dSzdwvHOyI2YGRDvyL
         ghEKFQdEYvNzXDBbsuiFaFUPFqrNCurHP1QK2CxjZ3I4DdsxhJ3OGjsur/CtG5027H
         iE/PFnjSuPRWWZMzEgQJCyAdkgZ/RjziKgqEsYEA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1552695799.24933.24.camel@HansenPartnership.com>
References: <1552695799.24933.24.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1552695799.24933.24.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 52eaa798f4f4e983c711eaa1c13d8859a52946e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 477558d7e8d82b59a650e193a5651cf25b794dbc
Message-Id: <155277151927.28247.7076431904952865577.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Mar 2019 21:25:19 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 17:23:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/477558d7e8d82b59a650e193a5651cf25b794dbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
