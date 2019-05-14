Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACE6C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B7521473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557856220;
	bh=wcZytFyqF5jz15IMVrl8tYwRSHyHYjkCmdLrP1N8tj8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GkyEi5KD3mJrl6icOQqrKro2+MORpMkbXipeSl9W8P2vfuB1MBNJ2INkvaBGD1yqc
	 pyCxccvNtW5CpqFAF76MpFpCYrLwUwYFxEfc2A4uetQ6hjNMqCw7ZTSCoV8eHvqbT6
	 UrfdfYopiUyJIpoxUPVkk+TMgtvG6iiZQhzgMkmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfENRuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfENRuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:50:17 -0400
Subject: Re: [GIT PULL] MFD for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557856216;
        bh=wcZytFyqF5jz15IMVrl8tYwRSHyHYjkCmdLrP1N8tj8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cxnvtd3J/nX6Ss4XI0khBxGCeRWribpTi0uB+2oSFuJTYBTLDoj1AaRXn/s0uygkV
         WNbBLbbBsxhFbYPvLgO16kA2eymtQnsCiA3eVyvQxLN2+mATr00Mf2ohdUde1WlLUB
         3KqCZAIVpAEtHjciPjtc3OxQHJqwSRlUEUfpCASU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190514103836.GM4319@dell>
References: <20190514103836.GM4319@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190514103836.GM4319@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.2
X-PR-Tracked-Commit-Id: ed835136ee679dc528333c454ca4d1543c5aab76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebcf5bb28241fe3ddc9e786e3816848a10f688b8
Message-Id: <155785621638.23900.3415796675257649208.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 17:50:16 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 May 2019 11:38:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebcf5bb28241fe3ddc9e786e3816848a10f688b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
