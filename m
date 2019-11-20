Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0030C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890FB22528
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257414;
	bh=Py4LIxOYIGUpBCC1UaHD/YjPJ7FIC1KP3vrfomorWQ4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bhS/wwqR1NzUi238SrqxoNxPQpYCMmveqMnp923+D687wUDYXFaW86h9KM4Wbeej1
	 u5O4EIk8mxNuHih32nxJzQXPRHKjNZ7E5c89OhzSVg8xZGVIIsti9LYPMBjvN2HAUe
	 dWPac9HAeca8mdUjYQYVnw7lBOzDW02QOxrrgoT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfKTNnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbfKTNnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:32 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C8722528;
        Wed, 20 Nov 2019 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257411;
        bh=Py4LIxOYIGUpBCC1UaHD/YjPJ7FIC1KP3vrfomorWQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=uZ2j/2yP5YKrzqRAi0SKT0cOMOxFqg18x8GrUXE2shBcd39pZq47f6yVYUchlQN7R
         W6U8mF5D+RMEmDyCUMcc1owRjIBf9Lngyq7581b0BauJDM8622I+YY0N/45VRPhQPu
         M4XO2LNN5T0G/2nJqfbdvExXvpscW2ku5clXgpms=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:27 +0800
Message-Id: <20191120134327.16582-1-krzk@kernel.org>
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
 fs/nfs/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 295a7a21b774..3edf122b8044 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -147,10 +147,10 @@ config NFS_V4_1_MIGRATION
 	default n
 	help
 	  This option makes the NFS client advertise to NFSv4.1 servers that
-          it can support NFSv4 migration.
+	  it can support NFSv4 migration.
 
-          The NFSv4.1 pieces of the Linux NFSv4 migration implementation are
-          still experimental.  If you are not an NFSv4 developer, say N here.
+	  The NFSv4.1 pieces of the Linux NFSv4 migration implementation are
+	  still experimental.  If you are not an NFSv4 developer, say N here.
 
 config NFS_V4_SECURITY_LABEL
 	bool
-- 
2.17.1

