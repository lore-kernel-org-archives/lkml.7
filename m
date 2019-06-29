Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054B6C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AFC215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561808724;
	bh=iooDHOTYr6UuOqlt3CnZFe6PbfP9hsquI/2qlmHD4hw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IAEvuxVnaixRdTDfoWEFE/M8dqgjGDyoo8/SwjqOMD1yBEHzdOdRO8M3X1Pi+4ds7
	 S4575ve+dn0JGZymS4xUZWEo319xxukbXzBr4e1Hszq5DGy5XslwVMFy/3aWJklgWJ
	 E0eWEwhVp8XMifNP0pwTp+f8FRmYb8looQg+Z/Rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfF2LpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 07:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfF2LpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 07:45:08 -0400
Subject: Re: [GIT PULL] Power management fix for v5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561808707;
        bh=iooDHOTYr6UuOqlt3CnZFe6PbfP9hsquI/2qlmHD4hw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yjAxJSOAWsx/6jFrJ4fvYRvqKZ1i81KZPkjLwAi3Tl5Xem40vZOvzpfhV/LtIldT1
         cOv8GkeK3aQg5J9y51cIdzaUpL9N0OOPTqWMWEgmsSgpYwDRzw/on+Kiw/KAEaPMIa
         RSQgToBCRRymm7IUt7+vIxrLTms8Hxm+pIS46fJo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ieD3bohHtsk4dZtZL-oJF8NUz5MJ3p+zHvQ2McgaSqaw@mail.gmail.com>
References: <CAJZ5v0ieD3bohHtsk4dZtZL-oJF8NUz5MJ3p+zHvQ2McgaSqaw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ieD3bohHtsk4dZtZL-oJF8NUz5MJ3p+zHvQ2McgaSqaw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc7
X-PR-Tracked-Commit-Id: 471a739a47aa7d582f0cdf9d392957d04632bae2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2407e486066b8ce00dabd7e2b3a2cbcc59ea6186
Message-Id: <156180870727.30344.904013935037519216.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jun 2019 11:45:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jun 2019 11:07:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2407e486066b8ce00dabd7e2b3a2cbcc59ea6186

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
