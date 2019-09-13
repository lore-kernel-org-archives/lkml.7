Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA9CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AC6214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380736;
	bh=WJbq07PQexHhHh8h+8A/c7rxEiPdXwlQTv9J9HxJxdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c5i3op6LhBP0+FbFxwTiAaWzrLnmAHooFwiIEAU1sw/g5PY0G6r3VDbLnH2fJXCxZ
	 UP1VJIKXlaZIrqLmtfAxpZ6DOILVdUlDUrxSRMEDd9Afxf6+cMOlUUBXCs3EfRQaly
	 1hFajoWyx5URZjd3hpcNbRuRGoYhR0FkB3TDI8tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390318AbfIMNSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390296AbfIMNSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:18:50 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5C17206A5;
        Fri, 13 Sep 2019 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380730;
        bh=WJbq07PQexHhHh8h+8A/c7rxEiPdXwlQTv9J9HxJxdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEzzxPuSHZ36V7KcwsAZS5PLhe58dVlDOJHrM2TUP1TdwX8EA4xCc9lkRivLbqG6q
         X7JGFF7C0dOt+euzaTmwiE3xkVovBHqDukrzLd62bou2vEt2uW9RL5EtZsaluuX9iW
         YSX9j02rUZ5yfJ9/cWIk65MZ+qTHcPho1ETFNjWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 158/190] ARM: dts: gemini: Set DIR-685 SPI CS as active low
Date:   Fri, 13 Sep 2019 14:06:53 +0100
Message-Id: <20190913130612.543697910@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f90b8fda3a9d72a9422ea80ae95843697f94ea4a ]

The SPI to the display on the DIR-685 is active low, we were
just saved by the SPI library enforcing active low on everything
before, so set it as active low to avoid ambiguity.

Link: https://lore.kernel.org/r/20190715202101.16060-1-linus.walleij@linaro.org
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 502a361d1fe90..15d6157b661db 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -65,7 +65,7 @@
 		gpio-miso = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		gpio-mosi = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		/* Collides with pflash CE1, not so cool */
-		cs-gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
 		num-chipselects = <1>;
 
 		panel: display@0 {
-- 
2.20.1



