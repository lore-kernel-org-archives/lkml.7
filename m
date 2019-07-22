Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3122FC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0313B222F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="ftbt4Xj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfGVJaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:30:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:16353 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfGVJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563787850;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=H1gWY6IE7LGNkWVyXPI5Uoz/3tQSH/9wfOxoFpAOzxQ=;
        b=ftbt4Xj2xRYMxLgp5O+PBb+VIfiX7ad9aIbImQRXs6ed7Er1fgzZbrtXU37otmFpnr
        1cFrHmxhbVdoZMIy+O6uAcgJoEC0nQpHhQCCqu58eqdDvVVxRc+pdjRy8/Hsk1z9jIea
        JY439wzhXBGR1Mdy3cmOTY/MzNb2jGtQzJFYlkL4Nr/3s4N+tD+bM0Mq5tVs6xXRp6C8
        IMrwTJ8nVeKJuHr6rATElLZPgZ36ld/xCSbv8gnWu4OucKsb5SDabVIONohpGwEHgryK
        kldAq/Gwgwpz75iSgm4QSNJid0TeHr2tJqYINinTRrmQeqPVUwQEmz0wI5TbNpDqGU8f
        wrzw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxP4G6N/EiB"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id m0a13fv6M9OmObx
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 22 Jul 2019 11:24:48 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [RFC PATCH v2 2/4] dt-bindings: qcom: Document bindings for new MSM8916 devices
Date:   Mon, 22 Jul 2019 11:22:09 +0200
Message-Id: <20190722092211.100586-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722092211.100586-1-stephan@gerhold.net>
References: <20190722092211.100586-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new samsung,a3u/a5u-eur and longcheer,l8150
device tree bindings used in their device trees.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 54ef6b6b9189..e39d8f02e33c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -45,6 +45,7 @@ description: |
   	mtp
   	sbc
   	hk01
+  	qrd
 
   The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
   where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
@@ -115,6 +116,13 @@ properties:
           - const: qcom,msm8916-mtp
           - const: qcom,msm8916
 
+      - items:
+          - enum:
+              - longcheer,l8150
+              - samsung,a3u-eur
+              - samsung,a5u-eur
+          - const: qcom,msm8916
+
       - items:
           - const: qcom,msm8996-mtp
 
-- 
2.22.0

