Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC36AC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF71D2239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563863605;
	bh=5QzpEX9xB74WtsuRfUjsDi+zdmjw8E5hXLVNHVBt3YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0FN9s/jYUXzGQSwm9RGVA3+jlulOXH6l+QCIwU2KiB0xyMxuZ1Za431HCoxyjQpKr
	 fgz2N2GOL2zfkt4YmsG38tb9a2Cl6XVPaPl2xuWb65YkGv62t7lcIhAkC3pzLAZBqx
	 ff5XxRAfrrdoduk558cFChzo5gNNWnahVjPt1ZwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfGWGdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbfGWGdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:33:24 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5352238C;
        Tue, 23 Jul 2019 06:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563863603;
        bh=5QzpEX9xB74WtsuRfUjsDi+zdmjw8E5hXLVNHVBt3YM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovPV1Bm9y+YiX2AbuUCWsK+OGLwIr5CqHu6QAtMMcV/pxzAs69l9Wq+l4cgaDFX6+
         JuI0a3bWo9au2uNz13wvnVXObTCS1yEG3aUZ8aGRyWFfh4qRhMIRhnaVLWEWGMWqrd
         Hv+HJqVcInnUWHeKdtLKdjZr8WUeLuy7jU4Xyscc=
Date:   Tue, 23 Jul 2019 14:32:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: imx8mq: Add DT node for the Mixel
 MIPI D-PHY
Message-ID: <20190723063248.GD15632@dragon>
References: <cover.1563187253.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1563187253.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:43:04PM +0200, Guido Günther wrote:
> Now that the driver is in linux-next as of 20190624 let's have a DT node
> for the i.MX8MQ and enable it on the Librem 5 devkit.
> 
> Changes from v1:
> - Add Acked-by: form Angus, thanks!

You do not need to send a new version for just collecting ack/review
tags.  I did that when applying v1.

Shawn

> 
> Guido Günther (2):
>   arm64: dts: imx8mq: Add MIPI D-PHY
>   arm64: dts: imx8mq-librem5: Enable MIPI D-PHY
> 
>  .../boot/dts/freescale/imx8mq-librem5-devkit.dts    |  4 ++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi           | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> -- 
> 2.20.1
> 
