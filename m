Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D52C2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B928722314
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLSDWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:22:10 -0500
Received: from mxout2.idt.com ([157.165.5.26]:56756 "EHLO mxout2.idt.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfLSDWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:22:10 -0500
Received: from mail6.idt.com (localhost [127.0.0.1])
        by mxout2.idt.com (8.14.4/8.14.4) with ESMTP id xBJ3LvIa009606;
        Wed, 18 Dec 2019 19:21:57 -0800
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail6.idt.com (8.14.4/8.14.4) with ESMTP id xBJ3LvE6025854;
        Wed, 18 Dec 2019 19:21:57 -0800
Received: from vcheng-VirtualBox.localdomain (corpimss2.corp.idt.com [157.165.141.30])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id xBJ3LtW09306;
        Wed, 18 Dec 2019 19:21:55 -0800 (PST)
From:   vincent.cheng.xh@renesas.com
To:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        richardcochran@gmail.com
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Cheng <vincent.cheng.xh@renesas.com>
Subject: [PATCH v2 net-next 0/1] Replace IDT with Renesas and improve version info.
Date:   Wed, 18 Dec 2019 22:21:36 -0500
Message-Id: <1576725697-11828-1-git-send-email-vincent.cheng.xh@renesas.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Cheng <vincent.cheng.xh@renesas.com>

Replacing IDT with Renesas patches has been withdrawn.
This series reworks the version info displayed for the clockmatrix chip.

- Patch 1 Replace pipeline, bond, rev, csr, irq with HW rev and 
  OTP config select.

Fixes: 3a6ba7dc7799 ("ptp: Add a ptp clock driver for IDT ClockMatrix.")

Changes since v1:
 - Remove Patch 1/3 Add Replace idt with renesas in dt-bindings
 - Remove Patch 2/3 Replaces IDT references with Renesas
 - Patch 3/3 becomes patch 1/1

Vincent Cheng (1):
  ptp: clockmatrix: Rework clockmatrix version information.

 drivers/ptp/idt8a340_reg.h    |  2 ++
 drivers/ptp/ptp_clockmatrix.c | 77 ++++++++-----------------------------------
 2 files changed, 15 insertions(+), 64 deletions(-)

-- 
2.7.4

