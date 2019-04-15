Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6874C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0812073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355797;
	bh=q+4pjPZ1jZOTtIAFNsg9ZAhepzhuc5cL95X2C98unBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cl5wvJVf/eqwqVMQTxPYk1lbVEVme/wd5+jqnPa9K1RbR9O4xnjk8gu2EMOjKy4dq
	 +NROUf/y8LHvZtdA1S/03XWin0NKZLZ3ByKPzuRIOPp5jP4ia6veY6MNfzS36TjbYH
	 WR+MJJnFS4L+QXNlYJHxpEtAb4OPIpoGJcbHAbmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbfDOTNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730804AbfDOTNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCA020880;
        Mon, 15 Apr 2019 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355583;
        bh=q+4pjPZ1jZOTtIAFNsg9ZAhepzhuc5cL95X2C98unBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHtpN89Ifj638RGDT7tFJuRcmKgzr/oiAD7dfmXzye3gV7vNzUCT8FHf2kFmQUuRP
         +T8KmxObjcMfBJyXQM/Znma/wd+WEi5G12aj4py44ufdBIN1IK673/pwlfRft+h1bQ
         XL4yLlYok6fFeaVXkqKAE+MkPYyec0sG1ZPsqQEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Engraf <david.engraf@sysgo.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 5.0 090/117] ARM: dts: at91: Fix typo in ISC_D0 on PC9
Date:   Mon, 15 Apr 2019 21:01:00 +0200
Message-Id: <20190415183749.450639153@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Engraf <david.engraf@sysgo.com>

commit e7dfb6d04e4715be1f3eb2c60d97b753fd2e4516 upstream.

The function argument for the ISC_D0 on PC9 was incorrect. According to
the documentation it should be 'C' aka 3.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Fixes: 7f16cb676c00 ("ARM: at91/dt: add sama5d2 pinmux")
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sama5d2-pinfunc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/sama5d2-pinfunc.h
+++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
@@ -518,7 +518,7 @@
 #define PIN_PC9__GPIO			PINMUX_PIN(PIN_PC9, 0, 0)
 #define PIN_PC9__FIQ			PINMUX_PIN(PIN_PC9, 1, 3)
 #define PIN_PC9__GTSUCOMP		PINMUX_PIN(PIN_PC9, 2, 1)
-#define PIN_PC9__ISC_D0			PINMUX_PIN(PIN_PC9, 2, 1)
+#define PIN_PC9__ISC_D0			PINMUX_PIN(PIN_PC9, 3, 1)
 #define PIN_PC9__TIOA4			PINMUX_PIN(PIN_PC9, 4, 2)
 #define PIN_PC10			74
 #define PIN_PC10__GPIO			PINMUX_PIN(PIN_PC10, 0, 0)


