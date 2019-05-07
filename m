Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86C8C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9362620656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfEGVa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:30:58 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:49647 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726650AbfEGVa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:30:58 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 May 2019 00:30:55 +0300
Received: from farm-1.mtbu.labs.mlnx (farm-1.mtbu.labs.mlnx [10.15.2.31])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x47LUsPb014628;
        Tue, 7 May 2019 17:30:54 -0400
Received: (from asmaa@localhost)
        by farm-1.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x47LUq5e004603;
        Tue, 7 May 2019 17:30:52 -0400
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     minyard@acm.org, wsa@the-dreams.de, vadimp@mellanox.com,
        michaelsh@mellanox.com
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: [PATCH v8 0/1] Add support for IPMB driver
Date:   Tue,  7 May 2019 17:30:49 -0400
Message-Id: <cover.1557264413.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Wolfram, I have addressed your comments.

Asmaa Mnebhi (1):
  Add support for IPMB driver

 Documentation/IPMB.txt           | 103 +++++++++++
 drivers/char/ipmi/Kconfig        |   8 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmb_dev_int.c | 382 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 494 insertions(+)
 create mode 100644 Documentation/IPMB.txt
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

-- 
2.1.2

