Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747CAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3866224654
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077567;
	bh=JMtLdH5N/pRayjeq4ysU3riAaYpsmdHp8ifQ324osZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sxST49vGUZuoV5mPdrfuUCHR7Iw+OZL9lMPvmKf4Iy+yDpOKzZi3ruY/NhdaT9sgt
	 D4uXI+Dr2NpaLI1wrQr8bsPMFejIpJc5jDjPQeNmms9Rj8KTi7/ie5kGdXcPDbiT+V
	 64mDWckvyL+mf6c1egLD7iNc4pzORN1D6P3AYLj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbfLKPT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:19:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732202AbfLKPTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:19:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5384B2073D;
        Wed, 11 Dec 2019 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077558;
        bh=JMtLdH5N/pRayjeq4ysU3riAaYpsmdHp8ifQ324osZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdJ8QPzXoSP6NtHR5Y3CPvFlTNHVUHINSvDU4XhM9CLX5HUI2uQATsM4vw6uZmkrg
         gTz1vklvUY8hC1ysFUhSI1v3IveN0kB67ZvzpGg0MR6bjb/B4ei2Wt8lQS044/rjso
         iqJLn038SPIEveDL4TGmrIpLbZB+DnzyULPmNqbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/243] rtc: dt-binding: abx80x: fix resistance scale
Date:   Wed, 11 Dec 2019 16:04:07 +0100
Message-Id: <20191211150344.849599665@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit 73852e56827f5cb5db9d6e8dd8191fc2f2e8f424 ]

The abracon,tc-resistor property value is in kOhm.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/rtc/abracon,abx80x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
index be789685a1c24..18b892d010d87 100644
--- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
@@ -27,4 +27,4 @@ and valid to enable charging:
 
  - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
  - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
-                          resistor, the other values are in ohm.
+                          resistor, the other values are in kOhm.
-- 
2.20.1



