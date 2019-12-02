Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A960C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56782146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLBNer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:34:47 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:45898 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727391AbfLBNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:34:46 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xB2DYIRD015797;
        Mon, 2 Dec 2019 15:34:18 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id C66DA6032F; Mon,  2 Dec 2019 15:34:18 +0200 (IST)
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
Subject: [PATCH v2 4/5] dt-bindings: tpm: Add YAML schema for TPM TIS I2C options
Date:   Mon,  2 Dec 2019 15:33:31 +0200
Message-Id: <20191202133332.178110-5-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191202133332.178110-1-amirmizi6@gmail.com>
References: <20191202133332.178110-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Added a YAML schema to support tpm tis i2c realted dt-bindings for the I2c =
PTP based physical layer.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 .../bindings/security/tpm/tpm-tis-i2c.yaml         | 38 ++++++++++++++++++=
++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-=
i2c.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yam=
l b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
new file mode 100644
index 0000000..bb18917
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0=0D
+%YAML 1.2=0D
+---=0D
+$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#=0D
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0D
+=0D
+title: I2C PTP based TPM Device Tree Bindings=0D
+=0D
+maintainers:=0D
+  - Amir Mizinski <amirmizi6@gmail.com>=0D
+=0D
+description:=0D
+  The TCG defines hardware protocol, registers and interface (based=0D
+  on the TPM Interface Specification) for accessing TPM devices=0D
+  implemented with an I2C interface.=0D
+  Refer to the 'I2C Interface Definition' section in 'TCG PC Client=0D
+  PlatformTPMProfile(PTP) Specification' publication for specification.=0D
+  Designed for Raspberry Pie 3 Board with Nuvoton's NPCT75X (2.0)=0D
+  =0D
+properties:=0D
+  compatible:=0D
+    contains:=0D
+      const: tcg,tpm-tis-i2c=0D
+      =0D
+  reg:=0D
+    maxItems: 1=0D
+    =0D
+required:=0D
+  - compatible=0D
+  - reg  =0D
+    =0D
+    =0D
+examples:=0D
+  - |=0D
+    tpm-tis-i2c: tpm-tis-i2c@2e {=0D
+       compatible =3D "tcg,tpm-tis-i2c";=0D
+       reg =3D <0x2e>;=0D
+    };=0D
--=20
2.7.4

