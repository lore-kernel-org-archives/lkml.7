Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215D9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0227620708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKVKW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:22:29 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37435 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKVKW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:22:29 -0500
X-Originating-IP: 92.184.97.94
Received: from localhost (unknown [92.184.97.94])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 546921BF214;
        Fri, 22 Nov 2019 10:22:27 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/8] rtc: fix W=1 warnings and errors
Date:   Fri, 22 Nov 2019 11:22:04 +0100
Message-Id: <20191122102212.400158-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes kerneldoc and unused variables issues detected when
using W=1.

Alexandre Belloni (8):
  rtc: sysfs: fix hctosys_show kerneldoc
  rtc: ds1374: remove unused variable
  rtc: ds1685: remove set but unused variables
  rtc: ds1685: fix build error with make W=1
  rtc: m41t80: remove excess kerneldoc
  rtc: pm8xxx: update kerneldoc for struct pm8xxx_rtc
  rtc: tegra: remove set but unused variable
  rtc: v3020: remove set but unused variable

 drivers/rtc/rtc-ds1374.c |  3 +--
 drivers/rtc/rtc-ds1685.c | 12 +++++-------
 drivers/rtc/rtc-m41t80.c |  1 -
 drivers/rtc/rtc-pm8xxx.c |  2 +-
 drivers/rtc/rtc-tegra.c  |  4 ++--
 drivers/rtc/rtc-v3020.c  |  3 +--
 drivers/rtc/sysfs.c      |  5 ++++-
 7 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.23.0

