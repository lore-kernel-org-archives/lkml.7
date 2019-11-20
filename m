Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB21C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3782224C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574258454;
	bh=yLZmUDRuMDbAygU0kAjP5L+S476KHWlApHpEHCVVFUQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Gpx5QlaK3XBvX+wFOuEkaia868ElNJJ9v5SDeAeqK7EbTVXSCUAEFV6Ej0Ji/6LO7
	 nlYvuMY//oRHLOXPjyYZyiMeHjhUXchrN752re6/MVlK2NwDcdm9Z+9MTwwZIsF0sa
	 2PdSACVfy5Y3GIWIQTWiHjYvzVCzlIr5JAGxVDeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbfKTOAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:00:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfKTOAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:00:51 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906892235D;
        Wed, 20 Nov 2019 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574258451;
        bh=yLZmUDRuMDbAygU0kAjP5L+S476KHWlApHpEHCVVFUQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LaPr7UMjFhyQargzXuywg080Eb06T9PO6O5mcUiu+MkItG7FDzjHBJ16HWfdV/QiT
         TrZr0vNmTUE28XT41DKfmTNPmkc8eaiCG2q+RahEhAE6Ja1i73myFHVcAwz+tvO34h
         SAPUzujXJloJC8nRxMgnBEdoBslpQTAArrrsB0ZE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>
Subject: [RESEND PATCH] qnx6: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 22:00:44 +0800
Message-Id: <20191120140044.19003-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 fs/qnx6/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx6/Kconfig b/fs/qnx6/Kconfig
index 6a9d6bce1586..5ef679e51ba1 100644
--- a/fs/qnx6/Kconfig
+++ b/fs/qnx6/Kconfig
@@ -7,7 +7,7 @@ config QNX6FS_FS
 	  QNX 6 (also called QNX RTP).
 	  Further information is available at <http://www.qnx.com/>.
 	  Say Y if you intend to mount QNX hard disks or floppies formatted
-          with a mkqnx6fs.
+	  with a mkqnx6fs.
 	  However, keep in mind that this currently is a readonly driver!
 
 	  To compile this file system support as a module, choose M here: the
-- 
2.17.1

