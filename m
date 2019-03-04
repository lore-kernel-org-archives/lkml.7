Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E2EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2241720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551735005;
	bh=1MLiDF6W9NvkdXLcy7LEyGKOxJZaFQcri8byE7PZiKE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D9nFBJhArraj1iLdSfnN15Q+JJUspRl12SOXIOtHwVAoxGHBckrmyG+YRcBO/b3cJ
	 HF/9qsm48EAEi/J9AtWGtfh4fU1hcZmxY8IGRIigck749yGKEX9O5kjMle7vfF/k4E
	 H6YzVstSDAWnUbPfAvezSvnz510y3baWT2kEpV/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCDVaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCDVaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:30:02 -0500
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551735002;
        bh=1MLiDF6W9NvkdXLcy7LEyGKOxJZaFQcri8byE7PZiKE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HkY5m4nXBkKyLPkO1VSSfXOx4mb3yps866NffZfLXF+DiNLTDW9MrTokdXPxhECir
         +iwp/eZVLI86uAtFfbe1Mv6jWgc+dQNedb1LN3u2URceCJC0fY+LLo1MttZXUdqTd5
         jiWP/i0D9MD7TGFqslF8zxWwCIWAs2lTyKyjsfHQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190303034249.GO2217@ZenIV.linux.org.uk>
References: <20190303034249.GO2217@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190303034249.GO2217@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: d3d6a18d7d351cbcc9b33dbedf710e65f8ce1595
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f9020ffde71ddb92bc2f65ce0b00232bc88c590
Message-Id: <155173500221.15333.15989525206562038526.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Mar 2019 21:30:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Mar 2019 03:42:53 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f9020ffde71ddb92bc2f65ce0b00232bc88c590

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
