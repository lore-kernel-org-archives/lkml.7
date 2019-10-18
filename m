Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5AECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A625E222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h10RbwOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442451AbfJRJj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:39:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9754 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442416AbfJRJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:39:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da988720000>; Fri, 18 Oct 2019 02:40:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 18 Oct 2019 02:39:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 18 Oct 2019 02:39:50 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 09:39:50 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 18 Oct 2019 09:39:50 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.66.147]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da988630000>; Fri, 18 Oct 2019 02:39:50 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V11 11/11] arm64: defconfig: Enable tegra XUDC support
Date:   Fri, 18 Oct 2019 15:08:16 +0530
Message-ID: <1571391496-20834-12-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571391496-20834-1-git-send-email-nkristam@nvidia.com>
References: <1571391496-20834-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571391602; bh=ZPIdvzDAWbWZuD+hJ6pUOFt5OlplMYnvPvxj/cog9/c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=h10RbwObtl1zsGzFgAYPk8GN3gK+41alTo1nnTbah5REJDRcukjTxkoC5IIL+8XGf
         pokPXTGealUK4JXbg8JNVGc0WojL6SVShLPrEw/QDKDdwIU53jjfPokck2iNX7SQZu
         i5C8efSxv/A6sPo79LGA4sDiHR2JgTKtGvbfSbrQptFekll6vS10ceTrJJwrQE4oOF
         gK0ANPguNguBNrDsU2hKddqcTjdr2ELjzhDnx3O7kS3yx1ou+DBITd1f6mnGu6FXik
         AOYgdomjbuvjD5uZ4qR+8WRBtJsjon7zpkW1Rlj2onAF6rnq2GXLAlShXFo3Bt7WfH
         JS6fU8tE+eMmw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Nvidia XUSB device mode controller driver and USB GPIO Based
Connection Detection Driver as module.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9adae4..9473406 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -581,6 +581,7 @@ CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
 CONFIG_USB=y
+CONFIG_USB_CONN_GPIO=m
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_TEGRA=y
@@ -606,6 +607,7 @@ CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_USB_RENESAS_USB3=m
+CONFIG_USB_TEGRA_XUDC=m
 CONFIG_TYPEC=m
 CONFIG_TYPEC_HD3SS3220=m
 CONFIG_MMC=y
-- 
2.7.4

