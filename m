Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC2AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C12214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554284467;
	bh=NXyN6Su33fVYiNatkAtDtUCyzSWg58qHU+DgJyZ8oD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tOzy2emK34mpsqWegqbfUOK9MkJ7+C23D97Je+mcb5KSTBAgBtkcIslVL7xweBN0b
	 qQi3wdEqFIEn99m+Ftsdgoxro5eAmMK02q5KR4LhdRCEXDokZFyiLiIya/AEel7Toy
	 +gOEWUGuZpo4jwLfH/IuuhcvQAxd7/ecfJtllv8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDCJlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfDCJlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:41:06 -0400
Received: from X250 (unknown [147.50.13.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECA972082C;
        Wed,  3 Apr 2019 09:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554284465;
        bh=NXyN6Su33fVYiNatkAtDtUCyzSWg58qHU+DgJyZ8oD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ab/UIeXqu4GmP/gjv9yfCRo2xIckGDdfgM3IhT5E0sYp6tmZhJSkjFsxKpM4KlOX8
         0bVA3DGdZthF5DL7opaLgjL2W3jOF3j7Z9JVh0iQrFiUR9t/9tYHjHW8GTJRQ8gqdv
         UwyhZA/RIlttF1KUbjOFujPUXb15RdHxpdEoHyj8=
Date:   Wed, 3 Apr 2019 16:40:58 +0700
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx7d: Specify viewport count for PCIE
 block
Message-ID: <20190403094057.GE7932@X250>
References: <20190327063841.28350-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327063841.28350-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:38:40PM -0700, Andrey Smirnov wrote:
> i.MX7D comes with 4 viewports, so configure PCIE node accordingly so
> that the driver won't assume we only have 2.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied both, thanks.
