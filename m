Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C70120851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551992117;
	bh=DQzHm4skpWyQriYNUEH6chVKGfS/vVwSCDgivYJhmgg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ENuaIZu3B5O+DHUGqY9FM7um4rbnBaZGig1r5zNKGb4V0LawylTDFGNmf03geqA6J
	 XHDKwP93cUZiEOwJvvWsiY1u1aBkrR6VBqD//AttlHhIVtaM0BVosE7M9s3YKvaYbT
	 c9tYbT1Fk2bHrO45eLS8Vrp27eKMkPDAGlICv1zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfCGUzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfCGUzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:55:15 -0500
Subject: Re: [GIT PULL] security subsystem changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551992115;
        bh=DQzHm4skpWyQriYNUEH6chVKGfS/vVwSCDgivYJhmgg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jcnaiEm/AV9XQpGISLDwuXOCWrUKXm/VvdICTtn6rpVjjz9xS1XkJ+blbJRwp5yPZ
         T3R6K2j6/k8veIhuhkg+0Vsdu3weRqkHTd0MLH5F0omifH9WQ9PSDTYJ6vuxYHFqZO
         6sYEKvGEH2ZUzMPHykP3y8IX/ErKuG+FaCcZrowo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1903060540160.19551@namei.org>
References: <alpine.LRH.2.21.1903060540160.19551@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1903060540160.19551@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-general
X-PR-Tracked-Commit-Id: 468e91cecb3218afd684b8c422490dfebe0691bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae5906ceee038ea29ff5162d1bcd18fb50af8b94
Message-Id: <155199211495.24626.7564639083723810854.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 20:55:14 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 05:57:03 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae5906ceee038ea29ff5162d1bcd18fb50af8b94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
