Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA78B206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfKMSuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:50:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfKMSub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:50:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E46F3206F2;
        Wed, 13 Nov 2019 18:50:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iUxio-0004Td-Ko; Wed, 13 Nov 2019 13:50:30 -0500
Message-Id: <20191113184958.730304611@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 13:49:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John 'Warthog9' Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 0/2] ktest: Updates for 5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: 9b5f852ae20d998a534eea46d54e68584868ae8c


Masanari Iida (1):
      ktest: Fix some typos in sample.conf

Steven Rostedt (VMware) (1):
      ktest: Make default build option oldconfig not randconfig

----
 tools/testing/ktest/ktest.pl    |  2 +-
 tools/testing/ktest/sample.conf | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

