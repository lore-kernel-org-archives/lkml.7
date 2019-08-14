Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D19C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4187D2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfHNI3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:29:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48156 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfHNI3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:29:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 35F7C1A0142;
        Wed, 14 Aug 2019 10:29:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2993D1A006B;
        Wed, 14 Aug 2019 10:29:13 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E29C2060E;
        Wed, 14 Aug 2019 10:29:12 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, viorel.suman@nxp.com, linux-imx@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/2] Add support for i.MX8QM
Date:   Wed, 14 Aug 2019 11:29:09 +0300
Message-Id: <20190814082911.665-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QM SOC integrates 6 SAI instances. Register map is similar with
i.MX6 series.

Daniel Baluta (2):
  ASoC: fsl_sai: Add support for imx8qm
  ASoC: dt-bindings: Introduce compatible string for imx8qm

 Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
 sound/soc/fsl/fsl_sai.c                             | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.17.1

