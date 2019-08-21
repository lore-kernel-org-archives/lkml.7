Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC77C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C042339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfHUQri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:47:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:35655 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbfHUQrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:47:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 09:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="181083817"
Received: from unknown (HELO pbossart-mobl3.intel.com) ([10.252.139.119])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2019 09:47:35 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, devicetree@vger.kernel.org,
        Xiubo.Lee@gmail.com, shengjiu.wang@nxp.com,
        linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
        robh+dt@kernel.org, linux-imx@nxp.com, viorel.suman@nxp.com,
        festevam@gmail.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/3] ASoC: SOF: initial support for i.MX8
Date:   Wed, 21 Aug 2019 11:47:27 -0500
Message-Id: <20190821164730.7385-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reviews for these patches took place already on mailing lists and
GitHub, and the code is already integrated in the SOF tree (along with
dependencies already accepted in the i.MX tree)

Changes since v1:
As agreed with Daniel and Mark, this v2 series includes the DT
bindings (Fixed 'compatible' typo in examples)
The SAI/ESAI support was merged separately so dropped from this set.

Daniel Baluta (3):
  dt-bindings: dsp: fsl: Add DSP core binding support
  ASoC: SOF: Add OF DSP device support
  ASoC: SOF: imx: Add i.MX8 HW support

 .../devicetree/bindings/dsp/fsl,dsp.yaml      |  88 ++++
 sound/soc/sof/Kconfig                         |  11 +
 sound/soc/sof/Makefile                        |   4 +
 sound/soc/sof/imx/Kconfig                     |  22 +
 sound/soc/sof/imx/Makefile                    |   4 +
 sound/soc/sof/imx/imx8.c                      | 394 ++++++++++++++++++
 sound/soc/sof/sof-of-dev.c                    | 143 +++++++
 7 files changed, 666 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
 create mode 100644 sound/soc/sof/imx/Kconfig
 create mode 100644 sound/soc/sof/imx/Makefile
 create mode 100644 sound/soc/sof/imx/imx8.c
 create mode 100644 sound/soc/sof/sof-of-dev.c

-- 
2.20.1

