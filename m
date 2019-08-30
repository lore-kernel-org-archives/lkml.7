Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0020BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDEB2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfH3EKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:10:52 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42719 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725808AbfH3EKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:10:50 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 Aug 2019 07:10:45 +0300
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7U4AiD9010368;
        Fri, 30 Aug 2019 07:10:44 +0300
From:   Parav Pandit <parav@mellanox.com>
To:     linux-kernel@vger.kernel.org, jiri@mellanox.com
Cc:     Parav Pandit <parav@mellanox.com>
Subject: [PATCH internal net-next 0/2] Minor refactor in devlink
Date:   Thu, 29 Aug 2019 23:10:33 -0500
Message-Id: <20190830041035.60581-1-parav@mellanox.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two minor refactors in devlink.

Patch-1 Explicitly defines devlink port index as unsigned int
Patch-2 Uses switch-case to handle different port flavours attributes

Parav Pandit (2):
  devlink: Make port index data type as unsigned int
  devlink: Use switch-case instead of if-else

 include/net/devlink.h |  2 +-
 net/core/devlink.c    | 44 ++++++++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.19.2

