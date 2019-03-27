Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C596C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F506206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553724612;
	bh=RlR12HA/PbV/qrZ3RVNoavG9148WAvOXGomEROKJw6E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J96zjry3TzOTq1AkJLkRB8J583HzIVAWXGA3eDe1OeaRd4l7Zm44n/5QGp0Q9YGoO
	 N+2V8vB6oQCqwc5acv00f+Am0Bu5boRBVyU6UG+sCqMEr9hDUjLbhtDYNVL8r+KLCi
	 3vIm3TrMo0hC0WGcJRXhGWns6t/Mdj/AnLIbhjF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfC0WKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfC0WKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:10:10 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553724609;
        bh=RlR12HA/PbV/qrZ3RVNoavG9148WAvOXGomEROKJw6E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FdAu6uGNh29N0yLhC/bzqr0vvBgIdRjp5tob8uIuS6DBL25r03ug0uUxtPDmF1Nho
         QGS6H3w3ts6L8Jv7vcJZ0QDL0KN81l0uMAmcRIAyEKPb5/oYOgaN0bq8riMTLGIGqu
         O4Vx+gev/rdDWxwnOOR9miLvguebGKlr5bFQ1ogo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190326.191049.35928665035979956.davem@davemloft.net>
References: <20190326.191049.35928665035979956.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190326.191049.35928665035979956.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 8c838f53e149871561a9261ac768a9c7071b43d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a9df9e29c2afecf6e3089442d429b377279ca3c
Message-Id: <155372460991.23451.14534421212762372314.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Mar 2019 22:10:09 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Mar 2019 19:10:49 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a9df9e29c2afecf6e3089442d429b377279ca3c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
