Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC4FC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C3821726
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564844944;
	bh=CvSRvoCvfnH3vwE3GQcII3LWELkHv2KpyM7B73oc39Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gbF0zT40xo4rR8rd+yOKEPcMC6n9Yu3JSRMYCn3Fr/h7Bm0R9PeDlU4VbVMFrbCsN
	 k7I4+jqwWVJq+T1mg7rpJ3oH2vBhCjPeW3Dmjx/VtaaqaK5CU/9TXjgTB0ys+kfSgB
	 DJtrGrEe735CM3Onub06IcaoJ6iOPvhyAf/QxrCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfHCPJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 11:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfHCPJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 11:09:02 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713E02073D;
        Sat,  3 Aug 2019 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564844941;
        bh=CvSRvoCvfnH3vwE3GQcII3LWELkHv2KpyM7B73oc39Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRVFMsPqAdbGsKqXqMeeyjWwYOGsUZnOTZnB338p05uZO3bYwtZ2nx7WQ1jpJwna+
         vq8frhCNXjQov4cP6XEJ3JZ2iDdttYGdEp69eXqQN+vUUscxfKuUejKYahJW00hEuA
         czIwbxTA9UcIgFUU5Pf2O5ozROEvd9IeZzPRc0IY=
Date:   Sat, 3 Aug 2019 17:08:55 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx25-pdk: native-mode is part of
 display-timings
Message-ID: <20190803150852.GQ8870@X250.getinternet.no>
References: <20190729142316.21900-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729142316.21900-1-martin@kaiser.cx>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 04:23:16PM +0200, Martin Kaiser wrote:
> Move the native-mode property inside the display-timings node.
> 
> According to
> Documentation/devicetree/bindings/display/panel/display-timing.txt.
> native-mode is a property of the display-timings node.
> 
> If it's located outside of display-timings, the native-mode setting is
> ignored and the first display timing is used (which is a problem only if
> someone adds another display timing).
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks.
