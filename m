Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F417C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435702168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AWkpswOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfICKgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:36:17 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:35602 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728739AbfICKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:36:00 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C750C0489;
        Tue,  3 Sep 2019 10:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567506959; bh=ci0DnJaiVUwmGKYtP69kNVoyhgb9mqF6IxgeoAM9+Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AWkpswOBGdXodXeTomxkr5BnvGlaQwxOQbcoS8zrS4zFJlG540cV7QHzuU5k+Uudy
         4DjK6ad7TC+b/pWT1UdGLhhMC1rsLI7OUK+jclvcwHqKEyktLS5Oe0zk9K+NJAAgyO
         +2do4CxTzKRIq/zg6JAwjy9IfqaZzcLQUtEWca40yWcEO9/NCR6Rar1tDE4b38I8ti
         5oXk2dq9YkqDUDXyqX4XU1/cncMieZtxM0HePzoeznANnT+NA2D03HM1bfJGv0bQ1Y
         sGDvbisGXz7lAdfgEBxS6SbtSfETPZoGvbXhCM4IL+7iUB19Ar/DKoTwg2m7LQH6Af
         w/I3XlN8dwxQQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id EABE4A0063;
        Tue,  3 Sep 2019 10:35:56 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id D41513C0E1;
        Tue,  3 Sep 2019 12:35:56 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pgaj@cadence.com, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 4/5] dt-bindings: i3c: add a note for no guarantee of 'assigned-address' use
Date:   Tue,  3 Sep 2019 12:35:53 +0200
Message-Id: <159ae86a8f87b8d518bf63a8946b03b14e6b5500.1567437955.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1567437955.git.vitor.soares@synopsys.com>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1567437955.git.vitor.soares@synopsys.com>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the framework will try to assign the 'assigned-address' to the
device but if the address is already in use the device dynamic address
will be different.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 Documentation/devicetree/bindings/i3c/i3c.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
index c851e75..e777f09 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.txt
+++ b/Documentation/devicetree/bindings/i3c/i3c.txt
@@ -98,7 +98,9 @@ Required properties
 
 Optional properties
 -------------------
-- assigned-address: dynamic address to be assigned to this device.
+- assigned-address: dynamic address to be assigned to this device. The framework
+		    will try to assign this dynamic address but if something
+		    fails the device dynamic address will be different.
 
 
 Example:
-- 
2.7.4

