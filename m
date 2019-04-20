Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC46C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 13:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1F221479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555766831;
	bh=M/UaUOzISQNcGCu1opNdW/fSR8eqQJdOFcKirgJLyvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fy6xrQ0Cdn5m0RpXZrz2w7ETSqijxsJPautKpYfpz3Xy4arHd/jVmEevgsELAyH9a
	 KrIvVb6fGiruSyonDtFv8RkV2AaAE8+I8Zo9+UXbrzA3nTOuUzLxRFvsnAn8tTklLO
	 WFG9/R9Kh4UwqNS6wrWat/Yg+f5oQ/jQr8B1Xr+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDTN1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 09:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfDTN1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 09:27:10 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3EF12183F;
        Sat, 20 Apr 2019 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555766829;
        bh=M/UaUOzISQNcGCu1opNdW/fSR8eqQJdOFcKirgJLyvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dao5kmSgn9AY+VEsVDCO2C+78uhT0JcktCJypdbQgOAMNcXpMlM0SEYTj6B+poYKF
         WKI8V7kX0TnSWh1LZ6GVFhPlGhFwg4IxDspsX03JGt7VHmGKLd8WddyMbSZYfizRRh
         2WVfAqrQxc7riJcKfbo4tLWvAh4a1hCmze26eZvo=
Date:   Sat, 20 Apr 2019 21:26:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND v2] soc: imx: Add generic i.MX8 SoC driver
Message-ID: <20190420132654.GA14187@dragon>
References: <1553273350-28852-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553273350-28852-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:49:20PM +0000, Abel Vesa wrote:
> Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
> For now, only i.MX8MQ revision B1 is supported. For any other, i.MX8MQ
> revision it will print 'unknown'.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
