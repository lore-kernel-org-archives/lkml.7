Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7A2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0DA2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963806;
	bh=AugjpwPcIUqsJmF/AYrlVBLBuSDQk+fEb5wdIVgnD0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fAX6KVuY2bWPlnstjxsOrB3Q9AlH3cnb3RLvKdemc/j1sEfwelFjKCRe1nTAVlgAH
	 sEW7DMtAqJWX3VQSgvaupDmjDB1YJBBv96QRFTxHDCEoQjSQqWuJLaiwma/R6anFPH
	 pxAA8N8BnCIUc+nSvi+KiZjG/c9827xRjh9leduI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfDVTmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbfDVTmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3812175B;
        Mon, 22 Apr 2019 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962172;
        bh=AugjpwPcIUqsJmF/AYrlVBLBuSDQk+fEb5wdIVgnD0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozNBM476gKMkYhUtiCoC3RM84Dhvr11Tmvf5Hetvw08wqvwFCuiDgX830MPz23xmM
         7CpVcgEWjaPPWUQP9jiSuowJSCvWSzWkbXaetho//5AQZe0nrGNfZI785q0i8qNQNR
         RohbtNdS7YjlLAkTMXuklCpUIfaw6Wv6cMMUaLHk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 30/98] usb: dwc3: pci: add support for Comet Lake PCH ID
Date:   Mon, 22 Apr 2019 15:40:57 -0400
Message-Id: <20190422194205.10404-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <felipe.balbi@linux.intel.com>

[ Upstream commit 7ae622c978db6b2e28b4fced6ecd2a174492059d ]

This patch simply adds a new PCI Device ID

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index fdc6e4e403e8..8cced3609e24 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -29,6 +29,7 @@
 #define PCI_DEVICE_ID_INTEL_BXT_M		0x1aaa
 #define PCI_DEVICE_ID_INTEL_APL			0x5aaa
 #define PCI_DEVICE_ID_INTEL_KBP			0xa2b0
+#define PCI_DEVICE_ID_INTEL_CMLH		0x02ee
 #define PCI_DEVICE_ID_INTEL_GLK			0x31aa
 #define PCI_DEVICE_ID_INTEL_CNPLP		0x9dee
 #define PCI_DEVICE_ID_INTEL_CNPH		0xa36e
@@ -305,6 +306,9 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD),
 	  (kernel_ulong_t) &dwc3_pci_mrfld_properties, },
 
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CMLH),
+	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SPTLP),
 	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
 
-- 
2.19.1

