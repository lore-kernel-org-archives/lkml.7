Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D945CC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BEB2239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563864685;
	bh=2PEabLQdxDtWnRcRsZOFnGlttMZoHgZMcHmMfRFeAR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mxrZxexQZkN7Wc5CcoM/VOd2PRisaxN+X4UqGtha5IMHvQoBbK8kTdBVzoEiOrDK3
	 r7+AFYBLLeVkuImmJ8zLscNaCytmXL/CeczqFrVbW2oZ1l0byZ5mD1ygiPGnyfaT2v
	 vzlRSpQPBHC7m/4Uea5iapbh+MmMf5s6MJH3XbZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfGWGvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbfGWGvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:51:24 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BACE62238E;
        Tue, 23 Jul 2019 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563864683;
        bh=2PEabLQdxDtWnRcRsZOFnGlttMZoHgZMcHmMfRFeAR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQUGdPuTBh75fEOoYSmaYweTgby1ojc/fZilqWwWDdDt2YJt+Q81ypxTvaK3KexAC
         fvstB/mVidORvb9L04Xm5mrxzhj0mqb3MUopMNFOhO4gtpueR2TN3BrcE/t+HtXicU
         y8t1QZhTZkel4UC4C3cmA6JKJF3eCkN28jxwH4MI=
Date:   Tue, 23 Jul 2019 14:50:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pramod Kumar <pramod.kumar_1@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: nxp: Add device tree binding
 for ls1046a-frwy board
Message-ID: <20190723065052.GE15632@dragon>
References: <1563284586-29928-1-git-send-email-pramod.kumar_1@nxp.com>
 <1563284586-29928-2-git-send-email-pramod.kumar_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563284586-29928-2-git-send-email-pramod.kumar_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 01:43:27PM +0000, Pramod Kumar wrote:
> Add "fsl,ls1046a-frwy" bindings for ls1046afrwy board based on ls1046a SoC
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thanks.
