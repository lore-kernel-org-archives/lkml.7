Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F647C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C68A20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688666;
	bh=0nh5+i1rjdfaLOeNB4uasBXXAw/MjuDMBZUEmZWM2fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HhbHUxvzayjesE5Vu8r1HQBf8o7mvsMq7v7aEk58lt7I3iT0FqwG3SeoMoyPUhuzG
	 RNmHTSSsDDktxqokk5jkStqRNZuG5yEF7Pqh2ndbcg48+HQZw+nuQUi10G4bm0bq+5
	 mCuzEMVvuxQRWTIcGd03uPuNlyUpQAPE3IvwXn2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfCDIfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbfCDIfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:35:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E36A208E4;
        Mon,  4 Mar 2019 08:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688549;
        bh=0nh5+i1rjdfaLOeNB4uasBXXAw/MjuDMBZUEmZWM2fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWBQ/79rQkasss0Oy3CWk9ay56Aze/kGcbFnfXr3ccZK2XfRLZtlm2EN4T7dp/qet
         MC/G1N3/ZeQ5obTMY3SpcJcUu+jF+IG5VdlG0i3LcSq77t77GZBqzAGEnqMr1Jeg8C
         an9rf6UCzAcM32n5r27nqL63MZA8MDlfITSYBet4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, stable@kernel.org
Subject: [PATCH 4.20 78/88] crypto: ccree - add missing inline qualifier
Date:   Mon,  4 Mar 2019 09:23:01 +0100
Message-Id: <20190304081633.746960210@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit f1071c3e2473ae19a7f5d892a187c4cab1a61f2e upstream.

Commit 1358c13a48c4 ("crypto: ccree - fix resume race condition on init")
was missing a "inline" qualifier for stub function used when CONFIG_PM
is not set causing a build warning.

Fixes: 1358c13a48c4 ("crypto: ccree - fix resume race condition on init")
Cc: stable@kernel.org # v4.20
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_pm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/ccree/cc_pm.h
+++ b/drivers/crypto/ccree/cc_pm.h
@@ -30,7 +30,7 @@ static inline int cc_pm_init(struct cc_d
 	return 0;
 }
 
-static void cc_pm_go(struct cc_drvdata *drvdata) {}
+static inline void cc_pm_go(struct cc_drvdata *drvdata) {}
 
 static inline void cc_pm_fini(struct cc_drvdata *drvdata) {}
 


