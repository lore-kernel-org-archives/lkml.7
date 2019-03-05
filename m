Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993D2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AB1206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfCEOYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:24:45 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16533 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728352AbfCEOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:24:43 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25EGagS011754;
        Tue, 5 Mar 2019 15:24:26 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qygfxhvth-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Mar 2019 15:24:26 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BB6B31;
        Tue,  5 Mar 2019 14:24:26 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE1CB2CF7;
        Tue,  5 Mar 2019 14:24:25 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019
 15:24:25 +0100
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019 15:24:25
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        "Ludovic Barre" <ludovic.barre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/8] stm32 m4 remoteproc on STM32MP157c
Date:   Tue, 5 Mar 2019 15:24:01 +0100
Message-ID: <1551795849-13672-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STMicrolectronics STM32MP157 MPU are based on a Dual Arm Cortex-A7 core and a
Cortex-M4.
This patchset adds the support of the stm32_rproc driver allowing to control
the M4 remote processor.

Fabien Dessenne (8):
  dt-bindings: stm32: add bindings for ML-AHB interconnect
  dt-bindings: remoteproc: add bindings for stm32 remote processor
    driver
  remoteproc: stm32: add an ST stm32_rproc driver
  ARM: dts: stm32: add m4 remoteproc support on STM32MP157c
  ARM: dts: stm32: declare copro reserved memories on STM32MP157c-ed1
  ARM: dts: stm32: enable m4 coprocessor support on STM32MP157c-ed1
  ARM: dts: stm32: declare copro reserved memories on STM32MP157a-dk1
  ARM: dts: stm32: enable m4 coprocessor support on STM32MP157a-dk1

 .../devicetree/bindings/arm/stm32/mlahb.txt        |  30 +
 .../devicetree/bindings/remoteproc/stm32-rproc.txt |  67 +++
 arch/arm/boot/dts/stm32mp157a-dk1.dts              |  54 ++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |  54 ++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  21 +
 drivers/remoteproc/Kconfig                         |  15 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/stm32_rproc.c                   | 624 +++++++++++++++++++++
 8 files changed, 866 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
 create mode 100644 drivers/remoteproc/stm32_rproc.c

-- 
2.7.4

