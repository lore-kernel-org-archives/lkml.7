Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D8E2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403529;
	bh=TOV0UK0piw0Hanyoyx8YpCbQcv2tT6LiX7Adeaopczg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vvQtCWM3HhSX6r39oorB+khJFR7U7VjoqA8iUoLQ/CEOFrhmvPOAOB6kvqtPoOy8W
	 0CirMYF0qoM2INJpC2ZXhJO4xdQjpYUaHq871g9c43F1rp4zilGd3lxkRqUb87yRn6
	 ivg7ZmoHvWW6bwLsrg5AdnGUh+rITlCn+kGyyBPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfKVGSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfKVGNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51CF62070E;
        Fri, 22 Nov 2019 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403185;
        bh=TOV0UK0piw0Hanyoyx8YpCbQcv2tT6LiX7Adeaopczg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNNwaRWZaliGouEPrAFxGI/5fmPHmAteYjzKqB3E4kTd8uL9/R+vujcz7LR6iuT7t
         tT/s6fMuixdos8fSgrAFyd86zYVLAVPYqQFu49C39G0R3sKN4+HX5rgXQ1EWVL94Gv
         1g7BnzI3xwJXcLFX8a7hCQkbLeXNtYsBDQm4FAGY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 03/68] ARM: dts: imx53-voipac-dmm-668: Fix memory node duplication
Date:   Fri, 22 Nov 2019 01:11:56 -0500
Message-Id: <20191122061301.4947-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 998a84c27a7f3f9133d32af64e19c05cec161a1a ]

imx53-voipac-dmm-668 has two memory nodes, but the correct representation
would be to use a single one with two reg entries - one for each RAM chip
select, so fix it accordingly.

Reported-by: Marco Franchi <marco.franchi@nxp.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index ba689fbd0e413..301cf8d45947f 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -17,12 +17,8 @@
 
 	memory@70000000 {
 		device_type = "memory";
-		reg = <0x70000000 0x20000000>;
-	};
-
-	memory@b0000000 {
-		device_type = "memory";
-		reg = <0xb0000000 0x20000000>;
+		reg = <0x70000000 0x20000000>,
+		      <0xb0000000 0x20000000>;
 	};
 
 	regulators {
-- 
2.20.1

