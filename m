Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07FDC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E48208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfGKK7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:59:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58458 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbfGKK7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:59:03 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 13EF9200EA8;
        Thu, 11 Jul 2019 12:59:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44E3F2008EC;
        Thu, 11 Jul 2019 12:58:56 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EAECF402DB;
        Thu, 11 Jul 2019 18:58:48 +0800 (SGT)
From:   shengjiu.wang@nxp.com
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/2] recover the channel swap after xrun
Date:   Thu, 11 Jul 2019 18:49:44 +0800
Message-Id: <cover.1562842206.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

recover the channel swap after xrun

Shengjiu Wang (2):
  ASoC: fsl_esai: Wrap some operations to be functions
  ASoC: fsl_esai: recover the channel swap after xrun

 sound/soc/fsl/fsl_esai.c | 266 ++++++++++++++++++++++++++++-----------
 1 file changed, 193 insertions(+), 73 deletions(-)

Changes in v4
-add more comments and remove read saisr

Changes in V3
- update code sytle.

Changes in v2
- add one patch for wrap operations to functions.
- fix some coding style issue

-- 
2.21.0

