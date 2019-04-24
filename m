Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECB8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3521221900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfDXOLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:11:36 -0400
Received: from muru.com ([72.249.23.125]:47064 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfDXOLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:11:36 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6A7918102;
        Wed, 24 Apr 2019 14:11:50 +0000 (UTC)
Date:   Wed, 24 Apr 2019 07:11:30 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     arm@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        nicolas.pitre@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kgene@kernel.org, krzk@kernel.org, robh@kernel.org,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] ARM: OMAP2: drop explicit assembler architecture
Message-ID: <20190424141130.GB8007@atomide.com>
References: <f48c245e7e2b432f6771a5f97ff9f4b5bedc5089.1554968922.git.stefan@agner.ch>
 <d0fb7e55d76da42bea449011ec38b0ad651a3778.1554968922.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0fb7e55d76da42bea449011ec38b0ad651a3778.1554968922.git.stefan@agner.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Agner <stefan@agner.ch> [190411 07:53]:
> OMAP2 depends on ARCH_MULTI_V6, which makes sure that the kernel is
> compiled with -march=armv6. The compiler frontend will pass the
> architecture to the assembler. There is no explicit architecture
> specification necessary.

Acked-by: Tony Lindgren <tony@atomide.com>
