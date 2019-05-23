Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71830C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336972177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558599470;
	bh=NnkwAg/YpYzmsV5gEgSTLJOum3MFjnwTcfMyU/RxFd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MAkdKyCmqb4WVUrI7JYmUlppuKI4hDcSasAE9c4wfvocY0iQz13ntVotUjK/duI8O
	 Bb3zOWAmJo/7bmKE4A3kbdvzzKDdHk/DmR6ns3tNCfQ9umeTtFarL0RpnXjkoOh/X3
	 cN7c7lwVS2EuaA5FPyNAhpJ3MVbPnFFeIj+gsoJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfEWIRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfEWIRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:17:49 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A922070D;
        Thu, 23 May 2019 08:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558599468;
        bh=NnkwAg/YpYzmsV5gEgSTLJOum3MFjnwTcfMyU/RxFd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewmsl7bUlQBSCNM43YojeCadG02W2pPb2VnIZCtlqjJ7dyLLaN49yif69QA4/tfhP
         Mr+dGy6ISYnQukwbAF1ecPpAscL3+oG3Toi74Ux/m55biAZh2ts/jGkg/SVcpKNMxz
         bUV7ADy2BQjDCPbZNo32c+RJRgaNQuDjbGtIbaPo=
Date:   Thu, 23 May 2019 16:16:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH] arm64: dts: lx2160a: Enable usb3-lpm-capable for
 usb3 node
Message-ID: <20190523081646.GK9261@dragon>
References: <20190515060434.33581-1-ran.wang_1@nxp.com>
 <20190523074300.GH9261@dragon>
 <AM5PR0402MB2865A81EB93DBAC90DB22E87F1010@AM5PR0402MB2865.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0402MB2865A81EB93DBAC90DB22E87F1010@AM5PR0402MB2865.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 07:51:41AM +0000, Ran Wang wrote:
> Hi Shawn,
> 
> On Thursday, May 23, 2019 15:43, Shawn Guo wrote:
> > 
> > On Wed, May 15, 2019 at 02:04:34PM +0800, Ran Wang wrote:
> > > Enable USB3 HW LPM feature for lx2160a and active patch for snps
> > > erratum A-010131. It will disable U1/U2 temperary when initiate U3
> > > request.
> > >
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > ---
> > > Depend on:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Fpatchwork%2Fpatch%2F870134%2F&amp;data=02%7C01%7Cr
> > an.wan
> > >
> > g_1%40nxp.com%7Cc6df41748bc243397d3008d6df526c04%7C686ea1d3bc2b4c
> > 6fa92
> > >
> > cd99c5c301635%7C0%7C0%7C636941942428322802&amp;sdata=NR2zs8BE%2
> > FNn8KdP
> > > do6%2FsNwJJdx2VgaQTy5H4bAlTJgw%3D&amp;reserved=0
> > 
> > Is the dependency accepted?
> 
> No, I got no comment for that post since then.
> lore.kernel.org/patchwork/patch/870134/

Please post dts patch only after dependency gets accepted.

Shawn
