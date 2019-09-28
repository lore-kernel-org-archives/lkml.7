Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5618C32793
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 15:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDEC20880
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569686122;
	bh=GeiE4kV1blhxJ24Hjrk4Swgoj1rM3hHX8c7R62jbioI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KYUaryHJhhN+3gxN7A1NDMisuQvMdKWYm2KSVkbzLa2yNJFCRDBsGkBmse/n8mcn8
	 AnRiS5z90WgYY04KP8+Yq+b4NCo9SQGK8rA9F01cZDwbi1FPmDW3ca/P5JdmqR19Wy
	 DMrRrB5LOT8gtnBFwnwfZ6w6rgjl20l83J/4P5Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfI1PzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 11:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbfI1PzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 11:55:21 -0400
Subject: Re: [GIT PULL][SECURITY] Kernel lockdown patches for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569686121;
        bh=GeiE4kV1blhxJ24Hjrk4Swgoj1rM3hHX8c7R62jbioI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2ZS0e0gw9drWS055zZvDN8ZxzklNdl/Rr15LZksm4H4GjvLAkt5vTTOx58DcDyATD
         YsMXwp9eHIYuGDpiJX8ajO/i4gWq9yeUMsT+WF1CfvFBQ+dbe34dSaWolPXrOV+QYO
         KKSgVyVe4juh8PkKzc+GuQ54fIy17UBs1JcfYqyA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1909101402230.20291@namei.org>
References: <alpine.LRH.2.21.1909101402230.20291@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1909101402230.20291@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-lockdown
X-PR-Tracked-Commit-Id: 45893a0abee6b5fd52994a3a1095735aeaec472b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aefcf2f4b58155d27340ba5f9ddbe9513da8286d
Message-Id: <156968612114.18748.11996570499201074330.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Sep 2019 15:55:21 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Sep 2019 15:01:12 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lockdown

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aefcf2f4b58155d27340ba5f9ddbe9513da8286d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
