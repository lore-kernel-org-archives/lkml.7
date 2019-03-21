Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2607F20830
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfCUOl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:41:29 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:33742 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfCUOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:41:29 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 21 Mar 2019 07:41:22 -0700
Received: from pa-dbc1104.eng.vmware.com (pa-dbc1104.eng.vmware.com [10.162.210.4])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 2E33E40FA9;
        Thu, 21 Mar 2019 07:41:28 -0700 (PDT)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <pv-drivers@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] VMCI/VSOCK: Add maintainers for VMCI, AF_VSOCK and VMCI transport
Date:   Thu, 21 Mar 2019 07:41:28 -0700
Message-ID: <1553179288-40893-1-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the maintainers file to include maintainers for the VMware
vmci driver, af_vsock, and the vsock vmci transport.

Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 MAINTAINERS | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf7..b9714fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16630,6 +16630,14 @@ S:	Maintained
 F:	drivers/scsi/vmw_pvscsi.c
 F:	drivers/scsi/vmw_pvscsi.h
 
+VMWARE VMCI DRIVER
+M:	Jorgen Hansen <jhansen@vmware.com>
+M:	Vishnu Dasa <vdasa@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/misc/vmw_vmci/
+
 VMWARE VMMOUSE SUBDRIVER
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
@@ -16638,6 +16646,18 @@ S:	Maintained
 F:	drivers/input/mouse/vmmouse.c
 F:	drivers/input/mouse/vmmouse.h
 
+VMWARE VSOCK DRIVER (AF_VSOCK) AND VMCI TRANSPORT
+M:	Jorgen Hansen <jhansen@vmware.com>
+M:	Vishnu Dasa <vdasa@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	net/vmw_vsock/af_vsock.c
+F:	net/vmw_vsock/vmci_transport*
+F:	net/vmw_vsock/vsock_addr.c
+F:	include/linux/vm_sockets.h
+F:	include/uapi/linux/vm_sockets.h
+
 VMWARE VMXNET3 ETHERNET DRIVER
 M:	Ronak Doshi <doshir@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
-- 
2.6.2

