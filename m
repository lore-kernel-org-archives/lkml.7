Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCAEC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E87E206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLWTnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 14:43:25 -0500
Received: from [66.170.99.2] ([66.170.99.2]:32238 "EHLO
        sid-build-box.eng.vmware.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726903AbfLWTm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:42:57 -0500
Received: by sid-build-box.eng.vmware.com (Postfix, from userid 1000)
        id F186DBA17B0; Tue, 24 Dec 2019 01:07:14 +0530 (IST)
From:   Siddharth Chandrasekaran <csiddharth@vmware.com>
To:     torvalds@linux-foundation.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org, jannh@google.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        siddharth@embedjournal.com,
        Siddharth Chandrasekaran <csiddharth@vmware.com>
Subject: [PATCH 4.14 0/2] Backport readdir sanity checking patches
Date:   Tue, 24 Dec 2019 01:06:25 +0530
Message-Id: <cover.1577128778.git.csiddharth@vmware.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset is a backport of upstream commits that makes getdents() and
getdents64() do sanity checking on the pathname that it gives to user
space.

Sid

Linus Torvalds (2):
  Make filldir[64]() verify the directory entry filename is valid
  filldir[64]: remove WARN_ON_ONCE() for bad directory entries

 fs/readdir.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

-- 
2.7.4

