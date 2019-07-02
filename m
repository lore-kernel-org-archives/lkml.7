Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F9DC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94D42146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfGBDiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:38:00 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:12418 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbfGBDiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:38:00 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x623L06G003013;
        Mon, 1 Jul 2019 22:24:22 -0500
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2tfgpetxa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jul 2019 22:24:22 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x623OLAf026729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 1 Jul 2019 22:24:21 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 1 Jul 2019 22:24:20 -0500
Received: from my-pen-rd9.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 1 Jul 2019 22:24:19 -0500
From:   jeyentam <je.yen.tam@ni.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jeyentam <je.yen.tam@ni.com>
Subject: [PATCH 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
Date:   Mon, 1 Jul 2019 20:24:17 -0700
Message-ID: <20190702032417.29014-1-je.yen.tam@ni.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.

Signed-off-by: jeyentam <je.yen.tam@ni.com>
---
 include/linux/pci_ids.h | 62 ++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e86148cb1e..cc1f61575eb4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1027,31 +1027,43 @@
 #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
 #define PCI_DEVICE_ID_SUN_CASSINI	0xabba
 
-#define PCI_VENDOR_ID_NI		0x1093
-#define PCI_DEVICE_ID_NI_PCI2322	0xd130
-#define PCI_DEVICE_ID_NI_PCI2324	0xd140
-#define PCI_DEVICE_ID_NI_PCI2328	0xd150
-#define PCI_DEVICE_ID_NI_PXI8422_2322	0xd190
-#define PCI_DEVICE_ID_NI_PXI8422_2324	0xd1a0
-#define PCI_DEVICE_ID_NI_PXI8420_2322	0xd1d0
-#define PCI_DEVICE_ID_NI_PXI8420_2324	0xd1e0
-#define PCI_DEVICE_ID_NI_PXI8420_2328	0xd1f0
-#define PCI_DEVICE_ID_NI_PXI8420_23216	0xd1f1
-#define PCI_DEVICE_ID_NI_PCI2322I	0xd250
-#define PCI_DEVICE_ID_NI_PCI2324I	0xd270
-#define PCI_DEVICE_ID_NI_PCI23216	0xd2b0
-#define PCI_DEVICE_ID_NI_PXI8430_2322	0x7080
-#define PCI_DEVICE_ID_NI_PCI8430_2322	0x70db
-#define PCI_DEVICE_ID_NI_PXI8430_2324	0x70dd
-#define PCI_DEVICE_ID_NI_PCI8430_2324	0x70df
-#define PCI_DEVICE_ID_NI_PXI8430_2328	0x70e2
-#define PCI_DEVICE_ID_NI_PCI8430_2328	0x70e4
-#define PCI_DEVICE_ID_NI_PXI8430_23216	0x70e6
-#define PCI_DEVICE_ID_NI_PCI8430_23216	0x70e7
-#define PCI_DEVICE_ID_NI_PXI8432_2322	0x70e8
-#define PCI_DEVICE_ID_NI_PCI8432_2322	0x70ea
-#define PCI_DEVICE_ID_NI_PXI8432_2324	0x70ec
-#define PCI_DEVICE_ID_NI_PCI8432_2324	0x70ee
+/* NI-Serial Device IDs */
+#define PCI_VENDOR_ID_NI		  0x1093
+/* NI PXI(e) RS-232 Devices */
+#define PCI_DEVICE_ID_NI_PCI2322	  0xd130
+#define PCI_DEVICE_ID_NI_PCI2324	  0xd140
+#define PCI_DEVICE_ID_NI_PCI2328	  0xd150
+#define PCI_DEVICE_ID_NI_PXI8422_2322	  0xd190
+#define PCI_DEVICE_ID_NI_PXI8422_2324	  0xd1a0
+#define PCI_DEVICE_ID_NI_PXI8420_2322	  0xd1d0
+#define PCI_DEVICE_ID_NI_PXI8420_2324	  0xd1e0
+#define PCI_DEVICE_ID_NI_PXI8420_2328	  0xd1f0
+#define PCI_DEVICE_ID_NI_PXI8420_23216	  0xd1f1
+#define PCI_DEVICE_ID_NI_PCI2322I	  0xd250
+#define PCI_DEVICE_ID_NI_PCI2324I	  0xd270
+#define PCI_DEVICE_ID_NI_PCI23216	  0xd2b0
+#define PCI_DEVICE_ID_NI_PXI8430_2322	  0x7080
+#define PCI_DEVICE_ID_NI_PCI8430_2322	  0x70db
+#define PCI_DEVICE_ID_NI_PXI8430_2324	  0x70dd
+#define PCI_DEVICE_ID_NI_PCI8430_2324	  0x70df
+#define PCI_DEVICE_ID_NI_PXI8430_2328	  0x70e2
+#define PCI_DEVICE_ID_NI_PCI8430_2328	  0x70e4
+#define PCI_DEVICE_ID_NI_PXI8430_23216	  0x70e6
+#define PCI_DEVICE_ID_NI_PCI8430_23216	  0x70e7
+#define PCI_DEVICE_ID_NI_PXI8432_2322	  0x70e8
+#define PCI_DEVICE_ID_NI_PCI8432_2322	  0x70ea
+#define PCI_DEVICE_ID_NI_PXI8432_2324	  0x70ec
+#define PCI_DEVICE_ID_NI_PCI8432_2324	  0x70ee
+#define PCIE_DEVICE_ID_NI_PXIE8430_2328   0x74C2
+#define PCIE_DEVICE_ID_NI_PXIE8430_23216  0x74C1
+/* NI PXI(e) RS-485 Devices */
+#define PCI_DEVICE_ID_NI_PXI8431_4852     0x7081
+#define PCI_DEVICE_ID_NI_PXI8431_4854     0x70DE
+#define PCI_DEVICE_ID_NI_PXI8431_4858     0x70E3
+#define PCI_DEVICE_ID_NI_PXI8433_4852     0x70E9
+#define PCI_DEVICE_ID_NI_PXI8433_4854     0x70ED
+#define PCIE_DEVICE_ID_NI_PXIE8431_4858   0x74C4
+#define PCIE_DEVICE_ID_NI_PXIE8431_48516  0x74C3
 
 #define PCI_VENDOR_ID_CMD		0x1095
 #define PCI_DEVICE_ID_CMD_643		0x0643
-- 
2.17.1

