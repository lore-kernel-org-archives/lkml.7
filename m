Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764DCC2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 02:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A499206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577067025;
	bh=IP8jrLcMX+FKOOup0LQ7X+9yrMN/Bg1Te1ZjcEOE5SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=avT1ShGPfqfQwPdEyNfNonZAIjDyII3hcrOoRu4eGizIBpFORyzaEPTDCT7GdJT7d
	 LWcF4gUShw4kLpnDo/9xg/5Rcl99+vC5+lgQ1sfAhktwYmsLCxYO5ZthoI+K6Nc83/
	 gOQ9jJH9rdRBrG9SolldnleatRGRGRRexTTeywSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLWCKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 21:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfLWCKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 21:10:24 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 703E8206B7;
        Mon, 23 Dec 2019 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577067023;
        bh=IP8jrLcMX+FKOOup0LQ7X+9yrMN/Bg1Te1ZjcEOE5SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yYVxAX3TAylTNpTa/K6tJTOmBFPWzkqHdSuzfj81IJvlXnKaY53ug72iFEyp6w/EH
         Jvp1HF5udbqXXoOHd+C6/SkMrEoNA409Ts2J6MrsjJ+c7ggAiT1gFlD8/biPtxY+BH
         Y12bRsVm6C63qv3UWFDL+4Oj/H2wwsvixH++fG2o=
Date:   Mon, 23 Dec 2019 10:10:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: lx2160a: add EMDIO1 and phy nodes
Message-ID: <20191223021003.GD11523@dragon>
References: <20191204165828.29893-1-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204165828.29893-1-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ioana,

On Wed, Dec 04, 2019 at 06:58:26PM +0200, Ioana Ciornei wrote:
> This patch set adds the External MDIO1 node and the two
> RGMII PHYs connected to it.
> 
> Changes in v2:
>  - added a newline between nodes in 2/2
>  - moved the WRIOP node (sorted by unit address) in 1/2
> 
> Ioana Ciornei (2):
>   arm64: dts: lx2160a: add emdio1 node
>   arm64: dts: lx2160a: add RGMII phy nodes

I was just reminded by people who want to search the patch on
linux-arm-kernel@lists.infradead.org, that you should copy that list as
well.  Generally you should use scripts/get_maintainer.pl to find
recipients when sending patches.

Shawn
