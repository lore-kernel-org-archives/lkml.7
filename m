Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F48DC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674AD224D2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257120;
	bh=joeQUvpa848bRQQSTd9rF7e8Ky1xfimuVp8DppI0B9M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Y2eaOxrx54yM62AwPzhgrRVMXdMmlRURoIGOCJ84TlPo1tC+s62lZAHRaC3A8ddXs
	 T6T6iVdJU7Da+ZtNkB6T4g0Ap9GxqovGGMEgNPwg3GAxOmtFdqXKlOxbqx4BEX3O7R
	 QTaE8rC9D90V8AuAFpGtPQnkZyUEY1GGYJVkri7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfKTNii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbfKTNie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:34 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD22224DF;
        Wed, 20 Nov 2019 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257114;
        bh=joeQUvpa848bRQQSTd9rF7e8Ky1xfimuVp8DppI0B9M=;
        h=From:To:Cc:Subject:Date:From;
        b=kVNw9ioxOyfwo27snHqArXEZeZpjV8tLl/zrE/UzD3UpyDFLsUMExedUp5ZtrhF22
         XpjSJ95mR6+mZ8w5pkCTM5aV/Ie1TenpY8HSTHXo1HGJq4NZtRSGrp4qn/4srm1vxE
         XgDxzgrL3aW8V3sks7iG0tSbyOf196IoBx4PKY8E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:30 +0800
Message-Id: <20191120133830.13021-1-krzk@kernel.org>
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
 drivers/virtio/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 078615cf2afc..29896374bf1b 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -29,17 +29,17 @@ config VIRTIO_PCI_LEGACY
 	default y
 	depends on VIRTIO_PCI
 	---help---
-          Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
+	  Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
 
 	  This option enables building a transitional driver, supporting
 	  both devices conforming to Virtio 1 specification, and legacy devices.
 	  If disabled, you get a slightly smaller, non-transitional driver,
 	  with no legacy compatibility.
 
-          So look out into your driveway.  Do you have a flying car?  If
-          so, you can happily disable this option and virtio will not
-          break.  Otherwise, leave it set.  Unless you're testing what
-          life will be like in The Future.
+	  So look out into your driveway.  Do you have a flying car?  If
+	  so, you can happily disable this option and virtio will not
+	  break.  Otherwise, leave it set.  Unless you're testing what
+	  life will be like in The Future.
 
 	  If unsure, say Y.
 
-- 
2.17.1

