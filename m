Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B277AC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8030E21D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213143;
	bh=W6uN9xHq7HGKDzwyHjCpDmU5tv6iPNN8Hw2AZv3Xizw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1/6I+lIjgx6aIGDWnNTxwu0gHiXtxQg72DjkG0Nqou4lmeXM+wkGdmEPjhEpZbuS2
	 Cl9v4vtbmIhgIGXThus0eh8k0eyILXEny+2FbMIeEzPRO/5ljqx/T9im3a24USrQOi
	 wikiVBgKP6Rf95cMmfGA+XJnMTi/qus1ejU0Dh8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbfKHLjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:39:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732846AbfKHLip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1CE7222C2;
        Fri,  8 Nov 2019 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213125;
        bh=W6uN9xHq7HGKDzwyHjCpDmU5tv6iPNN8Hw2AZv3Xizw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLLRUHcAX+KJ8SNb7iOrcrDgdbPYe2wV8p1J0eWfiu1fr5rUn/Qg2o6lXkDNaksIc
         +ICsNPTmC9YIDJqvNiJb/Vzk9n8Aoc6LhFugukCuDiHqMj1kGJVG2dp3UWrRcKfupI
         itTUeoMLJHjjW6mEgPuCshQIus9Ld5fsvIpzJRyI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Tull <atull@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 044/205] arm64: dts: stratix10: i2c clock running out of spec
Date:   Fri,  8 Nov 2019 06:35:11 -0500
Message-Id: <20191108113752.12502-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Tull <atull@kernel.org>

[ Upstream commit c8da1d15b8a4957f105ad77bb1404d72e304566f ]

DesignWare I2C controller was observed running at 105.93kHz rather
than the specified 100kHz.  Adjust device tree settings to bring it
within spec (a slightly conservative 98 MHz).

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 7c661753bfaf4..faa017d4cd56b 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -124,6 +124,8 @@
 &i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
+	i2c-sda-falling-time-ns = <890>;  /* hcnt */
+	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
 
 	adc@14 {
 		compatible = "lltc,ltc2497";
-- 
2.20.1

