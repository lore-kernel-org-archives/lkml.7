Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8C8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF6C2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413932;
	bh=3ITe1xz1es1DfVmVWqEm6M1rYGeoHPyYOxkpAhXN62A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=16oNPvCT48cVIp7nh6ehcucTc4HRvfp2TX496Rq3KXcQSGJ0ai9xHbbTdv1ynBlpl
	 l/V6U+UpKK1yul7yta7XL6Hz8hA1lqE3xrUDChWARS4JTQfEthB+jUMx6Xjluk16ft
	 fmo0I6DIStd2sBqTTi+4hiWXoTn6j/gZpqOOM0cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfCLSFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfCLRMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:38 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CAE2183E;
        Tue, 12 Mar 2019 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410758;
        bh=3ITe1xz1es1DfVmVWqEm6M1rYGeoHPyYOxkpAhXN62A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/8nHwAhGh1OQwbcJPxTPxdt15yfFovpPGU24C4t8+4vtrGcCAMfFTFWkionIjuXW
         qMB7ahHJvl7eY/05zrazJ83AK0lJ7hgi9XO6WseFFqNjM3D2I90U9/Zfx+iebat9Sn
         EpJWPXRk7uXSOAAFpxJP43mkfO6cLLsGFDbkLg3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 089/171] ARM: dts: omap3-gta04: Fix graph_port warning
Date:   Tue, 12 Mar 2019 10:07:49 -0700
Message-Id: <20190312170355.644030365@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d5fe55392230..68e675258906 100644
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



