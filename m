Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E583C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F7121019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfEMMPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:15:18 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:57672 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbfEMMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:15:17 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1C1B525AD63;
        Mon, 13 May 2019 22:15:15 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 00543E22B88; Mon, 13 May 2019 14:15:12 +0200 (CEST)
Date:   Mon, 13 May 2019 14:15:12 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] irqchip/renesas-irqc: Add helper variable dev =
 &pdev->dev
Message-ID: <20190513121512.mtt4drz5jebx3xco@verge.net.au>
References: <20190429152006.22593-1-geert+renesas@glider.be>
 <20190429152006.22593-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429152006.22593-4-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 05:20:04PM +0200, Geert Uytterhoeven wrote:

I think some text needs to go here.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

With an (updated) changelog feel free to add:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
