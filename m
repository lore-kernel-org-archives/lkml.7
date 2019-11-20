Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34794C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0292F22529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257420;
	bh=VjXyEzf6lsm69woqW0wxohup8cZsSX1WZPFKLuG6ML8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mNo6TiBbgdqYxVIykx3eWOJVtVVP7kcoRmcIZe11Kr6D/Kys/Ri8QAc1CMynJ/V1w
	 ObQXSGrC6oPt5gPIAekUOCHBeYPV/cw5/Pl5U6sUNjLEzulkC3gl0TCNggY/lFsNoO
	 SMJOwLG3+8D5MDbtJ4VTVILoK184+lZ+KzGd7/PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbfKTNni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:43:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbfKTNng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:36 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C6A22529;
        Wed, 20 Nov 2019 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257415;
        bh=VjXyEzf6lsm69woqW0wxohup8cZsSX1WZPFKLuG6ML8=;
        h=From:To:Cc:Subject:Date:From;
        b=xjQrrIXa6v2xmhFf5IeJA4RZOAiLpjsYQdxnkTtrIuw5Nb8Bjec84w7zYzXNfurqC
         Wx3IMp9fXtg1M1fA5ce2iBIAvKrp+ZE7P+GonQMlyYHCyL391K//SQkelDYmGgZmcz
         Hpuq2o1Qsq3v3pgxk6NEM7fao7fGhT2geLh28qg0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:32 +0800
Message-Id: <20191120134332.16650-1-krzk@kernel.org>
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
 fs/fuse/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 0635cba19971..eb2a585572dc 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -34,7 +34,7 @@ config VIRTIO_FS
 	select VIRTIO
 	help
 	  The Virtio Filesystem allows guests to mount file systems from the
-          host.
+	  host.
 
 	  If you want to share files between guests or with the host, answer Y
-          or M.
+	  or M.
-- 
2.17.1

