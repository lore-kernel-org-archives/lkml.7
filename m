Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFCDC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A5D24349
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172300;
	bh=LNKurD52i2VOxswf+0cVbOBkiFXK6aSZ9XPaXEohUsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EZo7zKGFSFkxT0sCDmkpjSDI+qaQ2Y7S5+b1URGTtxIdxxXMlxMouJm9IU97uVgki
	 NuBA8QZxlQZ/IcpCOVEMVnds6MmZHlJPISt6dV7yFigSwW8SWoHpBnokRvBSMZXCA+
	 5TDGIMewHXR9ZF+GXNjxICfm/Z1bDFdFqtGRwpW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfE2XY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:24:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfE2XYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=86CajaIHJg8+BksH0RmyeOvwTcywacFuhQ+inbaD7cg=; b=NrCxhwQ11L1nDZZSZVSHwbjCS/
        kr5Sb9j+nl6IJEd0NsxEhhzNIL3FRCISgo13IN/d6PGTygPo5KIRw4C/friX06Sm0ry07CEGIXR3D
        hFQMguSHDcuq0iLp51B8+nBYKUp3dsEqYHM/jK/R5v9uWQHoT8AfFOziPNAEPQ0DI6/eVCLAFCox9
        Q1tyHsBsIbq14Es0q3oXoRvM2qFg5KkhvelJ5YXfq7Qy1uo/sSF8CNUTAzfswO+ICbq60iFsTcu5m
        A1CfGB/Qp6VI0hIMD6aWm3hLAuzJvB1hE5T+D/RhtIbooNqrNHkBHH83imDQG3Xxkt6tbYrJKa1gj
        Qv24v5eg==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rn-AH; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007xp-Tw; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH 17/22] docs: soundwire: locking: fix tags for a code-block
Date:   Wed, 29 May 2019 20:23:48 -0300
Message-Id: <e27b6a1699b366feb03d50cc1bc0cbbc15c881a2.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an ascii artwork at Example 1 whose code-block is not properly
idented, causing those warnings.

    Documentation/driver-api/soundwire/locking.rst:50: WARNING: Inconsistent literal block quoting.
    Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
    Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
    Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/soundwire/locking.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/soundwire/locking.rst b/Documentation/driver-api/soundwire/locking.rst
index 253f73555255..3a7ffb3d87f3 100644
--- a/Documentation/driver-api/soundwire/locking.rst
+++ b/Documentation/driver-api/soundwire/locking.rst
@@ -44,7 +44,9 @@ Message transfer.
      b. Transfer message (Read/Write) to Slave1 or broadcast message on
         Bus in case of bank switch.
 
-     c. Release Message lock ::
+     c. Release Message lock
+
+     ::
 
 	+----------+                    +---------+
 	|          |                    |         |
-- 
2.21.0

