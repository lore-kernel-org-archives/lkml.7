Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8847C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D17218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553147450;
	bh=xQs/76+yHijek8fdtf7Gki0+jnDU7d53gaB9O3sY/bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pV+BL0tcJeirb7/Tl4c7Xh5RqAook9NjJ5rXrFlo/iBTHp6LEOTQL5gIMl9t35Ng8
	 znz993t/2oCXLBcpg3dfncYoBsYFW3Fg+ULELgTuhSpLmhbg8RnBezpigEYLmVN1ga
	 q/KPngI7B6vPxFJOXB+89RCTGX4iyvL27Mxj/R9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfCUFut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfCUFut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:50:49 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447B6218A2;
        Thu, 21 Mar 2019 05:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553147448;
        bh=xQs/76+yHijek8fdtf7Gki0+jnDU7d53gaB9O3sY/bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIltED6dhRhfkmbowLWOxJtJgdaqpPuTf8JdFg4ddJs/xUBfdFLRbGfPzZQT4y60h
         2llvSODS4BsftYAXMKenQGtC9CVOyMlLKYnAtBiIMRcR5JN+wVq+StGz0BWhTrCQNE
         HDCaOyhoaR+vUkgV7Sv3X099NtLZ8FDxXpzEc93g=
Date:   Thu, 21 Mar 2019 13:50:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 1/4] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
Message-ID: <20190321055019.GC12513@dragon>
References: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:24:08AM +0000, Anson Huang wrote:
> Freescale MMDC (Multi Mode DDR Controller) driver is supported
> since i.MX6Q, but not yet documented, this patch adds binding
> doc for MMDC module driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
