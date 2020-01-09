Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E7EC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908F62075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578568945;
	bh=W2gzVLodOj+BGgWG3Dmk2JiLTn4+m4I+y5h6d4W6bTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F9UVC2fdyCt9tQcpm8ktWxu361nqKShkR7r/+LvGSfylntCWOO7IhYImdjMZXJ7cu
	 ZOkj92xvUb33lohPj04EwcLq5+gZoqadFrdYh/SqBsqRUUhejtv6fB8p2Z0EE0VWKm
	 iml7WrhaQaI72FkGhYYfv65Y7t5pB5nx8ZjFoeD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgAILWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730579AbgAILWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:22:22 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1546D2067D;
        Thu,  9 Jan 2020 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578568942;
        bh=W2gzVLodOj+BGgWG3Dmk2JiLTn4+m4I+y5h6d4W6bTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rsi/kFebASjkNEXRn/s8u2hgtfbrJ/uO7gWaA4u4t69bKt0Sk+Nmh+hdTsZUDnHLq
         ZjkqUXoK2HRfIgKt5GFux+pLiRJlWl0G+DaG4wsdu0FGqjijoU+76L05tQ+ntLNUJu
         7aUrGhCB9AZKwELc66HN/B9+aAecq7+S+5KxotGs=
Date:   Thu, 9 Jan 2020 19:22:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] ARM: dts: imx7: Fix Toradex Colibri iMX7S 256MB NAND
 flash support
Message-ID: <20200109112210.GV4456@T480>
References: <20200108161232.327424-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108161232.327424-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 05:12:31PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Turns out when introducing the eMMC version the gpmi node required for
> NAND flash support got enabled exclusively on Colibri iMX7D 512MB.
> 
> Fixes: f928a4a377e4 ("ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC) support")
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks.
