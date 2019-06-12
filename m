Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77095C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52196215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560336694;
	bh=5jRu86QAzs8zA/gs6Ny1LZmMgOJJIteMCKmKfzBwhHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w+CPHZAA3HlsqiMl4y8ecPT4VCCq3Xb0n8jq6+UiDGJk4s4PZze8KYttGhlEB0Fee
	 fhpnI3CmApWEMPe5HR+TFFTf1FlhPF+fGpHF8YtyQCh6OLQ0kpLenIT4kmLNyNIQ2s
	 jStmAwABLEz9+/OTCphCia+Duz2hcPzkAr2AJKAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408159AbfFLKvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408073AbfFLKvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:51:33 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA2B2082C;
        Wed, 12 Jun 2019 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560336693;
        bh=5jRu86QAzs8zA/gs6Ny1LZmMgOJJIteMCKmKfzBwhHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0ls4eEvZEtUNYXQwDlIQ4pDBNaY2f40S56gTpQwSvu0MSqD38juSsqmRfqKf1KnW
         2ysxeCtP8pcQv9OpTLgAtGTR8X0fjCiDCTBJwxM6YHYOuw+bTJq17DCwCisAUFtqh2
         4MxqM16t3QM1jduhmlQY9N9RHdhYruyUm5hoqV50=
Date:   Wed, 12 Jun 2019 18:51:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20190612105059.GG11086@dragon>
References: <20190607074652.4b3d0c97@canb.auug.org.au>
 <20190607002407.GY29853@dragon>
 <AM0PR04MB44817EB65913F29630453E1A88ED0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44817EB65913F29630453E1A88ED0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:36:52AM +0000, Peng Fan wrote:
> Hi Shawn, Stephen
> > Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
> > 
> > On Fri, Jun 07, 2019 at 07:46:52AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > In commit
> > >
> > >   f6a8ff82ce68 ("clk: imx: imx8mm: correct audio_pll2_clk to
> > > audio_pll2_out")
> > >
> > > Fixes tag
> > >
> > >   Fixes: ba5625c3e27 ("clk: imx: Add clock driver support for imx8mm")
> > >
> > > has these problem(s):
> > >
> > >   - SHA1 should be at least 12 digits long
> > >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> > >     or later) just making sure it is not set (or set to "auto").
> > 
> > Hi Stephen,
> > 
> > Thanks for reporting.  I just got it fixed, will be more careful about that in the
> > future.
> > 
> > @Peng, please check your git configuration as suggested above, thanks.
> 
> Sorry for this. Do I need to resend the patch?

No.  I have fixed it on my branch.

Shawn
