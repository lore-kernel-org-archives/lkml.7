Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB20EC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 23:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B1B2089F
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 23:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564962303;
	bh=8RlQdNAcpQtFvyZL9AJ9supFQk2ldzqSGYCUn2mebXU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qPM2NXon7/kDrptPlyNpryCTIipbVtU3uirXQW2k5E1AWfIMi1LOjeuqC3G9YrYk1
	 Fv82wf8GKYT9YpBMbQ7vnoqSAsT17rIrh0u2iZr2I2fxiXK4S4FhWH47eejv9Py0Uv
	 GlGIczwUnhjAfUAOZxnW25hUjYJKco7UPnYvKPwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfHDXpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 19:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfHDXpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 19:45:02 -0400
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564962301;
        bh=8RlQdNAcpQtFvyZL9AJ9supFQk2ldzqSGYCUn2mebXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mj3zyrmXGdhmeuBviKobHbebb3qsldE/vNr0BWp8kQpLKXQmWefy8nEn9s2h/kdY5
         Fe5fJWNSuQEV8rhsVoZ1LFofY80i+nVRS0EdJrC1kT/2z2MH6+xhNW5Q9vqWSGfrPO
         l9lMkgymiF/6i3mOR6fiPQYPc+SfYNvxFDOeqsS8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190804221450.n62l3fwehjt3nyit@linux.intel.com>
References: <20190804221450.n62l3fwehjt3nyit@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190804221450.n62l3fwehjt3nyit@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20190805
X-PR-Tracked-Commit-Id: fa4f99c05320eb28bf6ba52a9adf64d888da1f9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6831a89bcaf351cf41b3a5922640c89beaaf9eb
Message-Id: <156496230136.14797.607405632963435837.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Aug 2019 23:45:01 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        gmazyland@gmail.com, nayna@linux.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Aug 2019 01:14:50 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190805

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6831a89bcaf351cf41b3a5922640c89beaaf9eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
