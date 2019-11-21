Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEFDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F46206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574368208;
	bh=cE4tG0jmKDl2wngVhg9RGGVBji9cgxX7tpUSU2NQU38=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=x1h5+UULcsmeaLAZaOIQAIwHOd9WvfHUYvTlvSkkFMtYNr4oJYp5sdDbMnHkFZ6im
	 zV2EnYU5JfdXS5L8MeEe37PXu7umDD/YPDR/EPJQRQH8YRQetR8HAE3FEY7ulFiEHF
	 9sINVAAtADeZrQn45+exj62AxReG7TcrN14YBtOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKUUaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfKUUaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:30:06 -0500
Subject: Re: [GIT PULL] arm64: Another fix for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574368206;
        bh=cE4tG0jmKDl2wngVhg9RGGVBji9cgxX7tpUSU2NQU38=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZLnrsVGSV1mrdy5/2G+PIDh/HNSu4Nn0mGVE1uBI3Ez2b6JSBLLO5Q/CqzqMw5OQa
         Kcq5clcYDL6x52tmTteGbhIqJ5ZvN5WNBcVV2MJW3RuyHkaePjT8tR8PNf0MdskE91
         zE/OmWHXOkl0YzSZo7qrgfW/iylcnzqoKAO30mRc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191121144408.GA3751@willie-the-truck>
References: <20191121144408.GA3751@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191121144408.GA3751@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: e50be648aaa3da196d4f4ed49d1c5d4ec105fa4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81429eb8d9ca40b0c65bb739d29fa856c5d5e958
Message-Id: <157436820592.3070.12039964483555520125.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Nov 2019 20:30:05 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, gregkh@linuxfoundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Nov 2019 14:44:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81429eb8d9ca40b0c65bb739d29fa856c5d5e958

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
