Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3670CC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D93620840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="qNm+4cQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfFGQYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:24:44 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:59068 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbfFGQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559924681; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=mcQ/t/D7ql8zsl47FLhRZOVHwEqpOyHcf2rB4FvEu7U=;
        b=qNm+4cQaAJhBObHd+lCjEySlXv/b0p4Av4oSvs4sTyq2KxwFNWIKkxFHcLLhAuZG8ov8fo
        9WdYpspyCYE6EaRuuDvWTL3Co9B+mRtaCyjQGYFvdQAhB9kmaOYpai3bCFiKIgix2PZy5y
        6BtHGkDPhKx6CDXR6Ez92qFOVzHaAbc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     od@zcrc.me, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] JZ4740 watchdog cleanups
Date:   Fri,  7 Jun 2019 18:24:25 +0200
Message-Id: <20190607162429.17915-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 patchset didn't apply anymore on v5.2-rc3 so I rebased on top of it.
The previous patch 4/4 (which added SPDX license notifier) has been
dropped since somebody else did the job in -rc3.
So I added another cleanup as patch 4/4, and I tweaked patch 2/4 to
adjust to Guenter's feedback on V1.

Cheers
-Paul


