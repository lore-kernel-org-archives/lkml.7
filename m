Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC95C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 17:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EF821739
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 17:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rf6BaFxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfKPRwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 12:52:41 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48426 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfKPRwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 12:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1573925778; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=gKU6GiFlUb8UQfyfv8NKb20R3I598oD9FZm/gFaooD4=;
        b=rf6BaFxT5kXa/WHIf1TkiVzCu/zZ69UK9u/NZUIDZ8zW/vbTgboRmGBONG8xC+t2VGc7V4
        riv5rOjUXUR5DFiPqXtG3PCJYCwZMFrbuDOI56R9YC2zRL8LAo1fGwAqb7hsUPsS4IuVnz
        /8ZkBbRmCmYOyl0mf8m2+uWVpGF9KiA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] pwm: jz4740: Update to use TCU clocks/regmap
Date:   Sat, 16 Nov 2019 18:36:10 +0100
Message-Id: <20191116173613.72647-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patchset v1 had 7 patches. Some of them require more feedback before I'm
comfortable sending them upstream again; so I just cut the previous
patchset in half, and will upstream the second half in due time.

Cheers,
-Paul


