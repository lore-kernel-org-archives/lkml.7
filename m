Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE4C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC142075C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfHEDOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:14:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36722 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfHEDOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:14:17 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D2FDB1A005B;
        Mon,  5 Aug 2019 05:14:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D8681A003B;
        Mon,  5 Aug 2019 05:14:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B7DC240296;
        Mon,  5 Aug 2019 11:14:05 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 0/4] mailbox: imx: bug fix and add support for imx v1 mu
Date:   Mon,  5 Aug 2019 10:51:27 +0800
Message-Id: <1564973491-18286-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change logs:
v4 --> v5:
  - Include Daniel's patch-set into this one.

v3 --> v4:
  - Change "version1.0" to "version 1.0" in the commit log.
  - Update the devicetree binding document to support the imx7ulp mu.
  - Rebase the patch refer to the following bug-fixs patch-set issued
  by Daniel Baluta <daniel.baluta@gmail.com>.
  "https://patchwork.kernel.org/patch/11069479/"

v2 --> v3:
  - Format the patch-set refer to Oleksij's guidance.
  - Init the register array by a simple way recommended by Oleksij.
  - Add Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de> tag.

v1 --> v2:
  - Use to have the register layout linked on probe, suggested by
  Oleksij Rempel <o.rempel@pengutronix.de>.
  - Add Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com> tag.

Richard Zhu (4):
  mailbox: imx: Fix Tx doorbell shutdown path
  mailbox: imx: Clear the right interrupts at shutdown
  dt-bindings: mailbox: imx-mu: add imx7ulp MU support
  mailbox: imx: add support for imx v1 mu

 .../devicetree/bindings/mailbox/fsl,mu.txt         |  2 +
 drivers/mailbox/imx-mailbox.c                      | 74 ++++++++++++++++------
 2 files changed, 56 insertions(+), 20 deletions(-)

-- 
2.7.4

