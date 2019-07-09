Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F960C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5B52166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562695548;
	bh=qszUkIfcBTyOQhKXVOSyQwkIUIByxv8jYBX0D7tdbwY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mbtqDFaA3JvbsXW7tlo9HtFJkYq5UMTBuhStqcpkVuRBLXr5yNHcolKy9POI6ZISo
	 QsJjxbZnfsxgU48ZpCfTdiJFTqwKPmQXfWanW8Msa00zvvVumZqHpBKkpMEzwHm66F
	 Whi01JgN0pKoRhWWxhNwKg8TInwxBr+mAnAoCiyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfGISFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfGISFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:12 -0400
Subject: Re: [GIT PULL] EDAC driver changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695511;
        bh=qszUkIfcBTyOQhKXVOSyQwkIUIByxv8jYBX0D7tdbwY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S32nPDDsdOkYJ6qPvW7o38ru7MUY0je4IfBaE8ypoxPxiMbCJEAmAkOpXHnw7z2ZC
         YdzNFJV2KiWle4vWAX0P/z3tqL87kRUrORVkTkT3xEZcCRftPAGY470G4rrYe1JpDo
         ZRXAiuE195QeS4yB39bvoNZPYgERf/pLgse29Ano=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708161550.GA23045@agluck-desk2.amr.corp.intel.com>
References: <20190708161550.GA23045@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708161550.GA23045@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
 tags/please-pull-for_5.3
X-PR-Tracked-Commit-Id: d8655e7630dafa88bc37f101640e39c736399771
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 947fbd4ca9fb38f320b076e68cfccab977c5ea01
Message-Id: <156269551136.14383.16902388026142482452.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:11 +0000
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 09:15:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/please-pull-for_5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/947fbd4ca9fb38f320b076e68cfccab977c5ea01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
