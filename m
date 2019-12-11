Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1373AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04E24654
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079537;
	bh=Z6lUtuqtq37NXRW+cI7cZqDNQtC2beuJN6QrUy7pfAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pheQQm6BIZQw98aYX+PgaHKeTwALENZQnYFHVIzoOpSL8LUOqqIzEz7/m76ddy5l1
	 hpv4cgf6PeH9lPIko2s4m8mD+KeVUV1YO94nCQEf9GYj7OMbGJqWOtKaEs885vDokV
	 Vajhm80cmKMoI6OxgIA5jtPDR1wYRGGQDu9BRFN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfLKPVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:21:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732421AbfLKPVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:21:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 784E92465B;
        Wed, 11 Dec 2019 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077667;
        bh=Z6lUtuqtq37NXRW+cI7cZqDNQtC2beuJN6QrUy7pfAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1tMwcQArpyhZWZrjQiDx8KTKJBo2wamST0ySmO9Rcl3COpi/XZD2xC8xWp1x2fqHh
         bOqiVVqmJbI21MC8tVFQMiLdCnuSq4HDWzKrAupwqoIoZeTCrKt8oagvEf5KPNcxy7
         9Futw6pRkNoo0g3C0aPJ9IRwS4yUHPsNMCdKxiEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 126/243] ARM: dts: sun7i: Fix HDMI output DTC warning
Date:   Wed, 11 Dec 2019 16:04:48 +0100
Message-Id: <20191211150347.632644983@linuxfoundation.org>
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

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit 4d9a06979b1ae0c802440cb4433dfcd85fc7bdd3 ]

Our HDMI output endpoint on the A10s DTSI has a warning under DTC: "graph
node has single child node 'endpoint', #address-cells/#size-cells are not
necessary". Fix this by removing those properties.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 9c52712af2411..73e789a133de1 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -639,8 +639,6 @@
 				};
 
 				hdmi_out: port@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 				};
 			};
-- 
2.20.1



