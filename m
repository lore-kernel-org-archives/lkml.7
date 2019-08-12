Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C193D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfHLJjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:39:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57562 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbfHLJje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:39:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC7302002FB;
        Mon, 12 Aug 2019 11:39:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DE28C200112;
        Mon, 12 Aug 2019 11:39:32 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 94EAF205ED;
        Mon, 12 Aug 2019 11:39:32 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 00/10] staging: fsl-dpaa2/ethsw: code cleanup
Date:   Mon, 12 Aug 2019 12:39:08 +0300
Message-Id: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set addresses some of the feedback received on the dpaa2-ethsw
driver: https://lore.kernel.org/patchwork/patch/1113335/.

There are no functional changes but rather just code cleanup.

Ioana Ciornei (10):
  staging: fsl-dpaa2/ethsw: remove IGMP default address
  staging: fsl-dpaa2/ethsw: enable switch ports only on dev_open
  staging: fsl-dpaa2/ethsw: add line terminator to all formats
  staging: fsl-dpaa2/ethsw: remove debug message
  staging: fsl-dpaa2/ethsw: use bool when encoding learning/flooding
    state
  staging: fsl-dpaa2/ethsw: remove unnecessary memset
  staging: fsl-dpaa2/ethsw: remove redundant VLAN check
  staging: fsl-dpaa2/ethsw: reword error message
  staging: fsl-dpaa2/ethsw: register_netdev only when ready
  staging: fsl-dpaa2/ethsw: do not force user to bring interface down

 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c |  44 +++++-----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         | 110 ++++++------------------
 2 files changed, 50 insertions(+), 104 deletions(-)

-- 
1.9.1

