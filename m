Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB0BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BE020883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554211944;
	bh=sIOzFyH1Nv9ChLG7HH7VTPOD+q8MRlnhwbYPaHP8GEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AWVuLOCDoklyHndnaNFQNZDO6A0lRKit1rJpnPbZ5jyfetN8p0lLgvWmPOmswCBMv
	 05zdQ68JH9BzBVev/gXBIY8y7crFcjxRp7MQf3a4dCyoMS0cGscWVF+TphMJSMvv00
	 ieNrS4LxZlZaeg/+vHPuUHVemhQk2YE1sVlGx9rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfDBNcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730762AbfDBNcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:32:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916A020883;
        Tue,  2 Apr 2019 13:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554211940;
        bh=sIOzFyH1Nv9ChLG7HH7VTPOD+q8MRlnhwbYPaHP8GEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8CVkmb0kRfk3bl5AGRkhiuAbk1TEoxGCAcbP9yA115DlJFzTss/vSYZWHg2Gm6uc
         OLirLEzJ4CW6gxyA0Jbuw6+rUCRsW7n+m7yLfS5aGbgDlRSmPY2Iqu8/39Ryou4Jsz
         HB6kRD8S+VODvldsgW2HD+vguHaq0X1A0b5f7jgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/4] drivers: base: firmware_loader: add proper SPDX identifiers on files that did not have them.
Date:   Tue,  2 Apr 2019 15:32:02 +0200
Message-Id: <20190402133203.5463-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402133203.5463-1-gregkh@linuxfoundation.org>
References: <20190402133203.5463-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were two files in the firmware_loader code that did not have SPDX
identifiers on them, so fix that up.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/firmware_loader/Kconfig            | 1 +
 drivers/base/firmware_loader/builtin/.gitignore | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index eb15d976a9ea..38f2da6f5c2b 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menu "Firmware loader"
 
 config FW_LOADER
diff --git a/drivers/base/firmware_loader/builtin/.gitignore b/drivers/base/firmware_loader/builtin/.gitignore
index 9c8bdb9fdcc3..166f76b43049 100644
--- a/drivers/base/firmware_loader/builtin/.gitignore
+++ b/drivers/base/firmware_loader/builtin/.gitignore
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 *.gen.S
-- 
2.21.0

