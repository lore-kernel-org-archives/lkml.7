Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB4AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420042473C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559657937;
	bh=LNKurD52i2VOxswf+0cVbOBkiFXK6aSZ9XPaXEohUsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1T02wne2qRs5yOpQVvwr3kZ75l1YnTGoQCQGHSnABnFgDhn6qPJojNOKooXTGn+UO
	 ILCJxcO4XKpCW8/1KB3OiT1M0C1G6JFDLbo9knZhXuUP60xRukzNmimfFYMqhxf2pk
	 30gXbXxtrBDAo0cdhGwNoDGqo0JeDQqeRnnP6xfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfFDOS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:18:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfFDOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=86CajaIHJg8+BksH0RmyeOvwTcywacFuhQ+inbaD7cg=; b=RzbftgXfci4jLwFmKSktObcGnD
        0sqBHSfkX5vBRwfmdP8/DFk1B2t9v+GQKDIovJvRP/BHg9/R3w/lrGufSbgieZO0vBVGnd4BhjRSS
        j4zbx1orJemZ/AMBUOTgQeIyDpFdxhqMUvefIo+X/vFG0V96JOpTMyYs3/IT+DXF9fgc7O66C7qb+
        nj9d1PTQRM8PTEIWVbbeUXSheB/shHKUZL2uWuOy/Cxv/shqRLZgyJXY+AnpjuoH3MSxFQ2GK2jQZ
        +LFOJAVb2V1rUUUmRgeI1D5cIol7FwbAb67iirb/U6orU1neBmUps68esTQQ+OrC4IplcG2S8ylxo
        kkK9pJnA==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Rq-U2; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGE-0002lR-Qt; Tue, 04 Jun 2019 11:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 13/22] docs: soundwire: locking: fix tags for a code-block
Date:   Tue,  4 Jun 2019 11:17:47 -0300
Message-Id: <0ea9c284f8db3867985c410d2764a2b68e5b35c1.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
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

