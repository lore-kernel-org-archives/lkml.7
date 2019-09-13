Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3860C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAF721479
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfIMT2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:28:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41826 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbfIMT2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:28:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 90E1A1A016E;
        Fri, 13 Sep 2019 21:28:10 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 843F71A00D0;
        Fri, 13 Sep 2019 21:28:10 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 02806205DB;
        Fri, 13 Sep 2019 21:28:09 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/3] Several SAI fixes
Date:   Fri, 13 Sep 2019 22:28:04 +0300
Message-Id: <20190913192807.8423-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains several fixes for SAI. They are unrelated
but grouped them in a patch series to be easier applied.

Daniel Baluta (1):
  ASoC: fsl_sai: Fix TCSR.TE/RCSR.RE in synchronous mode

Mihai Serban (1):
  ASoC: fsl_sai: Fix noise when using EDMA

Shengjiu Wang (1):
  ASoC: fsl_sai: Fix xMR setting in synchronous mode

 sound/soc/fsl/fsl_sai.c | 31 ++++++++++++++++++++++---------
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.17.1

