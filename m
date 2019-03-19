Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A382C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEB12133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="r7tggnVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfCSOyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:54:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60262 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553007248; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=jlgCJ4Dau1v9odAPFCbEkuDwahsOl1J+W7P2eCMBdsE=;
        b=r7tggnVbpgDXjcd03x75PaXvnRYWdBt9uro/g70Yn9x/QNC/2jeMyCnay2XrYGUCrKMZT+
        AQDNU+NKBgcP8xBfU2KnMzeyaky17rBMaS7FPdYfkitU/ZOmwSdEeDQ7aXkhrfr1v8GWfG
        KlGdd0XQD69JCeHBO5U6K4P2Woxi0Ik=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/13] Ingenic NAND patchset v6
Date:   Tue, 19 Mar 2019 15:53:50 +0100
Message-Id: <20190319145403.31627-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes from V5 include just a typo correction in patch 09/13, and the
introduction of the patch 13/13 which is new.

The rest is untouched.

Thanks,
-Paul

