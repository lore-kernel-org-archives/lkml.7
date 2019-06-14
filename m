Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E190FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69F320850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfFNSgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:36:16 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44165 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726140AbfFNSgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:36:15 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 14 Jun 2019 21:36:13 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x5EIaA94028582;
        Fri, 14 Jun 2019 14:36:10 -0400
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x5EIa8NC017811;
        Fri, 14 Jun 2019 14:36:08 -0400
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Date:   Fri, 14 Jun 2019 14:35:52 -0400
Message-Id: <cover.1560536708.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
Replace bitfields with shifts and masks.
Make use of SZ_ and PAGE_ macros.
Read DIMM count from the ACPI table instead of hard-coding the info in
the driver.

Shravan Kumar Ramani (1):
  EDAC, mellanox: Add ECC support for BlueField DDR4

 MAINTAINERS                   |   5 +
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/bluefield_edac.c | 404 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 417 insertions(+)
 create mode 100644 drivers/edac/bluefield_edac.c

-- 
2.1.2

