Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64888C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AC622CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566283448;
	bh=Jd2ZX4IRBSlGCuFa51BCoCuCBXEaAFKnv7QFFL4FX8I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AKjdNkLg/SvpBDhUxSiJTWJLbEQp6WEOiD2mAqVY2BcdF3fF8sYvLMTNy5pQcKupD
	 vCo1mHCHpZV8wM6u34pJ8LNdGLJumMBsioGlm9GctjepVkSAxkFvCMi8FACm2xGokA
	 qu4o12lXkmntdrLPOVpny0vULiDrJG5LqrqJzKVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfHTGoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTGoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:44:06 -0400
Received: from localhost.localdomain (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFD42082F;
        Tue, 20 Aug 2019 06:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566283445;
        bh=Jd2ZX4IRBSlGCuFa51BCoCuCBXEaAFKnv7QFFL4FX8I=;
        h=From:To:Cc:Subject:Date:From;
        b=ft1oAu5WDUvfv7JjmfnxRggHcfadNIUAuw0yowy1m5npVAv+7f5OSfiw60tMSRDEV
         nBmz5LXx0DGwECcK+fjFiS/EQeKXLq/IU0ikWIAxz5uFRqmJ9LZxLmbKIltjy3PCJz
         3JqfIH/2iE1jngiAAxBwIUY8v/js53MfjvhrdCvc=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] arm64: dts: qcom: sm8150: Add SM8150 DTS
Date:   Tue, 20 Aug 2019 12:12:08 +0530
Message-Id: <20190820064216.8629-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds DTS for SM8150, PMIC PM8150, PM8150B, PM8150L and
the MTP for SM8150.

Changes in v2:
 - Squash patches
 - Fix comments given by Stephen namely, lowercase for hext numbers,
   making rpmhcc have xo_board as parent, rename pon controller to
   power-on controller, make pmic nodes as disabled etc.
 - removed the dependency on clk defines and use raw numbers

Vinod Koul (8):
  arm64: dts: qcom: sm8150: add base dts file
  arm64: dts: qcom: pm8150: Add Base DTS file
  arm64: dts: qcom: pm8150b: Add Base DTS file
  arm64: dts: qcom: pm8150l: Add Base DTS file
  arm64: dts: qcom: sm8150-mtp: add base dts file
  arm64: dts: qcom: sm8150-mtp: Add regulators
  arm64: dts: qcom: sm8150: Add reserved-memory regions
  arm64: dts: qcom: sm8150: Add apps shared nodes

 arch/arm64/boot/dts/qcom/Makefile       |   1 +
 arch/arm64/boot/dts/qcom/pm8150.dtsi    |  95 +++++
 arch/arm64/boot/dts/qcom/pm8150b.dtsi   |  84 +++++
 arch/arm64/boot/dts/qcom/pm8150l.dtsi   |  78 ++++
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 375 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi    | 479 ++++++++++++++++++++++++
 6 files changed, 1112 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150b.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150l.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150.dtsi

-- 
2.20.1

