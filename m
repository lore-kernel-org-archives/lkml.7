Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A98EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EA3206E1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLBNCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:02:54 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:45810 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727527AbfLBNCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:02:50 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xB2D1rt2015203;
        Mon, 2 Dec 2019 15:01:53 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 7B62D60275; Mon,  2 Dec 2019 15:01:53 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com, Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v1 4/5] dt-bindings: tpm: Add the TPM TIS I2C device tree binding documentaion
Date:   Mon,  2 Dec 2019 15:01:31 +0200
Message-Id: <20191202130132.175382-5-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191202130132.175382-1-amirmizi6@gmail.com>
References: <20191202130132.175382-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

this file aim at documenting TPM TIS I2C related dt-bindings for the I2C PTP based Physical TPM.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 .../bindings/security/tpm/tpm_tis_i2c.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt
new file mode 100644
index 0000000..7d5a69e
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt
@@ -0,0 +1,24 @@
+* Device Tree Bindings for I2C PTP based Trusted Platform Module(TPM)
+
+The TCG defines hardware protocol, registers and interface (based
+on the TPM Interface Specification) for accessing TPM devices
+implemented with an I2C interface.
+
+Refer to the 'I2C Interface Definition' section in 'TCG PC Client
+PlatformTPMProfile(PTP) Specification' publication for specification.
+
+Required properties:
+
+- compatible     : Should be "tcg,tpm_tis-i2c"
+- reg            : Address on the bus
+- tpm-pirq       : Input gpio pin, used for host interrupts
+
+Example (for Raspberry Pie 3 Board with Nuvoton's NPCT75X (2.0)
+-------------------------------------------------------------------
+
+tpm_tis-i2c: tpm_tis-i2c@2e {
+
+       compatible = "tcg,tpm_tis-i2c";
+       reg = <0x2e>;
+       tpm-pirq = <&gpio 24 GPIO_ACTIVE_HIGH>;
+};
-- 
2.7.4

