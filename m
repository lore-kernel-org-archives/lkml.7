Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B6EC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B691421851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558739718;
	bh=s77OeaK6rWSEpYEzOFwz9k8C2TV+pdjBpjOJ1we/A8A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W5F1oTGLxAY4ifJXlN7yp9NPWv1qQPwdvT/8a3W7uBbYrHOiI+O+1ps+JPiYiIvET
	 KtG9NmA1uZf5YkA0PvrsAHiOmpdJzq3q4FkoQyegtAEuMyegi9Rwdn2AmJwxfll7ZT
	 t9V6ofg0KAti3veLKYEC3gMAWHebp/LREwIGloRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEXXPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 19:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfEXXPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 19:15:17 -0400
Subject: Re: [GIT PULL] Devicetree fixes for 5.2-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558739717;
        bh=s77OeaK6rWSEpYEzOFwz9k8C2TV+pdjBpjOJ1we/A8A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jp3n1x6TaGEMKo1OgBewMQ29YxTZAO6B78sUldcQOV2WA0ILfSZdg1oZiLKhTRNZk
         3jqngKZWgA26JLCTmzcMElzBHHBrCTrhh6E0KTrpdYXwaad3xFUzbFId8otPBecDDH
         tZbSXPNhsPraCneOwjmukaptoLmw8BxSEVSJCvcw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqKUbPziR3dHi15K-uZUH_D-GtodV_LVqw+EhEGLeZZZHA@mail.gmail.com>
References: <CAL_JsqKUbPziR3dHi15K-uZUH_D-GtodV_LVqw+EhEGLeZZZHA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqKUbPziR3dHi15K-uZUH_D-GtodV_LVqw+EhEGLeZZZHA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.2
X-PR-Tracked-Commit-Id: 852d095d16a6298834839f441593f59d58a31978
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7bd3e248bc36451fdbf2a2e3a3c5a23cd0b1f6f
Message-Id: <155873971707.4676.6518496556816213314.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 23:15:17 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 16:01:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7bd3e248bc36451fdbf2a2e3a3c5a23cd0b1f6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
