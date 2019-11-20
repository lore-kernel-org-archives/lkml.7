Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F32AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AE72252A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257407;
	bh=yLZmUDRuMDbAygU0kAjP5L+S476KHWlApHpEHCVVFUQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NtHFrGdPyYOVoa4Oy5VN9wNDrwxr6YCOjhA5y9JL+oZHJeaCmV/30jDp49BNj6PvI
	 LjQ/QHCOm446LO1ryK27wg9ldG5GRCnzhlqmJyqu7XGVlDgDbSQrHzTjFJPngarpbT
	 Y2XvqyjR65R34IIC9XG9/sMbOP7h+GxQDB8qLLLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfKTNn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:43:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbfKTNnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:22 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C69D22529;
        Wed, 20 Nov 2019 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257401;
        bh=yLZmUDRuMDbAygU0kAjP5L+S476KHWlApHpEHCVVFUQ=;
        h=From:To:Cc:Subject:Date:From;
        b=NW6UOeL257dh0uwMINgpCBNa0tP8r4bRfbpGGNQkEnm9oBUhZEpJCt91rKlZ/JUfZ
         /3qJK9fo7dpjWVvXlhTP0ghv/R9tx6qRnblrWmHTVgncW07U8F5b+W/R8WZj6E8Tld
         zVggq21x+ZfrykohEknzc7ta7w/7Lz0oKUewPNns=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] qnx6: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:18 +0800
Message-Id: <20191120134318.16470-1-krzk@kernel.org>
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

