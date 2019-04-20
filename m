Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A943C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD875218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="LZHodeN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfDTKqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:46:19 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51324 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTKqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555757174; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=t48U9jSkloXavrVWCQ8wexCxy94BEuAxk0yrN4gB0xA=;
        b=LZHodeN6V1jyf7j9DTzIHUJaq3fCijrMx7lEW0vpeVCry8ec31T+zlQ9yvvIJyehaEAJkb
        kZhuOwv+AF/IObtd7xf5jzTqtmM878vYJmbnJtqz77UuLhR7lTMVQcqWDa4YsZDjpceHfk
        UTA81zADTtkHvhgq9kWoBXL3CRIwRlA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] ASoC: doc: simple-card: Add pin-switches property
Date:   Sat, 20 Apr 2019 12:45:51 +0200
Message-Id: <20190420104553.5071-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple-audio-card,pin-switches property can contain the list of
widget names for which pin switches must be created.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 4629c8f8a6b6..79954cd6e37b 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -24,6 +24,8 @@ Optional properties:
 					  a microphone is attached.
 - simple-audio-card,aux-devs		: List of phandles pointing to auxiliary devices, such
 					  as amplifiers, to be added to the sound card.
+- simple-audio-card,pin-switches	: List of strings containing the widget names for
+					  which pin switches must be created.
 
 Optional subnodes:
 
-- 
2.21.0.593.g511ec345e18

