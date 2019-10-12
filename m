Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB33C4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BA620700
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570916419;
	bh=7QptRoOJVZZxmkv/4oVL42Kjq5CXAYmwWeqkKj4mNV4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Xa1IqUNDfnoef2j5rUmXnYHXBDHyhGyRJICksmBh1ZQVlZ2Vkj1OeS934Qet3m1PY
	 pw9waPqLeMp3/TfkJuoSyMIDLvlMtBUVIOY7eHdrQx8ejVrum5Od7niXzYQE0RxJzf
	 P7k7hRpbiuB34ctqIrqptTqTDwJ/iVB8ts66X0xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfJLVkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 17:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbfJLVkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 17:40:07 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570916406;
        bh=7QptRoOJVZZxmkv/4oVL42Kjq5CXAYmwWeqkKj4mNV4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l2a3Ulo+m6sJiEGWU2qjnEUxoeJTB+Vl0AsHmb0KlKevfApZJmzJHci7l9Vb89//r
         VLgiiCmvZQ9rEKCWPzjrb6Z3VVUwmOy2IuqUA0kzUJI/eKVpRlzSajWdlBqh9DZ2JS
         iNp+BA/6NNFn+Y57wxaYIihKreY4klm7PRbgTpZk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1910121307270.18026@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1910121307270.18026@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1910121307270.18026@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.4-rc3
X-PR-Tracked-Commit-Id: cd9e72b80090a8cd7d84a47a30a06fa92ff277d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48acba989ed5d8707500193048d6c4c5945d5f43
Message-Id: <157091640674.3377.12770705217144535996.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 21:40:06 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 13:10:52 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48acba989ed5d8707500193048d6c4c5945d5f43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
