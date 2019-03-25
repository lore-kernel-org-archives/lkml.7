Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC88FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63CA20883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfCYDFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:05:42 -0400
Received: from mx.socionext.com ([202.248.49.38]:52827 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbfCYDFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:05:41 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Mar 2019 12:05:39 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 5E607180085;
        Mon, 25 Mar 2019 12:05:39 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 25 Mar 2019 12:05:39 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id EE9084031A;
        Mon, 25 Mar 2019 12:05:38 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D2752120459;
        Mon, 25 Mar 2019 12:05:38 +0900 (JST)
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
Subject: [PATCH 0/3] Bugfix and cleanup the timer driver for Milbeaut M10V
Date:   Mon, 25 Mar 2019 12:05:46 +0900
Message-Id: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a bug and cleanup code about timer driver for
Milbeaut M10V.
Since it is difficult to separate, it is integrated into a series.

Sugaya Taichi (3):
  clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
  clocksource/drivers/timer-milbeaut: Add shutdown function
  clocksource/drivers/timer-milbeaut: Cleanup common register accesses

 drivers/clocksource/timer-milbeaut.c | 66 +++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 19 deletions(-)

-- 
1.9.1

