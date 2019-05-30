Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E33DC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580CC24422
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559230089;
	bh=2SeuYcgtjv8C1XOomtfxNINKkXjgtPt1eZWnSUpjXP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SBxZysDxnbhWChaLR4aZHGzTGCqVmXaYWFZlzwkaCfVAjYaDGb6toFl8Jpp3hTHL1
	 6DRVcM2o2UBSnPCY2/rk19pMbdswfdKjkEv2uneFVHqFPZuByiekhuMjrhxCn2w+fR
	 gQCLkea8BOXExCqMIGGxNzITemPTXsU+PU5cXA9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfE3P2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbfE3P2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:28:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D19224422;
        Thu, 30 May 2019 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559230084;
        bh=2SeuYcgtjv8C1XOomtfxNINKkXjgtPt1eZWnSUpjXP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezz2PrC0nPT+sN4uG9SM5ee7Oe4C1+FTh40Oq9Bw7vcBGx1xLHBHttq8zF5r9Ta0V
         pkzE6KlDUpLEOtZRNy4NPGmAvgBNVTSnCkhCmmggnnBr0yzsB2Mvq+JuuM4+58fI06
         L07z/t7jV3RfjPoGcfxfFRCoxzDFgfrjkqQukyrY=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 2/2] fTPM: add documentation for ftpm driver
Date:   Thu, 30 May 2019 11:27:58 -0400
Message-Id: <20190530152758.16628-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530152758.16628-1-sashal@kernel.org>
References: <20190530152758.16628-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic documentation to describe the new fTPM driver.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 Documentation/security/tpm/index.rst        |  1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst

diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
index af77a7bbb0700..15783668644f2 100644
--- a/Documentation/security/tpm/index.rst
+++ b/Documentation/security/tpm/index.rst
@@ -4,4 +4,5 @@ Trusted Platform Module documentation
 
 .. toctree::
 
+   tpm_ftpm_tee
    tpm_vtpm_proxy
diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst b/Documentation/security/tpm/tpm_ftpm_tee.rst
new file mode 100644
index 0000000000000..29c2f8b5ed100
--- /dev/null
+++ b/Documentation/security/tpm/tpm_ftpm_tee.rst
@@ -0,0 +1,31 @@
+=============================================
+Firmware TPM Driver
+=============================================
+
+| Authors:
+| Thirupathaiah Annapureddy <thiruan@microsoft.com>
+| Sasha Levin <sashal@kernel.org>
+
+This document describes the firmware Trusted Platform Module (fTPM)
+device driver.
+
+Introduction
+============
+
+This driver is a shim for a firmware implemented in ARM's TrustZone
+environment. The driver allows programs to interact with the TPM in the same
+way the would interact with a hardware TPM.
+
+Design
+======
+
+The driver acts as a thin layer that passes commands to and from a TPM
+implemented in firmware. The driver itself doesn't contain much logic and is
+used more like a dumb pipe between firmware and kernel/userspace.
+
+The firmware itself is based on the following paper:
+https://www.microsoft.com/en-us/research/wp-content/uploads/2017/06/ftpm1.pdf
+
+When the driver is loaded it will expose ``/dev/tpmX`` character devices to
+userspace which will enable userspace to communicate with the firmware tpm
+through this device.
-- 
2.20.1

