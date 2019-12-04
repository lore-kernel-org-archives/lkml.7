Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6596C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5EB2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575462189;
	bh=VQII2ZPJA4Onl4Fa0MDvbaFDqWFHNptYhZaZDw4M8ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lb4Y3HEOf6QgYsF3SijA/7bgoRp7qze02eZKsuX5nFdkU+kKUKMOvg+18zAYHBMxU
	 IyEZOffTT9si/j/hLXC04wUoVN6uI4AGKR5y9CkI3Rb+bp/pIe4JxccOccQzz3KR2c
	 9RLIi3u0VFgJA27TQsj/qRpc7gsmIQkW3cBwSaJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfLDMXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfLDMXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:23:07 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE5B207DD;
        Wed,  4 Dec 2019 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575462187;
        bh=VQII2ZPJA4Onl4Fa0MDvbaFDqWFHNptYhZaZDw4M8ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdsvOfZ2O4I4ckLl1rqlAETymbvDr7vTNxeYSHpWWf2qYYMcwuCrR3BLMqoa9xqZ6
         dDutb4vQNLhjVSShkAk3Ol3Gwgvfcuajbgm6MXuz8Otr/nwa5Kkeunco8Eyobrp+iU
         h2SKhzqF7qdLx+Mkier3X0mEyG7zahMzuzxVToTc=
Date:   Wed, 4 Dec 2019 20:22:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ARM: dts: imx25: usbhost port1 improvemts
Message-ID: <20191204122256.GK3365@dragon>
References: <20191120082955.3ovsoziurntmv7by@pengutronix.de>
 <20191120211334.5580-1-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120211334.5580-1-m.grzeschik@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 10:13:32PM +0100, Michael Grzeschik wrote:
> Michael Grzeschik (2):
>   ARM: dts: imx25: consolidate properties of usbhost1 in dtsi file
>   ARM: dts: imx25: describe maximum speed of internal usbhost port1 phy

Applied, thanks.
