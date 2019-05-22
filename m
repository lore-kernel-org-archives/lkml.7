Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAD7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B9F20821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfEVUvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:51:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:49388 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730327AbfEVUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:50:59 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 292AD1427;
        Wed, 22 May 2019 20:50:59 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 7/8] docs: Fix conf.py for Sphinx 2.0
Date:   Wed, 22 May 2019 14:50:33 -0600
Message-Id: <20190522205034.25724-8-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522205034.25724-1-corbet@lwn.net>
References: <20190522205034.25724-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our version check in Documentation/conf.py never envisioned a world where
Sphinx moved beyond 1.x.  Now that the unthinkable has happened, fix our
version check to handle higher version numbers correctly.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 72647a38b5c2..7ace3f8852bd 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -37,7 +37,7 @@ needs_sphinx = '1.3'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig']
 
 # The name of the math extension changed on Sphinx 1.4
-if major == 1 and minor > 3:
+if (major == 1 and minor > 3) or (major > 1):
     extensions.append("sphinx.ext.imgmath")
 else:
     extensions.append("sphinx.ext.pngmath")
-- 
2.21.0

