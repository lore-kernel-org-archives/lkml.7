Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB466C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C182339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566413045;
	bh=HLj/bEngoLHeB/gCl35JIzyA2WjR/wbbjcCZHeETu84=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sjQi2QcrRFbxIfhWvt2U7HYSIqz8QrAzKNjUQw7toJwqSWP4VVSeWQ1cpxjTYqnqw
	 ypQ6/GRsEmBJKCVLkTSG/xh7M+nc5oFdA2S30TNkw5pkBtZNEkaqSNhkdsiZ7raY7O
	 BDVYVawOqijlhXnRzt8cB49P7b5GfTZHeJ4xMjs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfHUSoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHUSoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:44:04 -0400
Received: from localhost.localdomain (unknown [106.201.100.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED366214DA;
        Wed, 21 Aug 2019 18:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566413043;
        bh=HLj/bEngoLHeB/gCl35JIzyA2WjR/wbbjcCZHeETu84=;
        h=From:To:Cc:Subject:Date:From;
        b=2NiNCdepf4XhoukNAW3hLgI2mViHJonu+t+A96yXdtMaIb/rdBibAqBLg7enUGTC5
         WqiPUiAuJ+YN690AmCFAGutxapbEf3Pn0ji80OPB5shnYj0a0vAOOT7RlHKfT36/jT
         MU2YDcVrmyv6r59Fw18EMBDRVORXDr2/loMtQdxE=
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
Subject: [PATCH v4 0/8] arm64: dts: qcom: sm8150: Add SM8150 DTS
Date:   Thu, 22 Aug 2019 00:12:31 +0530
Message-Id: <20190821184239.12364-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds DTS for SM8150, PMIC PM8150, PM8150B, PM8150L and
the MTP for SM8150.

Changes in v4:
 - Update the address and size cell to 2 and extend ranges and describe DMA
   space
 - Fix node location of spmi per sorted address
 - Add Niklas's review tags

Changes in v3:
 - Fix copyright comment style to Linux kernel style
 - Make property values all hex or decimal
 - Fix patch titles and logs and make them consistent
 - Fix line breaks

Changes in v2:
 - Squash patches
 - Fix comments given by Stephen namely, lowercase for hex numbers,
   making rpmhcc have xo_board as parent, rename pon controller to
   power-on controller, make pmic nodes as disabled etc.
 - removed the dependency on clk defines and use raw numbers

Vinod Koul (8):
  arm64: dts: qcom: sm8150: Add base dts file
  arm64: dts: qcom: pm8150: Add base dts file
  arm64: dts: qcom: pm8150b: Add base dts file
  arm64: dts: qcom: pm8150l: Add base dts file
  arm64: dts: qcom: sm8150-mtp: Add base dts file
  arm64: dts: qcom: sm8150-mtp: Add regulators
  arm64: dts: qcom: sm8150: Add reserved-memory regions
  arm64: dts: qcom: sm8150: Add apps shared nodes

 arch/arm64/boot/dts/qcom/Makefile       |   1 +
 arch/arm64/boot/dts/qcom/pm8150.dtsi    |  97 +++++
 arch/arm64/boot/dts/qcom/pm8150b.dtsi   |  86 +++++
 arch/arm64/boot/dts/qcom/pm8150l.dtsi   |  80 ++++
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 375 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi    | 482 ++++++++++++++++++++++++
 6 files changed, 1121 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150b.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150l.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150.dtsi

-- 
2.20.1

