Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EEBC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD476206DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575841233;
	bh=Vh+GHB7iBE8UpmI2vtnLLcBJcO6gDTjsLLsxwAQWEfo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bSyJwInMIYRT92s7CVCyBEHFXHGjkZeYjDn57dh2LtVoAdubRU38Djj76HlbYN4G/
	 3fNaj2jJeVsqzbAQi/gdbdxDHrAcSfp0y3TdOx1NjYB9Vl5mhCtW27Wa8YAQfbkRjg
	 vYx4MzlIe5ANBoW/Ov3mS41HDSSbwObMymYkacC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLHVkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 16:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfLHVkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 16:40:31 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575841230;
        bh=Vh+GHB7iBE8UpmI2vtnLLcBJcO6gDTjsLLsxwAQWEfo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KGdRCYRu1oRM3GXjWw1FQHIdcMnmAPFDDlMtRYnsS6vgKIL8A404SAW7+dnWG8eyf
         Rx/8HCHxF4xL4FsozZ5FXm5Zc+q7Iqs5R94flEEFIn9DtizfH4VBLPD5qK/Wfum+jc
         0em1DtERbbewM22k9YPSlbZPbLfW9o+IPl/QxYSw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191208.012032.1258816267132319518.davem@redhat.com>
References: <20191208.012032.1258816267132319518.davem@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191208.012032.1258816267132319518.davem@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 0fc75219fe9a3c90631453e9870e4f6d956f0ebc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95e6ba5133163f8241c9ea2439369cec0452fec6
Message-Id: <157584123092.22418.18372587348625646538.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Dec 2019 21:40:30 +0000
To:     David Miller <davem@redhat.com>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Dec 2019 01:20:32 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95e6ba5133163f8241c9ea2439369cec0452fec6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
