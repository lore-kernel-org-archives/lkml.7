Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E8DFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C86F218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263358;
	bh=y8truStfN1WkIHglGgpdViTzyA8SDBHckzAXehcL7B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kvG71ZSjcjmpnVsOc7ibhEvB13gZkcEvRWdBRDPGA7NPi/MrTU/ZGiQLbMbv/OiX/
	 TvMbt93x/f3K2vLDxXV0z4AC75FfQtQsPMae9aK+BPR0UbaRvhyxOHIYnlzDH7fjro
	 zxqFR+2KiMiGknbuvYnUT/okjvrg9okI1nShMzew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438591AbfJPV7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438228AbfJPV6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:41 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F3021925;
        Wed, 16 Oct 2019 21:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263120;
        bh=y8truStfN1WkIHglGgpdViTzyA8SDBHckzAXehcL7B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rS0dr0bD2id8eYwCvBuIitXlQp47gVrYtuABrW4JINaOpX4T/E+AqfSpI1os8PU1d
         jvqBxGAJ+3DTym4Ae0YuE9QFPvZGH06r1z7HgGa+ZlMvJEM3F4eev5DLjAkw0h8kBC
         Bwy/zfxJDeATpJCbXbtcCflBCIvGvG+z0L2wXefg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 5.3 044/112] mei: me: add comet point (lake) LP device ids
Date:   Wed, 16 Oct 2019 14:50:36 -0700
Message-Id: <20191016214854.808452660@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

commit 4d86dfd38285c83a6df01093b8547f742e3b2470 upstream.

Add Comet Point devices IDs for Comet Lake U platforms.

Cc: <stable@vger.kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20191001235958.19979-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hw-me-regs.h |    3 +++
 drivers/misc/mei/pci-me.c     |    3 +++
 2 files changed, 6 insertions(+)

--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -79,6 +79,9 @@
 #define MEI_DEV_ID_CNP_H      0xA360  /* Cannon Point H */
 #define MEI_DEV_ID_CNP_H_4    0xA364  /* Cannon Point H 4 (iTouch) */
 
+#define MEI_DEV_ID_CMP_LP     0x02e0  /* Comet Point LP */
+#define MEI_DEV_ID_CMP_LP_3   0x02e4  /* Comet Point LP 3 (iTouch) */
+
 #define MEI_DEV_ID_ICP_LP     0x34E0  /* Ice Lake Point LP */
 
 #define MEI_DEV_ID_TGP_LP     0xA0E0  /* Tiger Lake Point LP */
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -96,6 +96,9 @@ static const struct pci_device_id mei_me
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH12_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H_4, MEI_ME_PCH8_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP, MEI_ME_PCH12_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP_3, MEI_ME_PCH8_CFG)},
+
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_LP, MEI_ME_PCH12_CFG)},


