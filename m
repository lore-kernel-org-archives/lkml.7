Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D562C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA732054F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552319719;
	bh=51ykgtrthL6g9BhCpYrj5O2uKBVwGvgk9Tte5rfFcm0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=w9ndElMNfJbOQ9gjnVcW9l5ENsDiehlMfZCBUF7HlR4loIWrS7XL0JyNLksIgRFNq
	 yXoZHCsPG08uPYZZf4Fh36XdYBd40XXBEAbM8dqz7Hwy1W2WkL4KjXLKJT8Hls4i1T
	 NmQc0oUDnTaY0uXtQpFPJSno3b2zK6fnL5jS6mjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfCKPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbfCKPzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:55:15 -0400
Subject: Re: [GIT PULL] security: tpm subsystem updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552319715;
        bh=51ykgtrthL6g9BhCpYrj5O2uKBVwGvgk9Tte5rfFcm0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W4vZQsgr6Yv8Vb66eaAhIgsvcOKaQCw7fRlMmrvMB7lI/nPdlCPX+0WA8+iQYaMaV
         zX3qX68P7CcuPKkMBrXeyHwtvD3T/CAZ/w5KSdm+MmjTaGGG9dxR+v8Fh02X8gxTAq
         BbHkLVfBKu6fIJpaI8LpVVzI6wBNsk6ZlWnHuCcE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1903090946210.12052@namei.org>
References: <alpine.LRH.2.21.1903090946210.12052@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1903090946210.12052@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-tpm
X-PR-Tracked-Commit-Id: 5da10728037afea6743b76afddfdc9950cd711b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5af7f115886f7ec193171e2e49b8000ddd1e7147
Message-Id: <155231971523.7015.3980039974617451530.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Mar 2019 15:55:15 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Mar 2019 09:49:56 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5af7f115886f7ec193171e2e49b8000ddd1e7147

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
