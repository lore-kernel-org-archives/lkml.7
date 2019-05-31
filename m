Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CFC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61A3269DD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfEaN4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:56:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:54286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfEaN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:56:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 576FCAF10;
        Fri, 31 May 2019 13:56:06 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 5.2-rc3
Date:   Fri, 31 May 2019 15:56:03 +0200
Message-Id: <20190531135603.3403-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.2b-rc3-tag

xen: fixes for 5.2-rc3

It contains one minor cleanup patch and a fix for handling of live
migration when running as Xen guest.

Thanks.

Juergen

 drivers/xen/pvcalls-front.c              |  4 ----
 drivers/xen/xenbus/xenbus.h              |  3 +++
 drivers/xen/xenbus/xenbus_dev_frontend.c | 18 ++++++++++++++++++
 drivers/xen/xenbus/xenbus_xs.c           |  7 +++++--
 4 files changed, 26 insertions(+), 6 deletions(-)

Ross Lagerwall (1):
      xenbus: Avoid deadlock during suspend due to open transactions

YueHaibing (1):
      xen/pvcalls: Remove set but not used variable
