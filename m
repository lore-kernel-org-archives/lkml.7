Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A62C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B699B2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfDLHgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:36:54 -0400
Received: from mx.socionext.com ([202.248.49.38]:45649 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfDLHgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:36:54 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Apr 2019 16:36:52 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B99926117D;
        Fri, 12 Apr 2019 16:36:52 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 12 Apr 2019 16:36:52 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 266181A15B7;
        Fri, 12 Apr 2019 16:36:52 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 09931120499;
        Fri, 12 Apr 2019 16:36:52 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v2 0/3] Bugfix and cleanup the timer driver for Milbeaut M10V
Date:   Fri, 12 Apr 2019 16:36:48 +0900
Message-Id: <1555054611-23566-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a bug and cleanup code about timer driver for
Milbeaut M10V.
Since it is difficult to separate, it is integrated into a series.

Changes from v1:
 -Add "Fixes" tag.

Sugaya Taichi (3):
  clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
  clocksource/drivers/timer-milbeaut: Add shutdown function
  clocksource/drivers/timer-milbeaut: Cleanup common register accesses

 drivers/clocksource/timer-milbeaut.c | 66 +++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 19 deletions(-)

-- 
1.9.1

