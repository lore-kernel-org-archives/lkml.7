Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5E9C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF551208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbfFYTOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:14:10 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48073 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731791AbfFYTOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:14:10 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 25 Jun 2019 22:14:06 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x5PJE4b8024022;
        Tue, 25 Jun 2019 15:14:04 -0400
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x5PJE2jI001851;
        Tue, 25 Jun 2019 15:14:02 -0400
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        Joe Perches <joe@perches.com>,
        James Morse <james.morse@arm.com>,
        Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Date:   Tue, 25 Jun 2019 15:13:58 -0400
Message-Id: <cover.1561489514.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
Use FIELD_GET and GENMASK instead of shifting/masking using separate macros

Shravan Kumar Ramani (1):
  EDAC, mellanox: Add ECC support for BlueField DDR4

 MAINTAINERS                   |   5 +
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/bluefield_edac.c | 356 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 369 insertions(+)
 create mode 100644 drivers/edac/bluefield_edac.c

-- 
2.1.2

