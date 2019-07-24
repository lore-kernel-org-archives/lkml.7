Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80175C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC2C20840
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nxW5tHtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfGXRQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:16:31 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49052 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfGXRQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563988587; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=UW636SR0a7qD89QcgE1WVfQ4riiw9zkKPDE/geWRRwA=;
        b=nxW5tHtlL48qn0CJvoOYTB5ipynVqOTPhNS8uAwZzHV3oZNeVHN1GwUruUAe9UCkJzPuS9
        QN4Z7HEHp1uXSA7BMBADjafwYs1M2L/x+JNUk/lmPeNtfednz3mHuf7ukaQlBtljCq7YXV
        MGjoC8NuegF6bNEsT9MwPWEJgPYzwpM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH v15 00/13] TCU patchset v15
Date:   Wed, 24 Jul 2019 13:16:02 -0400
Message-Id: <20190724171615.20774-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the V15 of my Ingenic TCU patchet.

The big change since V14 is that the custom MFD driver
(ex patch 04/13) was dropped in favor of a small patch to syscon
and a "simple-mfd" compatible.

The patchset was based on mips/mips-next, but all of them minus
the last one will apply cleanly on v5.3-rc1.

Changelog:

* [02/13]: Remove info about MFD driver
* [03/13]: Add "simple-mfd" compatible string
* [04/13]: New patch
* [05/13]: - Use CLK_OF_DECLARE_DRIVER since we use "simple-mfd"
           - Use device_node_to_regmap()
* [06/13]: Use device_node_to_regmap()
* [07/13]: Use device_node_to_regmap()
* [09/13]: Add "simple-mfd" compatible string

Cheers,
-Paul


