Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64929C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40998229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfGXLM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:12:57 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45490 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGXLM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:12:56 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 60BE925BE40;
        Wed, 24 Jul 2019 21:12:54 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 5863AE22041; Wed, 24 Jul 2019 13:12:52 +0200 (CEST)
Date:   Wed, 24 Jul 2019 13:12:52 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, geert+renesas@glider.be,
        daniel.lezcano@linaro.org, linux-renesas-soc@vger.kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 2/7] dt-bindings: timer: renesas, cmt: Update CMT1 on
 sh73a0 and r8a7740
Message-ID: <20190724111252.bamz3fwd47n3kmwj@verge.net.au>
References: <156345023791.5307.6113391102648394591.sendpatchset@octo>
 <156345026539.5307.17098096827162445534.sendpatchset@octo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156345026539.5307.17098096827162445534.sendpatchset@octo>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 08:44:25PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> This patch reworks the DT binding documentation for the 6-channel
> 48-bit CMTs known as CMT1 on r8a7740 and sh73a0.
> 
> After the update the same style of DT binding as the rest of the upstream
> SoCs will now also be used by r8a7740 and sh73a0. The DT binding "cmt-48"
> is removed from the DT binding documentation, however software support for
> this deprecated binding will still remain in the CMT driver for some time.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

