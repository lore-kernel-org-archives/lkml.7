Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5213CC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF0320880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbfGRKZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:25:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40524 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfGRKZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:25:23 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E1A41A0047;
        Thu, 18 Jul 2019 12:25:22 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 121221A0009;
        Thu, 18 Jul 2019 12:25:22 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CCC9205C7;
        Thu, 18 Jul 2019 12:25:21 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, =kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, paul.olaru@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/3] Add power domain range for MU13 side b / IRQSTR_DSP
Date:   Thu, 18 Jul 2019 13:25:16 +0300
Message-Id: <20190718102519.31855-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds power domain range for MU13 side b and irqsteer in
preparation for adding support for DSP <-> AP IPC communication.

Changes since v1:
	- fixed typo in patch 1/3 commit message
	- enhance commit message for patch 2/3 as per Aisheng's comments
	- only add PD range for mu 13 side B
	
Daniel Baluta (3):
  firmware: imx: scu-pd: Rename mu PD range to mu_a
  firmware: imx: scu-pd: Add mu13 b side PD range
  firmware: imx: scu-pd: Add IRQSTR_DSP PD range

 drivers/firmware/imx/scu-pd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1

