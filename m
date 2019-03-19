Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82415C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5996A20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553019317;
	bh=pU8tlj9fVCo0OFHWGEDxvGlCSHPsZnktYGAdqwOMY00=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=u8KGaJxDA/pDX9Q+7xAvqisNwo8qQ570vMTQWF8YYJHxk3Q1govMcaPMkoyMKRmMs
	 qzw/ieoZoBZq01K7H0jzEzvdzqNRd0N0Ypm4LQ+fy++nqipYquYgJHYxSslyh+NnzZ
	 rOO0g7RJPrN5/Nsdb8ETVKdNNzgZKG/oZ+9vDqKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfCSSPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfCSSPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:15:13 -0400
Subject: Re: [GIT PULL] MIPS fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553019312;
        bh=pU8tlj9fVCo0OFHWGEDxvGlCSHPsZnktYGAdqwOMY00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HZG75rI6qzIy2xM3XQWbcIThA8atn79j38xmV/GXlhsF0Hb3IUpje855tmSP0H5Xf
         9S8OTTgTbBWssmOge9siGHOEDsDL8j0IZSP2PQgaoNtLCMrH3YBNKoo5ls7BvUMV/+
         KtKxlq4uNbqcaWxE3dqG3WXutT6FFVLZUDiNFq/0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190318230815.m7amgekprnajav7i@pburton-laptop>
References: <20190318230815.m7amgekprnajav7i@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190318230815.m7amgekprnajav7i@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.1_1
X-PR-Tracked-Commit-Id: f6cab793d4a70808e4946baa8f5df4ea9adacc82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7a42146dca3f57b6a6ceb9aaaabfff21634040e
Message-Id: <155301931258.12441.11808232505556681385.pr-tracker-bot@kernel.org>
Date:   Tue, 19 Mar 2019 18:15:12 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 18 Mar 2019 23:08:16 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.1_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7a42146dca3f57b6a6ceb9aaaabfff21634040e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
