Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B1C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE944207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578351604;
	bh=Ms8pTupz7pkFY+8xjvSHJfoq9bEgDPaHX9YHxUkHDoI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EG0OzpfPihmOpeccXesD3Vfayk3FK9XNtcDxtTtHRSJUch3Eayl4EHxQKkDvgAW0E
	 UZsOAs/OvZ7Md8a68OsUI3W4DwKvT9GA4pMguGJSgYFdg1UTciOdt0xAbjP4c6b+Sk
	 ACq6Oc5WvqnFIVT+bbb2iHFBZAo8r0ZJei44tpUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgAFXAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgAFXAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:00:03 -0500
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578351602;
        bh=Ms8pTupz7pkFY+8xjvSHJfoq9bEgDPaHX9YHxUkHDoI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X9nj/NlHcOFG/GaIYz1p1ujf0kBWJOVDyonEJMxveyzoFNdHeWsOuxEPKnoFdDFM4
         +p4czK8hH6grTzkCjSt2ueR7brKaJ0aT1lM4qTG6w3/4USrmj4XggLOJ2atERgXrGF
         XqdrZLOeqOYdpKx4Vg4pEwHEROUESqsGfvDBcjzY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200106174328.GA16364@linux.intel.com>
References: <20200106174328.GA16364@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200106174328.GA16364@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200106
X-PR-Tracked-Commit-Id: aa4a63dd981682b1742baa01237036e48bc11923
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ae564122f75337d84c41b3963a6e25e8665dfac
Message-Id: <157835160283.29721.16396551026895809746.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jan 2020 23:00:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jan 2020 19:43:28 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200106

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ae564122f75337d84c41b3963a6e25e8665dfac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
