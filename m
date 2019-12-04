Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37790C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D49205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfLDQ6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:58:35 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57048 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfLDQ6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:58:34 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0949720081D;
        Wed,  4 Dec 2019 17:58:33 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0A06200444;
        Wed,  4 Dec 2019 17:58:32 +0100 (CET)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 99FCF205C5;
        Wed,  4 Dec 2019 17:58:32 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 0/2] arm64: dts: lx2160a: add EMDIO1 and phy nodes
Date:   Wed,  4 Dec 2019 18:58:26 +0200
Message-Id: <20191204165828.29893-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds the External MDIO1 node and the two
RGMII PHYs connected to it.

Changes in v2:
 - added a newline between nodes in 2/2
 - moved the WRIOP node (sorted by unit address) in 1/2

Ioana Ciornei (2):
  arm64: dts: lx2160a: add emdio1 node
  arm64: dts: lx2160a: add RGMII phy nodes

 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 28 +++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 11 ++++++++
 2 files changed, 39 insertions(+)

-- 
2.17.1

