Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AE0C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940D92133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfGEO1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:27:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50574 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfGEO1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:27:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 97296200769;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A83A200761;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 52226204D6;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     ruxandra.radulescu@nxp.com
Subject: [PATCH v2 0/6] staging: fsl-dpaa2/ethsw: code cleanup
Date:   Fri,  5 Jul 2019 17:27:10 +0300
Message-Id: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains various small cleanup patches
for the DPAA2 ethsw driver.

Changes in v2:
 - removed patch "staging: fsl-dpaa2/ethsw: Check notification relevance"
since another patch doing the same thing was merged through net-next

Razvan Stefanescu (6):
  staging: fsl-dpaa2/ethsw: Fix setting port learning/flooding flags
  staging: fsl-dpaa2/ethsw: Add network interface statistics
  staging: fsl-dpaa2/ethsw: Remove netdevice on port probing error
  staging: fsl-dpaa2/ethsw: Add ndo_get_phys_port_name
  staging: fsl-dpaa2/ethsw: Add switch driver documentation
  staging: fsl-dpaa2/ethsw: Add comments to ETHSW_VLAN flags

 .../device_drivers/freescale/dpaa2/overview.rst    |  6 ++++
 MAINTAINERS                                        |  1 +
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            | 39 ++++++++++++++++++----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h            |  4 +++
 4 files changed, 44 insertions(+), 6 deletions(-)

-- 
1.9.1

