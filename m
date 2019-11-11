Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CC9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A932184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKKOf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:35:26 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48811 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726889AbfKKOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:35:24 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Nov 2019 16:35:17 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id xABEZFh7019158;
        Mon, 11 Nov 2019 09:35:15 -0500
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id xABEZAKl019808;
        Mon, 11 Nov 2019 09:35:10 -0500
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Cc:     lsun@mellanox.com, Shravan Kumar Ramani <sramani@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
Date:   Mon, 11 Nov 2019 09:34:38 -0500
Message-Id: <cover.1573460910.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for Mellanox BlueField TRIO PCIe host controller.
The driver supports multiple TRIO instances and provides a sysfs interface
to allow the user to read/set the L3 cache profile for transactions going
through the TRIO. It also provides an interrupt handler for the TRIO blocks.

Shravan Kumar Ramani (1):
  platform/mellanox: Add Mellanox TRIO driver

 MAINTAINERS                            |   5 +
 drivers/platform/mellanox/Kconfig      |   8 +
 drivers/platform/mellanox/Makefile     |   1 +
 drivers/platform/mellanox/mlxbf-trio.c | 624 +++++++++++++++++++++++++++++++++
 4 files changed, 638 insertions(+)
 create mode 100644 drivers/platform/mellanox/mlxbf-trio.c

-- 
2.1.2

