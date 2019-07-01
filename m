Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA68AC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F36A20659
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="cRCvg6L0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfGAPOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:14:19 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:57160 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfGAPOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561994055; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=trQukpoD76EMuG9zgz5EGRmnNs/XLZ7ZjzLFF89DSQk=;
        b=cRCvg6L071xvaTc7ikBWQD5w2yHmpUkKZOzr+BqKW5KfvNCOza8zEDcgjeANafKi14hNwW
        /rl8a5XorTary5os2frno2y18GEC7Dbk4HiAIlYMq4Ib9irzVlC9iLqE+omSifp3dGXmgm
        ffbxz7ycoj7RmC7RUSF4y5LarKEh0OA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v14 00/13] Ingenic TCU patchset v14
Date:   Mon,  1 Jul 2019 17:13:57 +0200
Message-Id: <20190701151410.23127-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changelog from v13:

- [02/13]: The documentation has been converted to ReStructured Text.
- [04/13]: - Use ERR_CAST() instead of ERR_PTR(PTR_ERR())
           - Remove ingenic_tcu_can_use_pwm().
- [05/13]: Use %d instead of %i in messages
- [06/13]: Remove empty lines in structure definitions
- [07/13]: Remove empty lines in structure definitions

The patches that are not listed above did not see any change since v13.

Regards,
-Paul


