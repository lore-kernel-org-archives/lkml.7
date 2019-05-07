Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14521C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2B21019
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557194105;
	bh=q+4u+nowOgKwzVXclxdSeaAHEW0vSdacvBGW4S5TBJ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oupTINxuqpwCplF/jq0OoM9vMhdtRAsWeJE/injwBr+Yv5BQpvMGt/8+5/0GFKSDQ
	 snhGN+/LTdViokGl6x6b2RyKCzFa3Xzuubhjg0ru+5c8XRwDtntDXzfqWecPnOujgr
	 IJYWyV95yC/J23OY+k8ALpl05WIhVWrA09iRkAT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfEGBzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 21:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfEGBzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:55:04 -0400
Subject: Re: [git pull] m68k updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557194104;
        bh=q+4u+nowOgKwzVXclxdSeaAHEW0vSdacvBGW4S5TBJ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qq1k3RTt16St9N8bSr2bHcgamjAtbcXldw3V2Lhwma6bjbi80xBVBio7YJ4c+S8VY
         hqoWW+7yAAlTUxrpEiPTgsEUAZdCPMHPb40FAkEqpOCR2yKSoJksZB7KsiWrMTaEyi
         xY0bWioAqQjxmTPyZctBtmr7c7GtRCtAIGXq5Mfk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506090539.4338-1-geert@linux-m68k.org>
References: <20190506090539.4338-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506090539.4338-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v5.2-tag1
X-PR-Tracked-Commit-Id: fdd20ec8786ab2950439c7e78871618f7e51f18b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccbc2e5ed192ccd2663477107379f843d072e649
Message-Id: <155719410393.3542.892910503659366335.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 01:55:03 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 May 2019 11:05:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.2-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccbc2e5ed192ccd2663477107379f843d072e649

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
