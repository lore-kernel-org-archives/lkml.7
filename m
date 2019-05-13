Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E7C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38808214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557788122;
	bh=+gf1h8W3KpbcxjSSgm9Ph0okPPUPu3xAtR4MIBwY+GE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Qs7tJp0q1OHfYO9KUj+6EWUW0XrDHyHYsAV/5sCywXYkDK6L76XWQYlBHxA2VYjw5
	 OKK186pp46MwzE8R7gSjOPJgWTVjS3n+XLUGk+Qrl/QWmCqJTH8qS2T3ftE8sBco4w
	 sxh+dZMnWrbeAgn4hGmeAUfmw4xHBKXMLisDqHyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEMWzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfEMWzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:55:18 -0400
Subject: Re: [git pull] Input updates for v5.2-rc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557788117;
        bh=+gf1h8W3KpbcxjSSgm9Ph0okPPUPu3xAtR4MIBwY+GE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SXO1st0eRmtpXiMaMX3eGiFxKzZAsbYVQisFYInBrAJfgghKYDm6C5doVESzy8bRI
         nI9zlIa+FShgaxDP/p8XDARLCgJ0Ej4xoBaakmn7aeWmS6nFNUB/OcQKm9GNwJxvu4
         58QKSdrtfZ/xI2vO1MUZgbHjv4JHZinxzkfOfQ/Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513201235.GA87488@dtor-ws>
References: <20190513201235.GA87488@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513201235.GA87488@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 14e0c7317ed58bcd15af5c3d09818ee0f2e3984c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aed4b28187078565cafbfe86b62f941d580d840
Message-Id: <155778811767.1812.6866475534635795487.pr-tracker-bot@kernel.org>
Date:   Mon, 13 May 2019 22:55:17 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 13:12:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aed4b28187078565cafbfe86b62f941d580d840

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
