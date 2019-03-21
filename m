Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C02CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF2421916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfCUMKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:10:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37910 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfCUMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:10:14 -0400
Received: from p200300d06f010d00c8d029af8ffc83b7.dip0.t-ipconnect.de ([2003:d0:6f01:d00:c8d0:29af:8ffc:83b7] helo=somnus.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1h6wWQ-00035a-LV; Thu, 21 Mar 2019 13:10:10 +0100
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, fweisbec@gmail.com, peterz@infradead.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 0/4] timers: Fix and improve tracing and documentation
Date:   Thu, 21 Mar 2019 13:09:17 +0100
Message-Id: <20190321120921.16463-1-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch series was developed during investigating timer problems and
timer improvements. It contains a struct documentation fix in tick-sched
and a fixes as well as an improvement for timer tracing.

Thanks,

        Anna-Maria


Anna-Maria Gleixner (4):
  tick-sched: Update tick_sched struct documentation
  timer: Move trace point to get proper index
  timer: Replace deprecated vsprintf pointer extension %pf by %ps
  trace/timer: Improve timer tracing

 include/trace/events/timer.h | 17 +++++++++++------
 kernel/time/tick-sched.h     | 13 ++++++++++---
 kernel/time/timer.c          | 30 +++++++++++++++++-------------
 3 files changed, 38 insertions(+), 22 deletions(-)

-- 
2.20.1

