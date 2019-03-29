Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20EA218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfC2Xoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:44:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43671 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbfC2Xoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:44:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hA1Ad-0007tr-Fd; Fri, 29 Mar 2019 23:44:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2][V2] scsi: pm8001: clean up code and fix spelling mistakes
Date:   Fri, 29 Mar 2019 23:44:21 +0000
Message-Id: <20190329234423.5611-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

This is a re-working of an earlier patch; this version splits the
original patch into two parts, one for the code clean up and the
other to fix spelling mistakes.

Colin Ian King (2):
  scsi: pm8001: clean up structurally dead code when PM8001_USE_MSIX is
    defined
  scsi: pm8001: fix spelling mistake, interupt -> interrupt

 drivers/scsi/pm8001/pm8001_hwi.c  | 11 ++++++-----
 drivers/scsi/pm8001/pm8001_init.c |  4 ++--
 drivers/scsi/pm8001/pm8001_sas.h  |  2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c  | 11 ++++++-----
 4 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.20.1

