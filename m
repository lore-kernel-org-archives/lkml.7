Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32DBC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895A92173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Y6QLQ2pV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbfGRHsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:48:06 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:35622 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGRHsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:48:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id A660D403CF;
        Thu, 18 Jul 2019 09:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1563436084; x=1565250485;
         bh=83evBhxtODtohedgaV6aM+vHrrS7QcbOE6k/hFx14cU=; b=Y6QLQ2pVQHgY
        SdcRZFsapqsEREMhAvkgEVL5QLesYnHJkIf6XAgzV+Kr4W+W0chCq1hUkR2fEXcm
        zxGlgojEFtiqGD983gnrWZRkOYBCi2lELwIDMhQM1Ie+X+Gn0alMN0P3FbDuQkSd
        RJkBGJ8Z/MV54HOjwB2YO0q4CbieyMffrWO4sJL9xS9GQFuoACNbtpqJCVqroYDL
        k6PleMAHMUG2QrJYd5SbevflNLPUsfIX03UCdwRaysUtravYn0IqZWXpPJefhYN2
        ry5fjEDI42+jfGoMfP0EwoXm1cfaYUK/MmiO1cS4K5rAr69qgiQPGqEW8g6ZC+ey
        1PW/ILVxAsPT+p7AVZrQUvG+JYMOYj59HVNLs4aIjW66wNfuZseOdiue+xp1jGe4
        dAF3nDP1/FRTxiUtW3xBRS62pGNUGiDolS9g6R1KQJ961k1oZGGibqDthkPD4PZT
        cTO2wGhr47iw0UKqEmQUK1UpiDSfsChAAgJhox+AVuLv6nWYVkq+6ZFPZ8qS3kdU
        P/gzrT401qlp/2vUTy4hOvUx4HcWE8qON/bQEl1Z7bS9DMmByfLxtMIJV6X3WsZL
        RKADSlm8x6dRvaOrj04rs911JuBHcD0D0/vP6CFwfvxocCItMeWtZMtmS400nE7h
        irC/K3RPwhkCcgPwG0/GrJkzNrGudjg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KG3Wh1Gztmwy; Thu, 18 Jul 2019 09:48:04 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 394AE403CB;
        Thu, 18 Jul 2019 09:48:04 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id DC64B312;
        Thu, 18 Jul 2019 09:48:03 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 2/2] doc:it_IT: rephrase statement
Date:   Thu, 18 Jul 2019 09:47:54 +0200
Message-Id: <20190718074754.29876-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The statement sounds more like a literal translation

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/it_IT/doc-guide/sphinx.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index d9ee4b1f098f..f1ad4504b734 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -242,9 +242,9 @@ del kernel:
 * Per inserire blocchi di testo con caratteri a dimensione fissa (codici di
   esempio, casi d'uso, eccetera): utilizzate ``::`` quando non è necessario
   evidenziare la sintassi, specialmente per piccoli frammenti; invece,
-  utilizzate ``.. code-block:: <language>`` per blocchi di più lunghi che
-  potranno beneficiare dell'avere la sintassi evidenziata. Per un breve pezzo
-  di codice da inserire nel testo, usate \`\`.
+  utilizzate ``.. code-block:: <language>`` per blocchi più lunghi che
+  beneficeranno della sintassi evidenziata. Per un breve pezzo di codice da
+  inserire nel testo, usate \`\`.
 
 
 Il dominio C
-- 
2.21.0

