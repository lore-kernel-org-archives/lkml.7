Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFDDC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1182C2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555788326;
	bh=g/Zwx7pQrx7l4Q19vwZnWqlJajfUT8LTJ6XyA+j94Hs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gAiLcHLgMFeiQPelAmPS92WByhnnL9M0dUw9hyQK8XnKP8anS5ZEGJkU/5XNwiqFI
	 9xhUgE8Aez3gArCa4f0zybrjaTG+ZETE20pC3FvRbochD49lmlinkO/rECzj8mdToO
	 OZQ1KCv4NDPz8HbIUMGgwmjNq9z/TyU5+7pzmUqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfDTTZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbfDTTZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:25:05 -0400
Subject: Re: [GIT PULL] sound fixes for 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555788305;
        bh=g/Zwx7pQrx7l4Q19vwZnWqlJajfUT8LTJ6XyA+j94Hs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gM7FNhfoEOS9qaBxQ8xhJmgv3jzRKpumcsIbSwpGQ2cI5gQyNuesFy/tTH+uV8Udm
         Qh3CgMqS6EmLxBzpSyerHSA/6U62Dct8a97ZV9uEvn8FMeVt7hBNYduDxI1BSu6xoq
         aW1bQHFqshlwGQZ/nQjNCyxojXz0upyzrXScaatc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9z9nn7e.wl-tiwai@suse.de>
References: <s5hv9z9nn7e.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9z9nn7e.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.1-rc6
X-PR-Tracked-Commit-Id: b26e36b7ef36a8a3a147b1609b2505f8a4ecf511
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b609f1e26f36c43e2dcdebe81e1d612705920d4
Message-Id: <155578830524.28386.5255115973740884658.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 19:25:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Apr 2019 09:35:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b609f1e26f36c43e2dcdebe81e1d612705920d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
