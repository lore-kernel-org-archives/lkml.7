Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CB4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4A120679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421996;
	bh=M6tG/myRDemTwJkjnTKjagtNE4E3o5yL5Yd/nGnly4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qx2OrMrh0wWZrHq4yDc8vAxtnk4xhb+PuXFk7EM4zVnAdE/e0MLJd9XL9JxFcwqfn
	 XJmzWFVLO1DBgDBMooiCm87rr4OHKjjjjExyuakG12Cg6DN/CbBXAuLgICQSdmo1T6
	 wb24sXNdEiQK923t2BVZJSoP+p0lOU8zHSL62CMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfKVL0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfKVKeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:34:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834DF20656;
        Fri, 22 Nov 2019 10:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418859;
        bh=M6tG/myRDemTwJkjnTKjagtNE4E3o5yL5Yd/nGnly4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJopxokWYvIkY3Fy1Rz5UppCWWXzmJ3HI9hBj5PrMGwLGaYJnrzL5aaX4/4B6uSKr
         Bt9U0Tssg8jlFT0jMIJB3dmi/VvUIlq/SiZlzmHlIKk902C5E8GgjxvkOveFSpMWto
         loBpyL2Y/z96zbiHykBldiBoJWKMrYKa+7zqxfFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 032/159] ARM: dts: omap3-gta04: tvout: enable as display1 alias
Date:   Fri, 22 Nov 2019 11:27:03 +0100
Message-Id: <20191122100728.877624025@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
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
index 9b9510e057f3f..196b3f5158c90 100644
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



