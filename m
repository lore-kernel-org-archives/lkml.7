Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCC0C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA3F2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554233607;
	bh=5KxC84bwbVbpAolFqKP5oU9aKIFes2h5919zu1PKdaY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tZnJaF3j8JgpYF0tZ1NpI/HX6XRxcI9Hy2PN7x56SRXPy2MkE1Wzjl4nWxIgx6+gb
	 JliaqJXzDgUdBLEp25hxwuWW5f2bAHfwylmw0Teq1tymtM+O6lgx9bjfIFRJtyaNcl
	 eRT7VNE558dVwcpeLid5blDyggm7TF7Krk9o/YGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfDBTd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfDBTd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:33:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A3EC2070D;
        Tue,  2 Apr 2019 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554233605;
        bh=5KxC84bwbVbpAolFqKP5oU9aKIFes2h5919zu1PKdaY=;
        h=From:To:Cc:Subject:Date:From;
        b=n+Qu8qQ77Zhj0SV60h8rfBOmeeeY1Ok+PLkL/+t6lmWx6277B2Tmky2C0EUSM+WOo
         cSlPHURMqM0Dbk++DTV9GOskQSQPKz6RHIk/vfnaOd6B1i5eCQf+viX4h9ioF4SbgL
         WWgebZMub6pvR1JBuU7LU0Uuh1mjw1gDCAl/R9k0=
From:   Sasha Levin <sashal@kernel.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     linux-kernel@microsoft.com, bryankel@microsoft.com,
        thiruan@microsoft.com, suredd@microsoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 1/2] ftpm: dt-binding: add dts documentation for fTPM driver
Date:   Tue,  2 Apr 2019 15:33:15 -0400
Message-Id: <20190402193316.15144-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bindings/security/tpm/tpm_ftpm_tee.txt          | 13 +++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt         |  1 +
 2 files changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
new file mode 100644
index 000000000000..20fca67a56c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
@@ -0,0 +1,13 @@
+Required properties:
+- compatible: should be "microsoft,ftpm"
+- linux,sml-base: 64-bit base address of the reserved memory allocated
+		  for the firmware event log
+- linux,sml-size: size of the memory allocated for the firmware event log
+
+Example:
+
+tpm@0 {
+	compatible = "microsoft,ftpm";
+	linux,sml-base = <0x0 0xC0000000>;
+	linux,sml-size = <0x10000>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8162b0eb4b50..902798bcb9a5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -249,6 +249,7 @@ micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 microcrystal	Micro Crystal AG
 micron	Micron Technology Inc.
+microsoft	Microsoft Corporation
 mikroe		MikroElektronika d.o.o.
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
-- 
2.19.1

