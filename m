Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14F0C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9F320881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbfEWWmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:42:44 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34031 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfEWWmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:42:44 -0400
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E2306240004;
        Thu, 23 May 2019 22:42:30 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/2] kselftest: fix rtctest timeout
Date:   Fri, 24 May 2019 00:42:21 +0200
Message-Id: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
test") wrongly assumed that no individual test would run for more than
30 seconds and this silently broke rtctest.

Please consider the following patches as fixes for v5.2 to avoid having
any non working release.

Thanks,

Alexandre Belloni (2):
  selftests/harness: Allow test to configure timeout
  selftests: rtc: rtctest: specify timeouts

 tools/testing/selftests/kselftest_harness.h | 17 ++++++++++++-----
 tools/testing/selftests/rtc/rtctest.c       |  6 +++---
 2 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.21.0

