Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A643C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF14A20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574746808;
	bh=bA0HJy7H0i447Qnj0rJcmZyqhOAuNypZ7zSzOVYTKg8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ufguqsJgziy2fOPEmp5pwBtUjuDNPwWI1Ohy/Kym7S48XZdHMld/L92XJaui8uDBV
	 o8I6BRys+Bw8IB39wEY0sSTwSgqZ4GEtHAgR1DX0xgsr7vuk9v3T0nemtIoESDFuZ+
	 Zp19m698/No3/Z8C9n3odOYChggqPwjjh5Lg9NmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKZFkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfKZFkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:40:07 -0500
Subject: Re: [GIT PULL] regmap update for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574746806;
        bh=bA0HJy7H0i447Qnj0rJcmZyqhOAuNypZ7zSzOVYTKg8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aGqEqbuypNqr/W+/WYuanZBJ4ZHMwR6NisCqdWU8Rq3LtHD7C94lW9bS+y/XhNbNY
         +LJngiuIzabGH0wN7oWPgt7uL5DzEwgkYN3RsL6ARdI4GQVH4zpntiq7aCF8lQ5Qfx
         jJUYn8UPbzDAy6pr8n9iTuVTY6yPaZ+rMji7F6k0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125130413.GB4535@sirena.org.uk>
References: <20191125130413.GB4535@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125130413.GB4535@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-v5.5
X-PR-Tracked-Commit-Id: a20db58f3e6e6770362614c488e5426f972de97e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b397c7ccafe0624018cb09fc96729f8f6165573
Message-Id: <157474680670.3611.15539122527829487030.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 05:40:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 13:04:13 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b397c7ccafe0624018cb09fc96729f8f6165573

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
