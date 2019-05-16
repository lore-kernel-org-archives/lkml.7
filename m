Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A3BC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0EA2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557972317;
	bh=yocQkfCukBWdRxj6GDjIJdKz/yKT0Z6vYKodjve73FA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UYegiZ7xuaz/weUvzzCdXuZahkX9Aq/MHPOq2InZSRD4IJA9uQNQdNqHlvT5cXtLM
	 BEkWSJeV9/tsA05hOjb9yZNxxOHV2GyJl6OF31NNepNplsqbEjZ18yOgrqybk7vUjp
	 zZwBAPaPTHoK1PgUsD5G/YKdRdSdkUiK23VrXc4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfEPCFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 22:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfEPCFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 22:05:16 -0400
Subject: Re: [GIT PULL] xen: fixes and features for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557972316;
        bh=yocQkfCukBWdRxj6GDjIJdKz/yKT0Z6vYKodjve73FA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KlnVbxW2grb7GChG9RydzLdUvej+MOuPcve4vjxd8w7okIS6lQ/Cs77ozzR1KsVzM
         M0myICrAl3EJkC5wzD+vMGHaQSDAAViqKlG9mTcX6Vv8VXSwvTYEwazZ4Y/fMx9MJi
         kL/vyymM2z9tLGjMNzfHlsxoT9dWEY2AA+7b/JM0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190515183850.26413-1-jgross@suse.com>
References: <20190515183850.26413-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190515183850.26413-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.2b-rc1-tag
X-PR-Tracked-Commit-Id: fe846979d30576107aa9910e1820fec3c20e62d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fd09ba68297c967f5ba6bea9c3b444d34f80ee5
Message-Id: <155797231626.20425.6027760486599927607.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 02:05:16 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 20:38:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.2b-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fd09ba68297c967f5ba6bea9c3b444d34f80ee5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
