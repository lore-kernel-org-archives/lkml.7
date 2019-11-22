Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0641CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA78820721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419246;
	bh=5ASHEqf75+P521LBguttK0v1MZgEuN4XJ6jUdODwdSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m0sJUsA5M8BhSbAv1s698nXtFreB2bZF5JSRFyFkUH0qtlZvAkbwGA8Vu7QNOkLGc
	 4kPoXyAmR+9DZCA5LVApRZ6NQFK0XFG5qxrXjvpQswPy06dxdhig/zOTx2ITazJ5Y7
	 L1kJyIPxcnffhQY/mnUFdOo8p1hbrdmzsZopoRG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKVKkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:40:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfKVKkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:40:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB5D20707;
        Fri, 22 Nov 2019 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419241;
        bh=5ASHEqf75+P521LBguttK0v1MZgEuN4XJ6jUdODwdSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlWrqvqRNJNEk3xnCruLVcNXZDyTQ+PVsPCA+V5c9W86AJQ/5efantIRSvDnbRyeX
         /yOhUY0po7wUJ84UcvD8amYxUrnPzaNKKGAmG7oRWbI6QJ8+SuCsNhnhaGcXH8cBCl
         CYDzrFh5z9N1H6l8TavbnQlYuwcQGzVyV1wHUaC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 045/222] ARM: dts: omap3-gta04: tvout: enable as display1 alias
Date:   Fri, 22 Nov 2019 11:26:25 +0100
Message-Id: <20191122100852.495051975@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: H. Nikolaus Schaller <hns@goldelico.com>

[ Upstream commit 8905592b6e50cec905e6c6035bbd36201a3bfac1 ]

The omap dss susbystem takes the display aliases to find
out which displays exist. To enable tv-out we must define
an alias.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 67b50dbe28189..e86f42086a29b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -28,6 +28,7 @@
 
 	aliases {
 		display0 = &lcd;
+		display1 = &tv0;
 	};
 
 	gpio-keys {
-- 
2.20.1



