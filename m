Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B468C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DB120811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553577742;
	bh=VBtMS7SHDpvSuxHB4U4f83DIEtwscxCT4O5/qvgxBwc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0s0P5PcmMjwpoqhADLfqP1xqXQsEtVYbLj1Pco/sRo4Xpoi6Y0hVjamEeL0OF9w+g
	 fEMeKusHSASloUbLGT9QPyw/N/ToNrPms5gpPkr3HwXjhJ7sl8V+Bcs2x+6aEo2FPD
	 4JVSZPaeYKQWdEOab5zeLy5ygB2g8PAg8qIgGBnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfCZFWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfCZFWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:22:20 -0400
Received: from localhost.localdomain (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53EBB20811;
        Tue, 26 Mar 2019 05:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553577739;
        bh=VBtMS7SHDpvSuxHB4U4f83DIEtwscxCT4O5/qvgxBwc=;
        h=From:To:Cc:Subject:Date:From;
        b=GeebKEfji0wptK6/g7BUidiGHC7YBfTi8PoAniJ+hQrU4v5nA/Y7xxW4Z/Q1guHFd
         JNHfAGPZ6qEFi7L6+UBUkZHxV73k9cIa68J2CCRWv83B4+Zz1JoXt1vZ+NhHS1IHEi
         ZJ0WsQQncXEavN6+e5QSURi64dSYn2Ptumd9rKw8=
From:   Vinod Koul <vkoul@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        niklas.cassel@linaro.org, Vinod Koul <vkoul@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: [PATCH] MAINTAINER: Fix Qualcomm ETHQOS ethernet DT file
Date:   Tue, 26 Mar 2019 10:51:39 +0530
Message-Id: <20190326052139.11784-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 83c177aea4c3: ("MAINTAINER: Add entry for Qualcomm ETHQOS
ethernet driver") added incorrect filename for DT binding, fix the same.

Fixes: 83c177aea4c3 ("MAINTAINER: Add entry for Qualcomm ETHQOS ethernet driver")
Reported-By: Joe Perches <joe@perches.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..74c654d89a43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12849,7 +12849,7 @@ M:	Niklas Cassel <niklas.cassel@linaro.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
-F:	Documentation/devicetree/bindings/net/qcom,dwmac.txt
+F:	Documentation/devicetree/bindings/net/qcom,ethqos.txt
 
 QUALCOMM GENERIC INTERFACE I2C DRIVER
 M:	Alok Chauhan <alokc@codeaurora.org>
-- 
2.20.1

