Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26241C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0665A2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfHMKU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:20:57 -0400
Received: from muru.com ([72.249.23.125]:57066 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfHMKUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:20:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A6CF5805C;
        Tue, 13 Aug 2019 10:21:21 +0000 (UTC)
Date:   Tue, 13 Aug 2019 03:20:50 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: am335x: Fix UARTs length
Message-ID: <20190813102050.GH52127@atomide.com>
References: <20190724122329.21231-1-manu@freebsd.org>
 <20190724122329.21231-2-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724122329.21231-2-manu@freebsd.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Emmanuel Vadot <manu@freebsd.org> [190724 05:24]:
> As seen on the AM335x TRM all the UARTs controller only are 0x1000 in size.
> Fix this in the DTS.

Thanks applying into fixes.

FYI, the module size is usually (but not always) 0x1000 with additional
0x1000 for the interconnect related registers.

Regards,

Tony
