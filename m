Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05996C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95552133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfF1POI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:14:08 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:37009 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726880AbfF1POI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:14:08 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x5SFDURE004544;
        Fri, 28 Jun 2019 18:13:30 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20053)
        id 5D2E061FCD; Fri, 28 Jun 2019 18:13:30 +0300 (IDT)
From:   Oshri Alkoby <oshrialkoby85@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, oshrialkoby85@gmail.com,
        oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        dan.morav@nuvoton.com, tomer.maimon@nuvoton.com
Subject: [PATCH v2 1/2] dt-bindings: tpm: add the TPM I2C PTP device tree binding documentation
Date:   Fri, 28 Jun 2019 18:13:26 +0300
Message-Id: <20190628151327.206818-2-oshrialkoby85@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190628151327.206818-1-oshrialkoby85@gmail.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Oshri Alkoby <oshrialkoby85@gmail.com>
---
 .../bindings/security/tpm/tpm-i2c-ptp.txt     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt b/Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt
new file mode 100644
index 000000000000..8b0207fdf3e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt
@@ -0,0 +1,24 @@
+* Device Tree Bindings for I2C PTP based Trusted Platform Module(TPM)
+
+The TCG defines a hardware protocol, registers and interface (based
+on the TPM Interface Specification) for accessing TPM devices
+implemented with an I2C interface.
+
+Refer to the 'I2C Interface Definition' section in 'TCG PC Client
+PlatformTPMProfile(PTP) Specification' publication for specification.
+
+Required properties:
+
+- compatible     : Should be "tcg,tpm_i2c_ptp"
+- reg            : Address on the bus
+- tpm-pirq       : Input gpio pin, used for host interrupts
+
+Example (for Raspberry Pie 3 Board with Nuvoton's NPCT75X (2.0)
+-------------------------------------------------------------------
+
+tpm_i2c_ptp: tpm_i2c_ptp@2e {
+
+	compatible = "tcg,tpm_i2c_ptp";
+	reg = <0x2e>;
+	tpm-pirq = <&gpio 24 GPIO_ACTIVE_HIGH>;
+};
-- 
2.18.0

