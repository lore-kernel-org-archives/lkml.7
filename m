Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCA0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333272084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDLV7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:59:22 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:56083 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726886AbfDLV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 17:59:22 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 Apr 2019 00:59:20 +0300
Received: from farm-1.mtbu.labs.mlnx (farm-1.mtbu.labs.mlnx [10.15.2.31])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x3CLxIq2013185;
        Fri, 12 Apr 2019 17:59:18 -0400
Received: (from asmaa@localhost)
        by farm-1.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x3CLxIV8007352;
        Fri, 12 Apr 2019 17:59:18 -0400
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     minyard@acm.org
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org,
        asmaa@mellanox.com
Subject: [PATCH v1 0/1] Add support for IPMB driver
Date:   Fri, 12 Apr 2019 17:59:15 -0400
Message-Id: <cover.1555105745.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support receiving IPMB requests on a Satellite MC from the BMC.
Once a response is ready, this driver will send back a response
to the BMC via the IPMB channel.

Asmaa Mnebhi (1):
  Add support for IPMB driver

 drivers/char/ipmi/Kconfig        |   8 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmb_dev_int.c | 418 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 427 insertions(+)
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

-- 
2.1.2

