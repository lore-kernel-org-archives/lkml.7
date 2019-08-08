Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E50CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6092F21874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565285190;
	bh=xOoHtkayuFTM7IWeNm0jfHM35tww8lvlY5cTq4QWz4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vOCe3fdPnCCFoXG+BFWvsk0YDnsUa4Us+ZCogo2iDU1qEForREX0nOo4lRTEkome4
	 8HMQTCtQVl162hnxaJOcEe2jWCocVo8k1Gu3cZJLzb7vGKysusYW1tbDvPetNcdJga
	 xOdsx8eb7VPGkCiNzvmnHYH+WVZFhQUiiFyPCoyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404322AbfHHR03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfHHR02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:26:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35FA72089E;
        Thu,  8 Aug 2019 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565285187;
        bh=xOoHtkayuFTM7IWeNm0jfHM35tww8lvlY5cTq4QWz4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P64gMLxxrmXkQPCOjRJJDlQTYL6eEul3R8cPVWBemZ5mBQpjal1FB5zKndFn/8zYf
         WrOCBuJMMUR+V1PG6B7dmoqvuGbovWqE8VrqlwOQT5wQjg53xNWF3Ib83bh2d+xri5
         qTXgIf3VWeNRj/mGzm8wrNDOfqz83Pb5zugx7b30=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     notify@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: eeprom: at25: Add Anvo ANV32E61W
Date:   Thu,  8 Aug 2019 19:26:15 +0200
Message-Id: <20190808172616.11728-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808172616.11728-1-krzk@kernel.org>
References: <20190808172616.11728-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for ANV32E61W EEPROM chip.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

New patch
---
 Documentation/devicetree/bindings/eeprom/at25.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
index b3bde97dc199..42577dd113dd 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.txt
+++ b/Documentation/devicetree/bindings/eeprom/at25.txt
@@ -3,6 +3,7 @@ EEPROMs (SPI) compatible with Atmel at25.
 Required properties:
 - compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
   Example "<vendor>,<type>" values:
+    "anvo,anv32e61w"
     "microchip,25lc040"
     "st,m95m02"
     "st,m95256"
-- 
2.17.1

