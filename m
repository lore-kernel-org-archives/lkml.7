Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BF7C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095182253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576278617;
	bh=gaN6eYA24VQ2L4oceDEHAodf6zAVvVtpngVvrBOoTrQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eH/UTg/6bZlPcCZ9xichv92JRMVW70G3HGqprqKs18Au7zYVf3Pt4MhxcroGl2sS4
	 Squ+eVJ/LOWUKKNPT9N3NgmRrZ6J1txFxt/i1gm54Rg9kzxqgrzClGCsIXLBbUMcMf
	 l0x6udkiFfBM/6p1/M5t/lpUi6JBrBs/hliAnmps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfLMXKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfLMXKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:14 -0500
Subject: Re: [PULL] virtio: cleanups and fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278613;
        bh=gaN6eYA24VQ2L4oceDEHAodf6zAVvVtpngVvrBOoTrQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yGWsIpdGaBv4h8N3hZbouhx07axdCi2cpdIHUhXIG6mGm5oz5Qpag+oju3Lbbpevv
         MDmXaR7qSjjITTBHME1EA+VEFInpjEPqnEDKZHfPTZBWQtTMrTxSgK9nFwMCok0Yts
         O8rIPq39FCebQiZwdYKXcVLHEWNBhovoJj44WxXo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191213093519-mutt-send-email-mst@kernel.org>
References: <20191213093519-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191213093519-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 63b9b80e9f5b2c463d98d6e550e0d0e3ace66033
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd79b5361a6ab3def4a577843ebfecd75b634c8b
Message-Id: <157627861383.1837.13487568040839175464.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:13 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, david@redhat.com, imammedo@redhat.com,
        jasowang@redhat.com, liuj97@gmail.com, mst@redhat.com,
        stable@vger.kernel.org, yuhuang@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 09:35:19 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd79b5361a6ab3def4a577843ebfecd75b634c8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
