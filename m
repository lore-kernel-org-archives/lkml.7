Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EDBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14765218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="i8iOeqvx";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="i8iOeqvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfCUPlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:41:07 -0400
Received: from node.akkea.ca ([192.155.83.177]:39268 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbfCUPlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:41:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id ECDDE4E2050;
        Thu, 21 Mar 2019 15:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553182863; bh=YtdSndT+Zi4H2ytZ+tYpf/nUtlDxjWqNqGUqu3RpO8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=i8iOeqvxT1culvpsNKvETdttqGXoisT5aTDefG1JHYb61mNw3tARgm5RHvsunHVm+
         VezKG0tpm0TqZ5aSl4s+Mh2PoCfD++4eegilOlxL/cfaZC9HQeF6SfjrzID8a+OZHR
         9mDy6n/tNftctHUUbhmmPq1SvLT19a3ShTlogB04=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6JwGBtvwvxIF; Thu, 21 Mar 2019 15:41:03 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 242804E204B;
        Thu, 21 Mar 2019 15:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553182863; bh=YtdSndT+Zi4H2ytZ+tYpf/nUtlDxjWqNqGUqu3RpO8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=i8iOeqvxT1culvpsNKvETdttqGXoisT5aTDefG1JHYb61mNw3tARgm5RHvsunHVm+
         VezKG0tpm0TqZ5aSl4s+Mh2PoCfD++4eegilOlxL/cfaZC9HQeF6SfjrzID8a+OZHR
         9mDy6n/tNftctHUUbhmmPq1SvLT19a3ShTlogB04=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     jic23@kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] dt-bindings: iio: light: add vcnl4040 devicetree bindings
Date:   Thu, 21 Mar 2019 08:40:47 -0700
Message-Id: <20190321154047.23236-6-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190321154047.23236-1-angus@akkea.ca>
References: <20190321154047.23236-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the vishay VCNL4040 devicetree bindings.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 Documentation/devicetree/bindings/iio/light/vcnl4000.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
index 4a9d558a412a..955af4555c90 100644
--- a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
@@ -1,6 +1,6 @@
 VISHAY VCNL4000 -  Ambient Light and proximity sensor
 
-This driver supports the VCNL4000/10/20 and VCNL4200 chips
+This driver supports the VCNL4000/10/20/40 and VCNL4200 chips
 
 Required properties:
 
@@ -8,11 +8,13 @@ Required properties:
         vishay,vcnl4000
         vishay,vcnl4010
         vishay,vcnl4020
+        vishay,vcnl4040
         vishay,vcnl4200
 
 	-reg: I2C address of the sensor, should be one from below based on the model:
         0x13
         0x51
+        0x60
 
 Example:
 
-- 
2.17.1

