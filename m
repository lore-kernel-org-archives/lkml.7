Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED2EECE598
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E0E206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="ZaGF8T4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfJMIIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 04:08:14 -0400
Received: from onstation.org ([52.200.56.107]:42484 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbfJMIIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 04:08:12 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id EF29B3E993;
        Sun, 13 Oct 2019 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1570954091;
        bh=Q1QTREatWmcWuGTDA0ElcXg0wWej7VbC08GBo5YXAHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ZaGF8T4vpKrrGUrNyeA8jhpMrE8Jac/Mznd1mgq/5iu9E93q4+or9qbCUNg56fQTH
         LRsBjEtggJ8LKP6wF9jx/lcfICTAs2vtlxecgO/pEC+YJhv7uqqWKraVITbUxduWVU
         1aG3MQBpcKIWHJlxMLOAgoXlcTDN4L1v71+Pn24s=
From:   Brian Masney <masneyb@onstation.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] ARM: qcom: add defconfig items and dts nodes
Date:   Sun, 13 Oct 2019 04:07:59 -0400
Message-Id: <20191013080804.10231-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch series that adds support for the On Chip MEMory
(OCMEM) and msm8974 interconnect support to qcom_defconfig and to
qcom-msm8974.dtsi. The OCMEM driver is already in linux-next and it
looks like the interconnect support should be merged soon:
https://lore.kernel.org/lkml/20191005114605.5279-1-masneyb@onstation.org/

I have some work in progress patches for the HDMI bridge that's found
on the Nexus 5 and this series adds the necessary driver to
qcom_defconfig.

Brian Masney (5):
  ARM: qcom_defconfig: add ocmem support
  ARM: qcom_defconfig: add msm8974 interconnect support
  ARM: qcom_defconfig: add anx78xx HDMI bridge support
  ARM: dts: qcom: msm8974: add ocmem node
  ARM: dts: qcom: msm8974: add interconnect nodes

 arch/arm/boot/dts/qcom-msm8974.dtsi | 79 +++++++++++++++++++++++++++++
 arch/arm/configs/qcom_defconfig     |  5 ++
 2 files changed, 84 insertions(+)

-- 
2.21.0

