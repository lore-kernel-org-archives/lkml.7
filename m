Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13610C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7F521823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141197;
	bh=W6uN9xHq7HGKDzwyHjCpDmU5tv6iPNN8Hw2AZv3Xizw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lBuv4SAzZYcak3nC5m2FrN/njwL8r3Z+07XMau1WzbZI9BoGUyImlf6Y2OOMQXikg
	 w8JXA1/KEYHBYXfrm1qROVYc49PONRLemp+sqlhMZdA3qzKxEz0EWa64Jc0lxJpqMl
	 7sAh7bPvNZui1e1tB+wZ5N7txaLUQq99/xwIUj/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfKSF0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbfKSF0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:26:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5909B222ED;
        Tue, 19 Nov 2019 05:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141192;
        bh=W6uN9xHq7HGKDzwyHjCpDmU5tv6iPNN8Hw2AZv3Xizw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZH0kTsXQ4Jnw8T9RR19AnotKnzUgtBDjsbD62IxUcekgrBwm05GMT+u4qCQFimGo
         uwASkd1OYEGBGuy2mvrg1icx8Vb+UvFDh/2E8+fjFM+Bo8gLnEucHeg9b5Ex5knbYF
         X9zF5cb+26Tj6Iymae5mqO5nz1mOsRIz3F9rv9Vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/422] arm64: dts: stratix10: i2c clock running out of spec
Date:   Tue, 19 Nov 2019 06:14:33 +0100
Message-Id: <20191119051404.470539070@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



