Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF28CA9EBD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AA72084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="cdAuO8oW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409183AbfJXKbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:31:46 -0400
Received: from onstation.org ([52.200.56.107]:37214 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389949AbfJXKbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:31:45 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2F2243E951;
        Thu, 24 Oct 2019 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1571913104;
        bh=uiwwS5b2IphvBHKc+YmPSSJR2+batggLeJo4PNUTWsY=;
        h=From:To:Cc:Subject:Date:From;
        b=cdAuO8oWyjlmWMukRC/NePYDvVUGNozIkpuaPbKYgQ7LKo5WFfoyVH9SftAY55rye
         iHckatKd1mQ7Hlq6OStIDxpYWoOfYffm1FekXcPB4M16yOC0kGqRduEj2v8c+ziOz+
         fch16IavG7qW9DpuNZjW3XNVDb9ZMug3DnTNyagM=
From:   Brian Masney <masneyb@onstation.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 0/4] ARM: qcom: add defconfig items and dts nodes
Date:   Thu, 24 Oct 2019 06:31:36 -0400
Message-Id: <20191024103140.10077-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch series that adds some additional functionality
to qcom_defconfig and to qcom-msm8974.dtsi: interconnect, ocmem,
and HDMI bridge (defconfig only).

Some high-level changes since v1:
- Updated interconnect support. See patch #4 in this series for details.
- Dropped ocmem defconfig since that got merged.

Brian Masney (4):
  ARM: qcom_defconfig: add msm8974 interconnect support
  ARM: qcom_defconfig: add anx78xx HDMI bridge support
  ARM: dts: qcom: msm8974: add ocmem node
  ARM: dts: qcom: msm8974: add interconnect nodes

 arch/arm/boot/dts/qcom-msm8974.dtsi | 77 +++++++++++++++++++++++++++++
 arch/arm/configs/qcom_defconfig     |  4 ++
 2 files changed, 81 insertions(+)

-- 
2.21.0

