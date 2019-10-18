Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BAC20679
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436249;
	bh=quMH6BLAanqnkodOpRh/9pwNNiHQ946QHMuulLUv/x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k5wou+5Lf42/S7azroC864293SgwcEKTqU/jsVJzCVlVc1PGvXxaRX8xJPiRDfAez
	 SXjJRNJAJOT6NpCn72Mo893dDVDvEvmVcHnBSV3pvS/I6J+dczKgT4eNx9SfcFwYPH
	 zYHPedeO7qLiSqcGll3w6QJCMwsUs6e+kiy/IRqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfJRWEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfJRWEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40CD52245C;
        Fri, 18 Oct 2019 22:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436244;
        bh=quMH6BLAanqnkodOpRh/9pwNNiHQ946QHMuulLUv/x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olgWT/GQv/4awqCHg6F07tzzOhusffJtTSkpRKWYFb2HoekxGESUkPrbsF8Da3GJR
         C4ilnHeQBoGIFG1aLKGBs2+PiAuOS2htv0Gp3za9jznE34RZWb9E+BWFcitrWIEdPO
         49e4FJSapheBjP1w4WyCWDPF75s4Nxlo+6cxGVxs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 29/89] tty: serial: rda: Fix the link time qualifier of 'rda_uart_exit()'
Date:   Fri, 18 Oct 2019 18:02:24 -0400
Message-Id: <20191018220324.8165-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 5080d127127ac5b610b57900774d9559ae55e817 ]

'exit' functions should be marked as __exit, not __init.

Fixes: c10b13325ced ("tty: serial: Add RDA8810PL UART driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20190910041702.7357-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/rda-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 284623eefaeba..ba5e488a03742 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -817,7 +817,7 @@ static int __init rda_uart_init(void)
 	return ret;
 }
 
-static void __init rda_uart_exit(void)
+static void __exit rda_uart_exit(void)
 {
 	platform_driver_unregister(&rda_uart_platform_driver);
 	uart_unregister_driver(&rda_uart_driver);
-- 
2.20.1

