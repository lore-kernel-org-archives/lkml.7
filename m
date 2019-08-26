Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B26C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDD72186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566821791;
	bh=S6oGlqVHEeMffta/FzpKQdWs0mHsBTyLqpmwkxWrE7c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cAdKItS8tXJQA4+kyLhd/Na+d8xpAUfxKNX04dKfvvYdgyoF/wqY0d0F8YFSBu+Aq
	 W91xxFAX1+sV5JVq8I8pRsFE72XZaY+Pry7GURz3pIeY23byaWCo/ACJYWWuEhTk/N
	 yaqp7v/HxBiclGl5zu24j8njmH7vg7UtFjXkK3IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfHZMQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbfHZMQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:16:29 -0400
Received: from localhost.localdomain (unknown [122.178.200.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18DE7217F5;
        Mon, 26 Aug 2019 12:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566821788;
        bh=S6oGlqVHEeMffta/FzpKQdWs0mHsBTyLqpmwkxWrE7c=;
        h=From:To:Cc:Subject:Date:From;
        b=RM1bz1eD0k817b+hdzpnmOhS4Q1IrfCqmKAz9re2X3O13ZcPSJtKb7Q2qzzEto9mc
         JVbXhC2j0MQqUozh9XQs+Jf9DGZ8htrdbY9UHI9xYs8fmx/Xl4uywuZwkzEU3l6Wkr
         31nGNw4+NcWsye2QIcXtm0sPbbddRWoUxvnMN4Ek=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] clk: qcom: Add support for SM8150
Date:   Mon, 26 Aug 2019 17:44:49 +0530
Message-Id: <20190826121453.21732-1-vkoul@kernel.org>
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
 - Make clock parent name as xo instead of xo_board

Changes since v2:
 - Add reviewed-by from Bjorn
 - Update the parent name as xo_board
 - Fix style issue

Changes since v1:
 - Describe parent clocks for rpmhcc
 - Add support for parent data scheme for rpmhcc

Vinod Koul (4):
  dt-bindings: clock: Document the parent clocks
  clk: qcom: clk-rpmh: Convert to parent data scheme
  dt-bindings: clock: Document SM8150 rpmh-clock compatible
  clk: qcom: clk-rpmh: Add support for SM8150

 .../bindings/clock/qcom,rpmh-clk.txt          |  7 +++-
 drivers/clk/qcom/clk-rpmh.c                   | 38 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.20.1

