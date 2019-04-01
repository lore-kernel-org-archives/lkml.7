Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF11C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB38E206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="LqUspOxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDAL4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:56:35 -0400
Received: from vps.xff.cz ([195.181.215.36]:57786 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfDAL4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554119780; bh=UzU+qsNACtfxcYu/73bvogl1+uKb4UDhIEXNrk+9P9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqUspOxqbbnBdGmBafSPr/+6oLO93uvcI6aTFFFfsf7PjEZ0M3kU4fY1ADHXmykD0
         YTS3v+BQVQ7fsfuYtnwksobYJE7xsEa4n/8NJltQHtctHK+d14J1HCej6XA+Kk+NNt
         s/D2VeGDz9bPX+EFWV9CoAPsQco5H3K0FKx+WAZ0=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 4/5] dt-bindings: gnss: Add u-blox,neo-6m compatible
Date:   Mon,  1 Apr 2019 13:56:15 +0200
Message-Id: <20190401115616.21337-5-megous@megous.com>
In-Reply-To: <20190401115616.21337-1-megous@megous.com>
References: <20190401115616.21337-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Add compatible for u-blox NEO-6M GPS module.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/gnss/u-blox.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
index e475659cb85f..7cdefd058fe0 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox.txt
+++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
@@ -9,6 +9,7 @@ Required properties:
 
 - compatible	: Must be one of
 
+			"u-blox,neo-6m"
 			"u-blox,neo-8"
 			"u-blox,neo-m8"
 
-- 
2.21.0

