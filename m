Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86345C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564F321926
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798954;
	bh=oSGvrhvOENtQr2vmF9xUHJFiLqNbNOh8MfytEV3Eyhg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=s43aPO+tSkTYaU4Ngj+qtFShOo7HU2dktiS4+DoTKd95SgBqBf47ipilua9TfWms2
	 6KWGEe5gEWmamiwAKL4/MUJfplp6VB2zBAAh5/6Fct/B9xP9SPNW+9WPT9paz1kjr9
	 3P2uxowd51is4ZJNLV2N4v+l2MyhRh+kIjfXfXX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfGVMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbfGVMfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:35:53 -0400
Received: from localhost.localdomain (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538BF217D4;
        Mon, 22 Jul 2019 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563798952;
        bh=oSGvrhvOENtQr2vmF9xUHJFiLqNbNOh8MfytEV3Eyhg=;
        h=From:To:Cc:Subject:Date:From;
        b=WtjDF5W2xRraOLEwXIZ1rv9ZFWQ+0RT2/tCAhCmF6yi/hEcd/UWAu32vKfLe4nCI/
         7MqSo28r55rmQDe230BcLcCPuT627cpgbO0WwbSbF/WgdmyLvlwAIWLULhQa4NaXes
         uOOSSJEpxMfYLK2JE/CRmp8sSN1dqDgt2GV8rT80=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm64: dts: qcom: sdm845: Fix DTS warnings
Date:   Mon, 22 Jul 2019 18:04:17 +0530
Message-Id: <20190722123422.4571-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this is an attempt to fix some warns on sdm845 dts. We still have bunch
of warnings to fix after this series (dupplicate adress and node names
having underscores etc).

lets get long hanging ones fixed, we can see the warns with W=1 or W=2

Vinod Koul (5):
  arm64: dts: qcom: sdm845: Add unit name to soc node
  arm64: dts: qcom: sdm845: remove unnecessary properties for dsi nodes
  arm64: dts: qcom: sdm845: remove unit name for thermal trip points
  arm64: dts: qcom: sdm845: remove macro from unit name
  arm64: dts: qcom: sdm845-cheza: remove macro from unit name

 arch/arm64/boot/dts/qcom/pm8998.dtsi       |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 10 ++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 66 ++++++++++------------
 3 files changed, 36 insertions(+), 42 deletions(-)

Thanks
-- 
2.20.1

