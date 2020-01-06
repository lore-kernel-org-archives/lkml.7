Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29402C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EC42072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578344716;
	bh=0fNJ5qQlETQMY/5Xq2rKQw1/igcwoYeCEEp5ih/L4no=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0bgJr6kmA1Ot7t7wNRnUnWlInu7NMIMj23+KnjdWvB56VyhtqszaBYB/jLq7Ztsmb
	 h9unADget71KE5n0oE25lVZy6z4Pzikp7VkDx7hALJm0Ps0+i64UZqpTFRN6k4sl1e
	 M1IBZ97GeX4apDtTJGzVn0Ka32PG7bIO20q+qd0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgAFVFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:05:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgAFVFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:05:10 -0500
Subject: Re: [GIT PULL] ARC updates for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578344709;
        bh=0fNJ5qQlETQMY/5Xq2rKQw1/igcwoYeCEEp5ih/L4no=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XH9JURchKXYJt6gi5iQo0osF+bZbCmrC/62hA61gl3qVYVBIBK3sFwd3UY7K9QKOK
         LITyGF7qNHarb9B3qAppp5KsgSByaxaM9znlHn0mUNAyeIPdqfxgLHcW6/qwetO3I/
         vVAVEsqEyNc50PKBkWsLKb5NJAeloOhHBYH+NZV8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9907df0c-6996-1a6b-0cf1-0dbfcb8ea414@synopsys.com>
References: <9907df0c-6996-1a6b-0cf1-0dbfcb8ea414@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9907df0c-6996-1a6b-0cf1-0dbfcb8ea414@synopsys.com>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: 7ecc6c1d5c8dbc713c647512a5267ca0eafe3e1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f8b69aa501e84a0043428467a5a22b55e937cbd
Message-Id: <157834470973.27503.1119136242800719665.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jan 2020 21:05:09 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jan 2020 18:09:39 +0000:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f8b69aa501e84a0043428467a5a22b55e937cbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
