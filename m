Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D85AC010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A0B222D1
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbfKEMfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:05 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41962 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388654AbfKEMfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:35:00 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5CB2F2004FE;
        Tue,  5 Nov 2019 13:34:59 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F8E02004F1;
        Tue,  5 Nov 2019 13:34:59 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 129C3205ED;
        Tue,  5 Nov 2019 13:34:59 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 12/12] staging: dpaa2-ethsw: remove control traffic from TODO file
Date:   Tue,  5 Nov 2019 14:34:35 +0200
Message-Id: <1572957275-23383-13-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dpaa2-ethsw driver just gained support for redirecting control
traffic to the CPU and and for Rx/Tx processing.
Remove the associated TODO items.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/TODO | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/TODO b/drivers/staging/fsl-dpaa2/ethsw/TODO
index 4d46857b0b2b..21cac669de45 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/TODO
+++ b/drivers/staging/fsl-dpaa2/ethsw/TODO
@@ -1,13 +1,5 @@
-* Add I/O capabilities on switch port netdevices. This will allow control
-traffic to reach the CPU.
-* Add ACL to redirect control traffic to CPU.
 * Add support for multiple FDBs and switch port partitioning
 * MC firmware uprev; the DPAA2 objects used by the Ethernet Switch driver
 need to be kept in sync with binary interface changes in MC
 * refine README file
 * cleanup
-
-NOTE: At least first three of the above are required before getting the
-DPAA2 Ethernet Switch driver out of staging. Another requirement is that
-dpio driver is moved to drivers/soc (this is required for I/O).
-
-- 
1.9.1

