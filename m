Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5FEC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DFA21874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562614207;
	bh=8sbn63pqkRiDKrKnxaa6n9trIH9g8Gb6r+wHxF2/KDw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z8yAyX8cWela4jLnAMI3LFnvhSjeBQv60+yZj20KxciabfHhpJPTErafaKr0QocnO
	 khMHwd/YIaXAUf8JZcAlXO64BsttSJMBciJrMOkyZKuYlFRxNiPXQyu/zyj2L11y2B
	 PJlKo38HsNFD93ASIjCS8IkSjGYBcvE05qyZMqSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbfGHTaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGHTaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:05 -0400
Subject: Re: [GIT PULL] arm64 updates for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614204;
        bh=8sbn63pqkRiDKrKnxaa6n9trIH9g8Gb6r+wHxF2/KDw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UxYftCNCilU9sK20yDlutMZUYtlgOZXZEdhA5+Xj24S/9IP9AUFH8XvFNgRFVEx7C
         te64iJpoXxsuL9Cde3g3UdGyQGkW+I1Txs2HKZox9B2+rZP6z7DENm+fGS0R5qNVfL
         UMLzFXH+kbgwMg2rjqfiw1uQOudT+NNs/6niorG4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190704155427.GA48571@arrakis.emea.arm.com>
References: <20190704155427.GA48571@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190704155427.GA48571@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 0c61efd322b75ed3143e3d130ebecbebf561adf5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfd437a257924484b144ee750e60affc95562c6d
Message-Id: <156261420489.31351.3939506764284702102.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:04 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jul 2019 16:54:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfd437a257924484b144ee750e60affc95562c6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
