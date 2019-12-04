Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6442CC2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B6F20803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfLDK6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:58:32 -0500
Received: from inva021.nxp.com ([92.121.34.21]:49094 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfLDK6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:58:31 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 165092001BB;
        Wed,  4 Dec 2019 11:58:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B58ED20117B;
        Wed,  4 Dec 2019 11:58:26 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 210A4402AD;
        Wed,  4 Dec 2019 18:58:22 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: [Patch v2 0/5] Add dts support for various NXP boards
Date:   Wed,  4 Dec 2019 16:28:13 +0530
Message-Id: <1575457098-18368-1-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add dts support for various boards like 1028ardb,
1028aqds, ls1046afrwy, ls1046ardb and ls1088ardb.
QSPI dts nodes are sorted alphabeticaly and dtsi nodes are sorted
addresswise.

Patch 1 adds support for ls1028ardb and ls1028aqds.

Patch 2 adds support for ls1046afrwy.

Patch 3 adds support for ls1046ardb.

Patch 4 adds support for ls2080a.

Patch 5 adds support for ls1088ardb and ls1088aqds.

Ashish Kumar (4):
  arm64: dts: ls1028a: Add FlexSPI support
  arm64: dts: ls1046a: Update QSPI node properties of ls1046ardb
  arm64: dts: ls208x: Remove non-compatible driver device from qspi node
  arm64: dts: ls1088a: Add QSPI support for NXP LS1088

Kuldeep Singh (1):
  arm64: dts: ls1046a: Add QSPI node for ls1046afrwy

 .../boot/dts/freescale/fsl-ls1028a-qds.dts    | 15 ++++++++++++
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 15 ++++++++++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 13 ++++++++++
 .../boot/dts/freescale/fsl-ls1046a-frwy.dts   | 14 +++++++++++
 .../boot/dts/freescale/fsl-ls1046a-rdb.dts    | 16 ++++++-------
 .../boot/dts/freescale/fsl-ls1088a-qds.dts    | 24 +++++++++++++++++++
 .../boot/dts/freescale/fsl-ls1088a-rdb.dts    | 24 +++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 13 ++++++++++
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  2 +-
 9 files changed, 127 insertions(+), 9 deletions(-)

-- 
2.17.1

