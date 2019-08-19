Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69AC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E0521852
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566200489;
	bh=gSE+SJifgMYnoJwAFhNDWjp0CXgY/NibVpypk5/o80w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2U1Jujc3TYfqFROVciKAxhWW0zYZcEg8N5Hy7yeOSxNPVffM7Fmyb+av8dAnlI9SH
	 0PwQQtutxagDgTnjIFrq21mskSGHlEV5poErs+sheslmd9Vrgl8buWo3Ti7VK1G9Dn
	 UuiyoWX7FYyNisfkhRx+60ACWnxzgidfCuPvrTOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfHSHl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfHSHl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:41:28 -0400
Received: from localhost.localdomain (unknown [122.182.221.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB99920989;
        Mon, 19 Aug 2019 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566200488;
        bh=gSE+SJifgMYnoJwAFhNDWjp0CXgY/NibVpypk5/o80w=;
        h=From:To:Cc:Subject:Date:From;
        b=ZCguwiU0jt0xDPn6xGFzUvKsCze/65szxaTXtsvzmaKd4g4rZ+bPwdcfeTfG6RPFq
         NnyZewQAtfbovqsHV1LbvKD17p02uVaf66Sy+zvHlbUtcvuQ/VEoFoyrPPWFAa5Xq0
         5bz2YI3kKrXLZ0PQw+yUPaMvcO3iOHHPWigCdetc=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] clk: qcom: Add support for SM8150
Date:   Mon, 19 Aug 2019 13:09:43 +0530
Message-Id: <20190819073947.17258-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for rpm clock controller found in SM8150 and while at it update
the driver to support parent data clock scheme as suggested by Stephen.

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

