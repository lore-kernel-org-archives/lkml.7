Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E583DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C7620842
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551921622;
	bh=94G5+qAdT48E8QNTuwHtnokGg0i3WsM3Ub6M8R6u47Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rXBw7c8iY3kZ0JYcpaeLh17Xl1MnPo8BBpJCQ2p9VFp2eN67ynB+TjqC0SV4zE41j
	 /2ksRKYlk/9fmts4zahQZgbf1hymgZf4gkXg5+oHbXONjypNlA12j21befYbI3CFpO
	 F50+KCGn+i3KzYSKZffZ+U0BXvbuzXG96sd4xNEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfCGBUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfCGBUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:20:17 -0500
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551921617;
        bh=94G5+qAdT48E8QNTuwHtnokGg0i3WsM3Ub6M8R6u47Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bz1yF7UowaACYk0Lxy5mH73mESY/eZbKZ2qRcbkI6EgLJsLRfmoyWMZLNbRh+X9Do
         xfS2wQH1SD+iusCekoUqoOod1OqWf+Nl62aE8r+rj4JKF212BRPRjClr3Sva1jThV0
         zZoPd4gLOLMj3hNsO9/jFV3260ZiD6XZeGHTwVD8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306103423.GA10676@kroah.com>
References: <20190306103423.GA10676@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306103423.GA10676@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.1-rc1
X-PR-Tracked-Commit-Id: 1f08c4a54b7cb62ed6450808c37d06c907f1a2dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e266ca36da7de45b64b05698e98e04b578a88888
Message-Id: <155192161719.31671.18391178591351274256.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 01:20:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 11:34:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e266ca36da7de45b64b05698e98e04b578a88888

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
