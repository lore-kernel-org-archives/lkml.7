Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF61C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99E824323
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172260;
	bh=8GQmxYNvc9kVeZgKQADV4wNZdH+5FpG/CkJ8VXm9/To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZ78OCkPJ2bMMnq/aAljUtFC3E3KrgDEDD41k2BfUqQPTgpEgCWTnwFWPa9aq0o2h
	 0QwwooL0dH0Ig26kp63O/RXKgJ9v8fKzZnebLy96iA2WPt1eEjYYyRMJ7FL69sQ7tZ
	 CAfP+Sy8co05Qx+9O7yblRTctbz/KU+EHvk9Y9nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfE2XYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:24:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2XYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=seXeb75OKv0MSbPUJnbqhrRx7j2bM0Rtx83TOff+P2A=; b=Yeb9ALjiDrJ2ntYw5ga3E6+tli
        OMTK2A3HyHnHqn0hTVbhfhwLbANaOml46BH/EEqJ3GANruwXTmGqfSlaOaNGU5y51d55PlniD+U6m
        M0c5eTDsy58l7WhFozsuqHvyr0xHO75Sk99/V8tkwK8lA/a1ig0fDaZTA4vVCsuHuplGZZkGUvG7K
        UmnxPgN+VWZnL8PHbB3qNzPKJdNeXHjG8h7xZ9hRSselkAA3VMU9xeCvgmczisdXgO1rdQZf16RqJ
        VywTWx4eiCad+BWWOmtco8UEKGgcpZFRfWZVG4rlaCZ1okoVaUdpkq5V3V3OBhYGTlOBqRxtL2YTJ
        /Q4x+90w==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rd-26; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007x6-L0; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: [PATCH 06/22] doc: it_IT: fix reference to magic-number.rst
Date:   Wed, 29 May 2019 20:23:37 -0300
Message-Id: <76713fe801e082e54e4412331d14495f2620ee59.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo at the referred file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/translations/it_IT/process/magic-number.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
index 5281d53e57ee..ed1121d0ba84 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/magic-numbers.rst <magicnumbers>`
+:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_magicnumbers:
-- 
2.21.0

