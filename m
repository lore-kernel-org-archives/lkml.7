Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3195C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8E72145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563306025;
	bh=LnphcGj+XDdWqFhpZythH4qtCoyKQNlrP3cFlv6jdtk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CZxLUxeWWNQEJK8nHeqsK/qK6lDiLUp/MXJewbJ4NpHFme+TkWaA36DLoV/CqlKq+
	 NQgjIKGIkK6uyukczss8h4b2K4atYjbGohD8aNiQf1n451L7JWgNUwDVkHS8lSlhzL
	 yiT/qxzKMsaOxzjKexmxcc5A6j+W4eKzQdA7oOEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbfGPTkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388901AbfGPTkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:40:20 -0400
Subject: Re: [GIT PULL for v5.3-rc1] docs: addition of a large set of files to
 the documentation body
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563306020;
        bh=LnphcGj+XDdWqFhpZythH4qtCoyKQNlrP3cFlv6jdtk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cWzojXD4MbadwjebxlskJocU4iq2EX9URFJ0t/oA4OE2lN1jRq/51VwXtNZxhlQg7
         DepSA7o/e9IlvlmKiva9ecq54cmJJC2AJQ5WNgHlhNOgGLGzj16c7N2Atqy0AYfDLU
         hcD9A8rWlgw4tvGavL7RC6D55UOUNDghqYVUw4vQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190716080122.28a17014@coco.lan>
References: <20190716080122.28a17014@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190716080122.28a17014@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git
 tags/docs/v5.3-1
X-PR-Tracked-Commit-Id: 168869492e7009b6861b615f1d030c99bc805e83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c309b6f24222246c18a8b65d3950e6e755440865
Message-Id: <156330602041.24987.8495566131446582190.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 19:40:20 +0000
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Jul 2019 08:01:22 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git tags/docs/v5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c309b6f24222246c18a8b65d3950e6e755440865

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
