Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EA3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6576E23405
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103366;
	bh=9XwVY0/RWITjmF5+saF61bNfNg4hwnNLiBiyFMWHHcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2gP3JC9yfxqObSCplCCgXw4ByuEERfi+ZfKiqaPIxI2PVhvYPa2j2bTo0Mom2fl2R
	 vY15OL665PlXJj4VR3IbiMai3N849DOFJi9ucELKCLDfGpglaSk0K33EsMdYzAeKtF
	 KC2lbxHGAO9vKtcSoE+LmvmPuGxATr7Civ+vhlBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfH2SPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbfH2SO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:14:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6926233FF;
        Thu, 29 Aug 2019 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102496;
        bh=9XwVY0/RWITjmF5+saF61bNfNg4hwnNLiBiyFMWHHcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LyUn0fyF/M0jUPmnksCh1re+AlT96Mos9q80aKWiyNNiWPhI4DpB0MckXwQ9GdaYL
         b9ChIC6VzoC3TjOjfxILVPPnJn0WCW8CS86AV6JIqj57ZefShFuZ4HsFtymPA7G/ni
         JfxAbPtqRkIXwKEmH5ty7k2XckAI/gAT3u7Znwzw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Even Xu <even.xu@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 49/76] HID: intel-ish-hid: ipc: add EHL device id
Date:   Thu, 29 Aug 2019 14:12:44 -0400
Message-Id: <20190829181311.7562-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even Xu <even.xu@intel.com>

[ Upstream commit b640be5bc8e4673dc8049cf74176ddedecea5597 ]

EHL is a new platform using ishtp solution, add its device id
to support list.

Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
index 1065692f90e20..5792a104000a9 100644
--- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
+++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
@@ -24,6 +24,7 @@
 #define ICL_MOBILE_DEVICE_ID	0x34FC
 #define SPT_H_DEVICE_ID		0xA135
 #define CML_LP_DEVICE_ID	0x02FC
+#define EHL_Ax_DEVICE_ID	0x4BB3
 
 #define	REVISION_ID_CHT_A0	0x6
 #define	REVISION_ID_CHT_Ax_SI	0x0
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 17ae49fba920f..8cce3cfe28e08 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -33,6 +33,7 @@ static const struct pci_device_id ish_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ICL_MOBILE_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, SPT_H_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CML_LP_DEVICE_ID)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, EHL_Ax_DEVICE_ID)},
 	{0, }
 };
 MODULE_DEVICE_TABLE(pci, ish_pci_tbl);
-- 
2.20.1

