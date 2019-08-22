Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0DBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6446C23402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493384;
	bh=opZxMMPTTATXlpDMUC+cbKgkPiHxtoaB6iSP8Yk3r3s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Bc1w2plEYvSn0mfxO+PspUc3OASNnPwiC2uIbyQYieKxgwg6EWklEqjIOV0KS2C/O
	 B/cb0Usl2pPDABO5z091gsGGeRRqTI0FKGqSSRI0DLufCm+Jqh8EHmEOKa/Qoqq4SL
	 wIyQDhzbZNlFB7Q5BiFHl3999Hhq9ACBDKr6Pzfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbfHVRDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbfHVRDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:03:03 -0400
Received: from localhost.localdomain (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A331520870;
        Thu, 22 Aug 2019 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493382;
        bh=opZxMMPTTATXlpDMUC+cbKgkPiHxtoaB6iSP8Yk3r3s=;
        h=From:To:Cc:Subject:Date:From;
        b=DRDeRuxEl6eHiBDWoeF0Y/ZHtBH3xhWm3RYeCUOnfmh40eXiKBirGxtNlUSRV5Xe8
         HUWqcVzs3sTbybt+LbHIb/A060+OzWRZ0Ty1zzoOdzE0hfGIsBWayOx2hcwJiIP2Jj
         sGQnZdqm3qSB+L6NGncZ3DheEFpx9R+KIcUs11Vc=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] clk: qcom: Add support for SM8150
Date:   Thu, 22 Aug 2019 22:31:36 +0530
Message-Id: <20190822170140.7615-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for rpm clock controller found in SM8150 and while at it update
the driver to support parent data clock scheme as suggested by Stephen.

Changes since v3:
 - Add reviewed-by from Bjorn
 - Update the parent name as xo_board
 - Fix style issue

Changes since v2:
 - Describe parent clocks for rpmhcc
 - Add support for parent data scheme for rpmhcc

Vinod Koul (4):
  dt-bindings: clock: Document the parent clocks
  clk: qcom: clk-rpmh: Convert to parent data scheme
  dt-bindings: clock: Document SM8150 rpmh-clock compatible
  clk: qcom: clk-rpmh: Add support for SM8150

 .../bindings/clock/qcom,rpmh-clk.txt          |  7 +++-
 drivers/clk/qcom/clk-rpmh.c                   | 37 ++++++++++++++++++-
 2 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.20.1

