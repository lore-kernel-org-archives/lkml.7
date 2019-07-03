Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C5C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C2C2189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfGCIXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:23:52 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:50272 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727045AbfGCIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:23:51 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x637KZHH032571;
        Wed, 3 Jul 2019 02:25:20 -0500
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2tgcwpt56c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 02:25:20 -0500
Received: from us-aus-exch1.ni.corp.natinst.com (us-aus-exch1.ni.corp.natinst.com [130.164.68.11])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x637PJaS004425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 3 Jul 2019 02:25:19 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch1.ni.corp.natinst.com (130.164.68.11) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 3 Jul 2019 02:25:19 -0500
Received: from my-pen-rd9.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Wed, 3 Jul 2019 02:25:18 -0500
From:   jeyentam <je.yen.tam@ni.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jeyentam <je.yen.tam@ni.com>
Subject: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
Date:   Wed, 3 Jul 2019 00:25:16 -0700
Message-ID: <20190703072516.34199-1-je.yen.tam@ni.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.

Signed-off-by: jeyentam <je.yen.tam@ni.com>
---
 include/linux/pci_ids.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e86148cb1e..7fad4794789f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1027,7 +1027,9 @@
 #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
 #define PCI_DEVICE_ID_SUN_CASSINI	0xabba
 
+/* NI-Serial Device IDs */
 #define PCI_VENDOR_ID_NI		0x1093
+/* NI PXI(e) RS-232 Devices */
 #define PCI_DEVICE_ID_NI_PCI2322	0xd130
 #define PCI_DEVICE_ID_NI_PCI2324	0xd140
 #define PCI_DEVICE_ID_NI_PCI2328	0xd150
@@ -1052,6 +1054,16 @@
 #define PCI_DEVICE_ID_NI_PCI8432_2322	0x70ea
 #define PCI_DEVICE_ID_NI_PXI8432_2324	0x70ec
 #define PCI_DEVICE_ID_NI_PCI8432_2324	0x70ee
+#define PCIE_DEVICE_ID_NI_PXIE8430_2328	0x74C2
+#define PCIE_DEVICE_ID_NI_PXIE8430_23216	0x74C1
+/* NI PXI(e) RS-485 Devices */
+#define PCI_DEVICE_ID_NI_PXI8431_4852	0x7081
+#define PCI_DEVICE_ID_NI_PXI8431_4854	0x70DE
+#define PCI_DEVICE_ID_NI_PXI8431_4858	0x70E3
+#define PCI_DEVICE_ID_NI_PXI8433_4852	0x70E9
+#define PCI_DEVICE_ID_NI_PXI8433_4854	0x70ED
+#define PCIE_DEVICE_ID_NI_PXIE8431_4858	0x74C4
+#define PCIE_DEVICE_ID_NI_PXIE8431_48516	0x74C3
 
 #define PCI_VENDOR_ID_CMD		0x1095
 #define PCI_DEVICE_ID_CMD_643		0x0643
-- 
2.17.1

