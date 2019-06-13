Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB41C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD872217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389875AbfFMPy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:54:29 -0400
Received: from sauhun.de ([88.99.104.3]:41910 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389856AbfFMPyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:54:25 -0400
Received: from localhost (p5486CF99.dip0.t-ipconnect.de [84.134.207.153])
        by pokefinder.org (Postfix) with ESMTPSA id B38484A127B;
        Thu, 13 Jun 2019 17:54:23 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] media: don't check retval after our own assignment
Date:   Thu, 13 Jun 2019 17:54:16 +0200
Message-Id: <20190613155421.16408-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting how many cleanups I find until I can start the
refactorization I really want :) This series fixes a set of unneeded if
checks following the assignment of an errno constant.

Only build tested due to no HW.

Wolfram Sang (4):
  media: cxd2820r_core: don't check retval after our own assignemt
  media: mn88472: don't check retval after our own assignemt
  media: mn88473: don't check retval after our own assignemt
  media: zd1301_demod: don't check retval after our own assignemt

 drivers/media/dvb-frontends/cxd2820r_core.c | 3 +--
 drivers/media/dvb-frontends/mn88472.c       | 6 ++----
 drivers/media/dvb-frontends/mn88473.c       | 6 ++----
 drivers/media/dvb-frontends/zd1301_demod.c  | 3 +--
 4 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.20.1

