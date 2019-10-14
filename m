Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C1C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09EB21835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571058668;
	bh=3LD9agT50wYhkc1QJoVYpXn20M5JAD27JKogmrCezT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zs+87VWfsKaggXsF+i1P66t8WOJD8uVHoNpaW7HUlYu8e2iGjp4E2AgOlnefjeO0i
	 Uvdl2oPMI8E4N7ntPWA+B3qTkRQ/baLMJs6/DGBSwx/nIwCKBS6IkRXSfGeWElIGtF
	 JaDoUbkn9TaY6BGKc4KbG7rUNg54lSkDQA9I68QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfJNNLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:11:07 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB6C217D9;
        Mon, 14 Oct 2019 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571058666;
        bh=3LD9agT50wYhkc1QJoVYpXn20M5JAD27JKogmrCezT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBJRM3mJ+I5QrZv9JTewm1Rg1t6CO2JLMx6ohyWFstu9lbBxPeHt24qbmccDKPkqF
         4Y6/Xf5FZHEvD3DRfIRuLRDxPFSiwfyGfM2jK2ASIB1JNDqAtMobl9x1c+rLbEknG+
         lJzR9cqs3+Q4vjQpK8XPP9gYbnAf7AmeKKY3RTHc=
Date:   Mon, 14 Oct 2019 21:10:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.lezcano@linaro.org, ping.bai@nxp.com, daniel.baluta@nxp.com,
        jun.li@nxp.com, abel.vesa@nxp.com, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com, ccaione@baylibre.com, angus@akkea.ca,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] arm64: dts: imx8mq: Use correct clock for usdhc's
 ipg clk
Message-ID: <20191014131023.GV12262@dragon>
References: <1570496145-11053-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570496145-11053-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:55:43AM +0800, Anson Huang wrote:
> On i.MX8MQ, usdhc's ipg clock is from IMX8MQ_CLK_IPG_ROOT,
> assign it explicitly instead of using IMX8MQ_CLK_DUMMY.
> 
> Fixes: 748f908cc882 ("arm64: add basic DTS for i.MX8MQ")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
