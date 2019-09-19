Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492A0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBD821920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568928633;
	bh=7QLoY0TmVf5TxqnRKSt0gr657YgnCczDsDlWsNpHq6I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zwYmMs7bhGahdcFXB1yoP8r8QH+ulXunNXCTviTJQdn7/MANxvzKqNs10to5AfKkC
	 MXrVQ6KuaGUTEPoIw/AcBgtnGKaQY5NPz/S5IIfh5OMQkdEK4MEgFMmGtiSxZ6DKpv
	 OX+HxpVTinwNmbRerL9JLUnEpsk7u1JIfKqoXN8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404850AbfISVac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404830AbfISVab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:30:31 -0400
Subject: Re: [GIT PULL] Mailbox changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568928630;
        bh=7QLoY0TmVf5TxqnRKSt0gr657YgnCczDsDlWsNpHq6I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NafkI1t4rxJ/tuDwle5AQacC81y3YCyQPl7bqmyxlYaylFByX0BznKgDRb4SGgHNx
         KaIfuccbrVEWtdQST55pFuyKVttSuVynVPa2AksOSCoZq/wRI8WLSh04B3AfFuvDXD
         mIjQYi7mzrDdF5wKIadkCdG3chTcbVGvvk4EP4/I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2AFK4G8i765--h0D7h1xcsrhSP2fKzWmcza9OcrdT22g@mail.gmail.com>
References: <CABb+yY2AFK4G8i765--h0D7h1xcsrhSP2fKzWmcza9OcrdT22g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY2AFK4G8i765--h0D7h1xcsrhSP2fKzWmcza9OcrdT22g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-v5.4
X-PR-Tracked-Commit-Id: 556a0964e28c4441dcdd50fb07596fd042246bd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b682242f6012dddf81ef94b7ce5d2ec5ac8f8047
Message-Id: <156892863073.30913.11510470179158516843.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 21:30:30 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Sep 2019 11:00:28 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b682242f6012dddf81ef94b7ce5d2ec5ac8f8047

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
