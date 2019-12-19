Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A32BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30195222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782449;
	bh=JMtLdH5N/pRayjeq4ysU3riAaYpsmdHp8ifQ324osZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=joPKiFA1EDcIoAv6gMQJpuo1gx36fjlKo6blFKcxGXYJjxIvtHg0DW5sZXazeUJNt
	 HziE9KQLBg4rjOPndPcjlr2T/iiZA2kXd+k77zmWzJj4qeERv+bLB4qQWoqpefC2qW
	 acNRRS28/h0Quhcd+1abbyd/AFHx+u/eZMg19ncM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfLSTH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:07:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfLSSnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:43:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA297222C2;
        Thu, 19 Dec 2019 18:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780987;
        bh=JMtLdH5N/pRayjeq4ysU3riAaYpsmdHp8ifQ324osZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gu6tV80cA08/QJo8lvNZkPLHmp+NdqHYe0c9xn656W8RuIeyns01lvhwmTIpzLw5p
         l+zMh5Lpd6BM3U9bGfxgCCBNBsUq2Z4/8lAUDlpDpIiXKQfDclNzOySHWIBUQp1HJY
         skM62kBPzhLEqX4qyL5gVS91YaCpaoTMqRZCDU/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 035/199] rtc: dt-binding: abx80x: fix resistance scale
Date:   Thu, 19 Dec 2019 19:31:57 +0100
Message-Id: <20191219183216.847741660@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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



