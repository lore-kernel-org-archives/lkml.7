Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AC621019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551680176;
	bh=Zefn+nF47nBaJAuksZKrNh7A3nGJYx47mva1XzhuXjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zwrdNCeGEPfriIRPQ5VJ9v6doE771nJWaX6M6c/X0yzE2/dB87/mE3fvGAQ0zeJE8
	 09K7+uYXpV5KmgG4uRlK9coXd/5l7lDtb+UEwGWcjEHtv1KQJMV7BijSfV99zn/j2t
	 l7dfvIuCskmoWU5ukHdkM6kphGD6BeeOoHI9IpfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfCDGQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfCDGQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:16:14 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B2620815;
        Mon,  4 Mar 2019 06:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551680174;
        bh=Zefn+nF47nBaJAuksZKrNh7A3nGJYx47mva1XzhuXjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Z3o3bk8I8KVWzN2hnIK/8tnqdG/WM5dGZftuTOvVqF2NSvUT1LmFxeP6rjI1s+3M
         /srtxwja/B0Yiiv3HEn39arXGhRDaMQN4SGcUNceMiG4LgvBBZ1PjqNI639inPIlVf
         9XUOtn6BYBO4bwzen/8fzxHcRIbFwoqanT989zko=
Date:   Mon, 4 Mar 2019 14:15:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, adam.ford@logicpd.com,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Add GPIO_PCF857X
Message-ID: <20190304061508.GA26041@dragon>
References: <20190304023231.19232-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304023231.19232-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 08:32:30PM -0600, Adam Ford wrote:
> The imx6q-logicpd board has a PCF8575 connected to it, so this
> patch turns it on my default now.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
