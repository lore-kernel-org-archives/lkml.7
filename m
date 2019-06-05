Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6B0C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A134206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SGcYOL5r";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SGcYOL5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfFERQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:16:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFERQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:16:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D858660FF3; Wed,  5 Jun 2019 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559754978;
        bh=FvHcmA2NIER1dNGRjQuJMPcZ6XkO2S25CeFWppA7VEc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SGcYOL5rt+yvqz1x08fMUk/HKBCCbZKH1/aknQ+wkesXClmEeEHhd5+Zq7B7N6+5Z
         pH+AwffS8xnAszLyV+nP/T+5PZNZ5KG/WL5RdPMzkZhoNLFeQXuftcx3dRf4UA8sBW
         BImZJBoMKW+X920PTg1J3pZDuj52Hi+AYZ58ZgyI=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A32160CED;
        Wed,  5 Jun 2019 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559754978;
        bh=FvHcmA2NIER1dNGRjQuJMPcZ6XkO2S25CeFWppA7VEc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SGcYOL5rt+yvqz1x08fMUk/HKBCCbZKH1/aknQ+wkesXClmEeEHhd5+Zq7B7N6+5Z
         pH+AwffS8xnAszLyV+nP/T+5PZNZ5KG/WL5RdPMzkZhoNLFeQXuftcx3dRf4UA8sBW
         BImZJBoMKW+X920PTg1J3pZDuj52Hi+AYZ58ZgyI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A32160CED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     robh+dt@kernel.org, sboyd@codeaurora.org, linus.walleij@linaro.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/6] dt-bindings: qcom: Add ipq6018 bindings
Date:   Wed,  5 Jun 2019 22:45:57 +0530
Message-Id: <1559754961-26783-3-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559754961-26783-1-git-send-email-sricharan@codeaurora.org>
References: <1559754961-26783-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: speriaka <speriaka@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index f6316ab..7b19028 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -36,6 +36,7 @@ description: |
   	mdm9615
   	ipq8074
   	sdm845
+	ipq6018
 
   The 'board' element must be one of the following strings:
 
@@ -45,6 +46,7 @@ description: |
   	mtp
   	sbc
   	hk01
+	cp01-c1
 
   The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
   where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

