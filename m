Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F8C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0841D20706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLXOGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:06:07 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:52106 "EHLO
        webbox4.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfLXOGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:06:06 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Dec 2019 09:06:05 EST
Received: from local.marc.ngoe.de (unknown [141.98.102.187])
        by webbox4.loswebos.de (Postfix) with ESMTPSA id 21F4F4208B2C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 14:59:23 +0100 (CET)
Received: by local.marc.ngoe.de (sSMTP sendmail emulation); Tue, 24 Dec 2019 14:59:31 +0100
Date:   Tue, 24 Dec 2019 14:59:31 +0100
From:   Marc Burkhardt <marc@osknowledge.org>
To:     linux-kernel@vger.kernel.org
Subject: Regarding "Add Second Fan Support for Thinkpad P50"
Message-ID: <20191224135931.GA10817@local.marc.ngoe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux marc 5.4.6loc64
X-Virus-Scanned: clamav-milter 0.100.3 at webbox4.loswebos.de
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I was just curious if the patch

https://patchwork.kernel.org/patch/10320195/

somehow got lost or was never upstreamed. I remember to have seen both fans in
my P50 a while ago (presumably pre 4.19 era) but was unsure if I patched it manually or if
the patch got lost upstream.

Would be glad to get a heads-up on anything relevant. Please CC: as I'm
currently not subscribed.

Thanks,
Marc


-- 
Marc Burkhardt
