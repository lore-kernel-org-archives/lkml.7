Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7546AC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F46E20692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574377766;
	bh=aJ96Pu0TItbu0cExizL14b1Xpu2jLlpmp08Evn6sd8U=;
	h=From:To:Subject:Date:List-ID:From;
	b=LU05onsUx7IGEBDZKuLD0RqO+o1Pd8ghOBXpKeTd7Q1ESGjPR8hGIj3fLsTFvAczB
	 80eKROQ5UkCwUHlRRNE8tOeA5gN9RoKnFHw/5nG7YpQhIQXpifuDdcRX0DayLEUJsQ
	 BhppK9ZKpifs1AeZBO5alz/TSXWGYEdd2fGUen0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKUXJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:09:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36400 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUXJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:09:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id f10so4573179oto.3;
        Thu, 21 Nov 2019 15:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJG++O/7WyYCoHSioQk9zwnAb3uyZILPOLprzryEL3g=;
        b=R0f40nI7cq2eKAAMYXmvkNGOdReglx240bolhulsmbFvo2seWRf8hMShf8TiixEh5w
         chKZT3tKXBKWENUQrFEKkS27K2eqJjDKyki8gqFtg4563yvam6Pgt+eGstLFeFXDh3kd
         L5vehj5WruwIxHFDtOlnPlgGGg23oT8PZGN10abHQ8CChFD24LqXZNAtp4nqRmpC4FVc
         Sz+5mtM2vCSKmpZG70q7M2Jcl7KiYpgVbHbcHAUeZLUvq2BEdOfzhsmYkiQObj3Sv1J6
         YUzDYbXCATrt8bEg506W1gjh02o+oDD3xGFZV4891fpKMLKtBqOUhX1NMPFD0VSfk2lQ
         4mhQ==
X-Gm-Message-State: APjAAAWR+1KQDc6s8HkipUsL3y6j8p595PpvmUgMPices4R7Y29dvoiG
        CpIvUBV7Ofl4GaevuKxs8lz69CE=
X-Google-Smtp-Source: APXvYqxKa4P+GuN1q5TxElqHyMR3QAgbYhYhCljHTzIlbMcN6MuWHWWQVlXURutyxBtvDWV2YrwOnA==
X-Received: by 2002:a9d:62d2:: with SMTP id z18mr8427005otk.108.1574377763963;
        Thu, 21 Nov 2019 15:09:23 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s133sm1405942oia.58.2019.11.21.15.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:09:23 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: firmware: ixp4xx: Drop redundant minItems/maxItems
Date:   Thu, 21 Nov 2019 17:09:23 -0600
Message-Id: <20191121230923.4639-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minItems/maxItems default to the number of items in an 'items' list,
so drop the redundant specifying of them here.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../firmware/intel,ixp4xx-network-processing-engine.yaml        | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
index 4f0db8ee226a..878a2079ebb6 100644
--- a/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
+++ b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
@@ -25,8 +25,6 @@ properties:
           - const: intel,ixp4xx-network-processing-engine
 
   reg:
-    minItems: 3
-    maxItems: 3
     items:
       - description: NPE0 register range
       - description: NPE1 register range
-- 
2.20.1

