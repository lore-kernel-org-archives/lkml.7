Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8802C2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952D924680
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782691;
	bh=JMtLdH5N/pRayjeq4ysU3riAaYpsmdHp8ifQ324osZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qzFoo/MobqPG+mtDWNLBsj+pvV8E/T1AJ1xJb9dj+j1H6t9ypjltnwaW7iZ0MMXQL
	 wm7w952KwSMcPcyJKEGgR2CXD5k8oUPdEsQ9pBlIVT5F2cxwLbXfXG3XJD6Du5HvC/
	 R3CHoZgO+E+tGz0CC2x5CEU6lwntLfEWRWWs9KNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfLSSiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:38:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfLSSiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:38:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E931E20716;
        Thu, 19 Dec 2019 18:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780688;
        bh=JMtLdH5N/pRayjeq4ysU3riAaYpsmdHp8ifQ324osZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWtQ2pmD9RoAvoE6EC1QFW+pTkAO1hMBCwBtIoVrKnoo+r/BoqyCF4twrmQdFyIJW
         DPMp/iN8TO1ci8m2bhYAjiCDx5ghtfTfkVsTpwNdo55Bb331/esScUdXAYdACqnmSG
         Abo8ARqcMu0oQLNiZua/JvgYDwPK28EY9YcaEOf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 028/162] rtc: dt-binding: abx80x: fix resistance scale
Date:   Thu, 19 Dec 2019 19:32:16 +0100
Message-Id: <20191219183209.309009431@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
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



