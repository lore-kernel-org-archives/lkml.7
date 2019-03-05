Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAC4C10F09
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5810D21773
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfCEOYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:24:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10771 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728367AbfCEOYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:24:45 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25EHw2r028713;
        Tue, 5 Mar 2019 15:24:29 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhgasy0j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Mar 2019 15:24:29 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A62F438;
        Tue,  5 Mar 2019 14:24:28 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 793672CF8;
        Tue,  5 Mar 2019 14:24:28 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019
 15:24:28 +0100
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019 15:24:27
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
Subject: [PATCH 2/8] dt-bindings: remoteproc: add bindings for stm32 remote processor driver
Date:   Tue, 5 Mar 2019 15:24:03 +0100
Message-ID: <1551795849-13672-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551795849-13672-1-git-send-email-fabien.dessenne@st.com>
References: <1551795849-13672-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree bindings document for the stm32 remoteproc devices.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 .../devicetree/bindings/remoteproc/stm32-rproc.txt | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
new file mode 100644
index 0000000..cc90c88
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
@@ -0,0 +1,67 @@
+STMicroelectronics STM32 Remoteproc
+-----------------------------------
+This document defines the binding for the remoteproc component that loads and
+boots firmwares on the ST32MP family chipset.
+
+Required properties:
+- compatible:	Must be "st,stm32mp1-rproc"
+- reg:		Address ranges of the remote processor dedicated memories.
+		The parent node should provide an appropriate ranges property
+		for properly translating these into bus addresses.
+- resets:	Reference to a reset controller asserting the remote processor.
+- reset-names:	Must be "mcu_rst"
+- st,syscfg-holdboot: Reference to the system configuration which holds the
+		remote processor reset hold boot
+	1st cell: phandle of syscon block
+	2nd cell: register offset containing the hold boot setting
+	3rd cell: register bitmask for the hold boot field
+- st,syscfg-tz: Reference to the system configuration which holds the RCC trust
+		zone mode
+	1st cell: phandle to syscon block
+	2nd cell: register offset containing the RCC trust zone mode setting
+	3rd cell: register bitmask for the RCC trust zone mode bit
+
+Optional properties:
+- interrupt-parent: phandle to the interrupt controller node.
+- interrupts:	Should contain the watchdog interrupt
+- interrupt-names: Must be "wdg"
+- mboxes:	List of phandle and mailbox channel specifiers:
+		- a channel (a) used to communicate through virtqueues with the
+		  remote proc.
+		  Bi-directional channel:
+		      - from local to remote = send message
+		      - from remote to local = send message ack
+		- a channel (b) working the opposite direction of channel (a)
+		- a channel (c) used by the local proc to notify the remote proc
+		  that it is about to be shut down.
+		  Mono-directional channel:
+		      - from local to remote, where ACK from the remote means
+		        that it is ready for shutdown
+- mbox-names:	This property is required if the mboxes property is used.
+		- must be "vq0" for channel (a)
+		- must be "vq1" for channel (b)
+		- must be "shutdown" for channel (c)
+- memory-region: list of phandles to the reserved memory regions associated with
+		the remoteproc device
+		(see ../reserved-memory/reserved-memory.txt)
+- st,syscfg-pdds: Reference to the system configuration which holds the remote
+		processor deep sleep setting
+	1st cell: phandle to syscon block
+	2nd cell: register offset containing the deep sleep setting
+	3rd cell: register bitmask for the deep sleep bit
+- auto_boot:	If defined, when remoteproc is probed, it looks for a default
+		firmware and if it finds some, it loads the firmware and starts
+		the remote processor.
+- recovery:	If defined, remoteproc enables the crash recovery process.
+
+Example:
+	m4_rproc: m4@0 {
+		compatible = "st,stm32mp1-rproc";
+		reg = <0x00000000 0x10000>,
+		      <0x10000000 0x40000>,
+		      <0x30000000 0x40000>;
+		resets = <&rcc MCU_R>;
+		reset-names = "mcu_rst";
+		st,syscfg-holdboot = <&rcc 0x10C 0x1>;
+		st,syscfg-tz = <&rcc 0x000 0x1>;
+	};
-- 
2.7.4

