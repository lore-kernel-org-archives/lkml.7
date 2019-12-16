Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7DFC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D7221739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518818;
	bh=nYz2YtAPzwOafZ4pQpbx2tP9YyNh7KH67+akNwygM3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cP2rJq4x/CwRsvcQiN3DNkUDzc64Nx/byo8BIIDqVp7kKw9EfiDMxPvqzCX+orKYq
	 aRHt9at+7B/C/jZSSc9X99pXCFI6gh+4O/ue8JmaWH95c0D75H7PQHhiSlEQpH9kab
	 cwYlmBQ0xToxpuXOK5TtLeFyZPzjurp2q62Ph82A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfLPRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:53:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfLPRxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:53:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF00920733;
        Mon, 16 Dec 2019 17:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518811;
        bh=nYz2YtAPzwOafZ4pQpbx2tP9YyNh7KH67+akNwygM3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+sEGDAyFA+GlL8f77OaXQ9JVGQmLn/hiqA3/XqQahDb2m9q4gSdd0oPg0fXHsTC+
         SSDDLQUaw0crZ948Yhm+eiQmaaFUgnOF8gHjAQsAC/B0DmyHv03wgTLTPAxlNPmOKE
         uYiHMpvbpcwrUZSLd1NuHhDYoMzdGcxxdFctSOE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 077/267] ARM: dts: sun5i: a10s: Fix HDMI output DTC warning
Date:   Mon, 16 Dec 2019 18:46:43 +0100
Message-Id: <20191216174857.033441103@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit ed5fc60b909427be6ca93d3e07a0a5f296d7000a ]

Our HDMI output endpoint on the A10s DTSI has a warning under DTC: "graph
node has single child node 'endpoint', #address-cells/#size-cells are not
necessary". Fix this by removing those properties.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 18f25c5e75aeb..396fb6632bf07 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -104,8 +104,6 @@
 				};
 
 				hdmi_out: port@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 				};
 			};
-- 
2.20.1



