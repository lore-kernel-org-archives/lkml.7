Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBBE20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367981;
	bh=trwczQZkxett0S9upyzua2Q+cJ/EICBSqWOmVojccCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+ojlT0JbwO9PdD7p3TEg9NY0wVAgj8DEloT2bpulgedTcYkZRShKJeqILCNmibqG
	 Eei5BHW1coqp8Te+7SI61h0arK07aHcZlMAfLRH0m30dyEoargRjIW0dn4icC7K75i
	 pJvfio+uepUltVfgatxKd0k7uRYu1VsCt6H9SChY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbfB1PIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732338AbfB1PIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C708218D0;
        Thu, 28 Feb 2019 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366525;
        bh=trwczQZkxett0S9upyzua2Q+cJ/EICBSqWOmVojccCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPpg4xNhSO8suc/yH3RKLCKlU8CNX3dqLgV3EK0hOlFARCTx5c+S+4ibaq2hDwpW0
         yS5ZJReCSP2gsfw1+xRks3QBvOfm9Id3uoQY0Wol9Macg/7cAB5BljvmVc8/mu1ndY
         1xHL5hLZAsjo8xpVvXiJm/x+vQ+gAelUmgfpHw2c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 19/81] ARM: dts: omap3-gta04: Fix graph_port warning
Date:   Thu, 28 Feb 2019 10:07:11 -0500
Message-Id: <20190228150813.10256-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 5b90df44fd9b415d8c5d11b92746212a63d3c47f ]

We're currently getting a warning with make dtbs:

arch/arm/boot/dts/omap3-gta04.dtsi:720.7-727.4: Warning (graph_port):
/ocp@68000000/dss@48050000/encoder@48050c0 0/port: graph node unit
address error, expected "0"

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index d5fe55392230d..68e6752589065 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -714,11 +714,7 @@
 
 	vdda-supply = <&vdac>;
 
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port {
-		reg = <0>;
 		venc_out: endpoint {
 			remote-endpoint = <&opa_in>;
 			ti,channels = <1>;
-- 
2.19.1

