Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18A0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3117233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bLes/oum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394104AbfHWJs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:48:26 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16696 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389655AbfHWJsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:48:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5fb6680000>; Fri, 23 Aug 2019 02:48:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 23 Aug 2019 02:48:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 23 Aug 2019 02:48:23 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 09:48:23 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 09:48:22 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 23 Aug 2019 09:48:22 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.65.118]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5fb6630001>; Fri, 23 Aug 2019 02:48:22 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [Patch V7 8/8] arm64: defconfig: Enable tegra XUDC driver
Date:   Fri, 23 Aug 2019 15:17:26 +0530
Message-ID: <1566553646-15338-9-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566553646-15338-1-git-send-email-nkristam@nvidia.com>
References: <1566553646-15338-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566553704; bh=GvS3ClGd1yzL7EF3nm32RdBaX4FqGGNeXUuW2nQkYeo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bLes/oumHW1P1WFWbqRl80zeubTSZz5tyxRQujMRR/3RyUoW6Ql/0XHcHB/T78J1l
         nF+riPsMff5jfJa5imAq6rN89XWhTynj3rdkBioDIo725WievO0isXAJxLhPIqIdAo
         UpURdAXq3bbDKyjE/98M/n8dAxvh0ts3RkyxjWSpbeH5hdkRwLFg4dARCiPWHth5N5
         lZA5bbqbIyrXJzvNxM/N+vaqpVZoxUlJ7hCbUUYt2nySv5XnKS2LJQcGg+wiSYo4Aq
         wuOGjk/H5xBvkpZSvYljMnYYN2I/IY+QWCgM335g1Lq0isPJCSwEdirsMeUdzcv6jy
         N+YHwH/Hc+TTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for Nvidia XUSB device mode controller driver.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 358b163..e9233df 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -600,6 +600,7 @@ CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_USB_RENESAS_USB3=m
+CONFIG_USB_TEGRA_XUDC=m
 CONFIG_TYPEC=m
 CONFIG_TYPEC_HD3SS3220=m
 CONFIG_MMC=y
-- 
2.7.4

