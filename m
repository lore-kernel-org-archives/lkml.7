Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB1DFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA66214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239219;
	bh=eXUV9usKsFNCJl0ds2onpvux96p6TGBk/4ggU3O/OPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nokvd0CpkTp0MTtHlCg71gMq902z7PF42Cwi3smhV8XH4EHSHFrH90bCQbVp/6lSL
	 /DRnZnE8vIauOpCS1TmYMGVVHRzpkEBgNuLfLgIVt2zrCWZjKYA7sX7wd86rAxkSCX
	 rL3vKCawhCdOWyorPk7Xugc2pBiRO+kyBfi/OeKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfKHSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732452AbfKHSxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:53:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E697D20865;
        Fri,  8 Nov 2019 18:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239214;
        bh=eXUV9usKsFNCJl0ds2onpvux96p6TGBk/4ggU3O/OPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wf5darkdRo0ORFhIy4xr2Cg+MjEqsIBMHzlCr8EuKfaz5WJClOgFa3m1VteGtAu7a
         +ZRCjVVvUEhniDsb12Fgpr+Bd7jSHx5f1sAr4SltCgIXwcFeONNXryZWy8qdRvDmtG
         kP16ZLcb9NNyXjCBLB1rl8U0eSuNErrOXxgTSloo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 05/75] ARM: dts: logicpd-torpedo-som: Remove twl_keypad
Date:   Fri,  8 Nov 2019 19:49:22 +0100
Message-Id: <20191108174712.152333101@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 6b512b0ee091edcb8e46218894e4c917d919d3dc ]

The TWL4030 used on the Logit PD Torpedo SOM does not have the
keypad pins routed.  This patch disables the twl_keypad driver
to remove some splat during boot:

twl4030_keypad 48070000.i2c:twl@48:keypad: missing or malformed property linux,keymap: -22
twl4030_keypad 48070000.i2c:twl@48:keypad: Failed to build keymap
twl4030_keypad: probe of 48070000.i2c:twl@48:keypad failed with error -22

Signed-off-by: Adam Ford <aford173@gmail.com>
[tony@atomide.com: removed error time stamps]
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index e05670423d8b7..a6c59bf698b31 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -169,3 +169,7 @@
 &twl_gpio {
 	ti,use-leds;
 };
+
+&twl_keypad {
+	status = "disabled";
+};
-- 
2.20.1



