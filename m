Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D474C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A6B205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 17:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfLaRhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 12:37:34 -0500
Received: from smtprelay0100.hostedemail.com ([216.40.44.100]:47713 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727064AbfLaRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 12:37:34 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id C9E9A1802145E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 17:37:32 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0528E2483;
        Tue, 31 Dec 2019 17:37:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owl80_7be59ebb0a42b
X-Filterd-Recvd-Size: 1626
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Dec 2019 17:37:31 +0000 (UTC)
Message-ID: <9e91f7b068ab99a2df041fbcf4786824b47f186b.camel@perches.com>
Subject: [PATCH] stm: Kconfig: Remove CONFIG_ prefixes
From:   Joe Perches <joe@perches.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Dec 2019 09:36:44 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig does not use the CONFIG_ prefix in a default statement
so remove these two uses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hwtracing/stm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index d0e92a..3e92e2 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -14,7 +14,7 @@ if STM
 
 config STM_PROTO_BASIC
 	tristate "Basic STM framing protocol driver"
-	default CONFIG_STM
+	default STM
 	help
 	  This is a simple framing protocol for sending data over STM
 	  devices. This was the protocol that the STM framework used
@@ -29,7 +29,7 @@ config STM_PROTO_BASIC
 
 config STM_PROTO_SYS_T
 	tristate "MIPI SyS-T STM framing protocol driver"
-	default CONFIG_STM
+	default STM
 	help
 	  This is an implementation of MIPI SyS-T protocol to be used
 	  over the STP transport. In addition to the data payload, it


