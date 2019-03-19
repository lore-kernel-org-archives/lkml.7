Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F652C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014F02146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ENZhMT2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfCSMGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:06:53 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:46685 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCSMGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:06:52 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B747025B7B1;
        Tue, 19 Mar 2019 23:06:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552997210; bh=h0a3Rh2SHQ+k6O0H0OYz89oF5fX7sD39Tvh9wjFyV6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENZhMT2rCVrP9JvqLYykf4nh6GVbrdlaIV95Qo2N1R29pg+k+ViS+LflpPa/tCfgH
         UbxUOVOUz9PwTd8eZId6tAlE/jTQVEQ++/ons/WyWuIDGuO9OeIsYcQZx8Zd5sWqoK
         aTaTkUeZKXXwvNWl28Y5YFLMkpbZQ2kKirIs5qUc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id BC9F8940663; Tue, 19 Mar 2019 13:06:46 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:06:46 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Jiada Wang <jiada_wang@mentor.com>, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH v3 0/3] rsnd: dts: change to use extended audio dmac
 register
Message-ID: <20190319120646.nqra6vjrvgynji3o@verge.net.au>
References: <20190319055705.24115-1-jiada_wang@mentor.com>
 <87va0fs92d.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va0fs92d.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:07:15PM +0900, Kuninori Morimoto wrote:
> 
> Hi Jiada
> 
> > According to user reference manual for R-CAR H3, M3-W and M3-N SoCs,
> > in order to access busif4 ~ busif7, extended audio dmac registers
> > (PDMASAREn, PDMADAREn, PDMACHCREn)
> > need to be used, rather than basic audio dmac registers
> > (PDMASARn, PDMADARn, PDMACHCRn)
> > 
> > Now DT bindings has stated that extended Audio dmac register set need
> > to be used when available with patch
> > https://patchwork.kernel.org/patch/10856905/
> > 
> > This patch set updates H3 (= r8a7795), M3-W (= r8a7796) and M3-N (=r8a77965)
> > to use extended audio dmac register set.
> 
> For all patches
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks.

Could I ask for this series to be reposted as a single patch?
