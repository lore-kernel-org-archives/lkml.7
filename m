Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB45FC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B4C217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554950585;
	bh=dFs87/I5FzSAKmfefEU/2kxGJKT+FUKq0QrvX8wspck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQ4z/SBvKXt9g5B9CVtOZpSg+9XNDD+yROJGoe5avFJjKhEysoGRDhAKP04g3eN/m
	 pNYUY+dZJ0Z3pAF7r01T6FAJXLTvzLvVWVXPi8wGr/sUFZn/EtfJPgYFEmRc+bXtB+
	 V2dIgsyWPnLiC1Z2w46uyu8Nr6G2chnSgw2o6TSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDKCnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfDKCnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:43:04 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1BC2217D9;
        Thu, 11 Apr 2019 02:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554950583;
        bh=dFs87/I5FzSAKmfefEU/2kxGJKT+FUKq0QrvX8wspck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRHDzfUSrkXr4n9W4H3po3dQplC0qiYdnWfkPKeOX++hc37AgkObCOyRt/3lDafEw
         y+K2N9sltJyfr1QDVS3iSf1Z1yuS+qCgIeAh1RbNEo/S9MaeufBxhOr44llXli7suy
         RrnZxAkiIBlHBuixi2ziOqDHdyjEB6/rXvHybGgE=
Date:   Thu, 11 Apr 2019 10:42:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: imx6: RDU2: Use new CODEC reset pin name
Message-ID: <20190411024250.GL26817@dragon>
References: <20190329181313.21009-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329181313.21009-1-afd@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 01:13:10PM -0500, Andrew F. Davis wrote:
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", the driver now accepts this name, use it here.
> 
> Note the GPIO polarity in the driver was ignored before and always
> assumed to be active low, when all the DTs are fixed we will start
> respecting the specified polarity. Switch polarity in DT to the
> currently assumed one, this way when the driver changes the
> behavior will not change.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>

I fixed up the prefix to use board name, and applied patch #1 ~ #3.

Shawn
