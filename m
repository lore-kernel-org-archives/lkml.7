Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DACC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 22:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C19206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 22:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="eXdMs6dW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="eXdMs6dW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEAW5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 18:57:32 -0400
Received: from node.akkea.ca ([192.155.83.177]:38822 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfEAW5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 18:57:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 8771B4E204D;
        Wed,  1 May 2019 22:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1556751449; bh=EcCG5BHlQcQhwE/EjWPG7SnhP7EtT6S3cNHENhNVccA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eXdMs6dWTGCtdfkrrzYGdm8XUp21DpO95heLSMrCeSwBLoy/yhG2MCDGwsQ6Zki2e
         UpZSjqQ8qKR3JaPQm5oJ/3WXQjtiP3YIcIF+3zF9X3D1kqOt+Fr/YKHmXi7J3sz14D
         JIvq7Ji/R3AzHTm2EXEhJFmHUqJhO65T/DkbHNyM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h82_f7s1feWO; Wed,  1 May 2019 22:57:29 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 915334E204B;
        Wed,  1 May 2019 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1556751449; bh=EcCG5BHlQcQhwE/EjWPG7SnhP7EtT6S3cNHENhNVccA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eXdMs6dWTGCtdfkrrzYGdm8XUp21DpO95heLSMrCeSwBLoy/yhG2MCDGwsQ6Zki2e
         UpZSjqQ8qKR3JaPQm5oJ/3WXQjtiP3YIcIF+3zF9X3D1kqOt+Fr/YKHmXi7J3sz14D
         JIvq7Ji/R3AzHTm2EXEhJFmHUqJhO65T/DkbHNyM=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/3] dt-bindings: Add an entry for Purism SPC
Date:   Wed,  1 May 2019 16:57:18 -0600
Message-Id: <20190501225719.3257-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501225719.3257-1-angus@akkea.ca>
References: <20190501225719.3257-1-angus@akkea.ca>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d058b5102664..81f097f26953 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -332,6 +332,7 @@ poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
 probox2	PROBOX2 (by W2COMP Co., Ltd.)
 pulsedlight	PulsedLight, Inc
+purism	Purism, SPC
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
 qemu	QEMU, a generic and open source machine emulator and virtualizer
-- 
2.17.1

