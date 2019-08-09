Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43844C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15096218BE
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565390110;
	bh=JvZc5/oZku1husOLE+vL+Qh3J74no8FcrOekzeB1z/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GRcqnR5rGiGHGyDh3Jwnu5IU0gUP+FI+qWM+vfEGBzlsobPLj4wW9o04XeKHF6q8t
	 QmPwZWeSuqVs0RdTiAe0zjsIxOVUcFIUKfenBratrgdb3/jSnJfHFcIdhPZ/MFZsi8
	 kcMEMIuxnEl5cnZraB6W6XfdP0Hc3GkoweFYXgic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfHIWfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfHIWfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:35:08 -0400
Subject: Re: [git pull] Input updates for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565390107;
        bh=JvZc5/oZku1husOLE+vL+Qh3J74no8FcrOekzeB1z/E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=juA3i42i6jg+Q8aKBBp9PGdlbnD2cpfXBLiKvEBvOXiXFCmMLo8EXrPXLwJ8rPTr9
         5pII884UyN5SA5x1CPS6Xf9G06i2Y8fSGpJBNa8KTwIkW5qMHzghi+OSrO89EbkfYt
         GvAOxpFICW59zt7zC2CWnIR/uy47lyu8eeBTpQss=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190809222030.GA20442@dtor-ws>
References: <20190809222030.GA20442@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190809222030.GA20442@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 849f5ae3a513c550cad741c68dd3d7eb2bcc2a2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15abf14202a2fe7e5c5fc0e815587f45de4fd500
Message-Id: <156539010732.10715.18232763227175837639.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 22:35:07 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Aug 2019 15:20:30 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15abf14202a2fe7e5c5fc0e815587f45de4fd500

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
