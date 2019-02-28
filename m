Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CC3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0352064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xaEKgdb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbfB1WIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:08:12 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:57094 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1WIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551391688; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=QnuOgZNbwA6He1rYJuXg6/GVJD9oOM28rbK7opqN15w=;
        b=xaEKgdb8f6dyhl+iE+o1tlPhbeUeVaMbqU+N1Jn2A4EIMocExBhKcyK8PkAKNZnG6FaHeR
        PXtDF8Lez2R9J3u9fGkRu4ID1M+bDReRRoZ5+1psE4xQ9DvmO9H3trbSnIWzF768MLqOx9
        lqukxxPjQi1I4KiVFJJmj17OW+ZY1v8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [5.2][PATCH 0/3] Ingenic JZ47xx KMS driver
Date:   Thu, 28 Feb 2019 19:07:53 -0300
Message-Id: <20190228220756.20262-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a first attempt at a KMS driver for the JZ47xx MIPS SoCs by
Ingenic. It is aimed to replace the aging jz4740-fb driver.

The driver will later be updated with new features (overlays, TV-out
etc.), that's why I didn't go with the simple/tiny DRM driver.

The driver has been tested on the Ben Nanonote (JZ4740) and the
RetroMini RS-90 (JZ4725B) handheld gaming console.

Greetings,
-Paul

