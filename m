Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0A2C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF122184B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558413857;
	bh=lGaK0V78KG/uyMP7JCcQnQx4fQ3zJplP/kcPwEjE55s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h+5tz9SJbea0c5h1olb/SQycPG8B+FPU4fzQQvVWmsjxYuzCON7K8Gy6CGghx7JDG
	 WNCvRvdZYc7nNUobWiJsPUxx14aCJwqXenyyL1XuVvVKoiAHXFbmybrpsaF452N+fq
	 8/hgw4xFWWQJXTDjcY7qEUsqgHBkdIYNGWabontg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfEUEoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfEUEoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:44:16 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE39216B7;
        Tue, 21 May 2019 04:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558413855;
        bh=lGaK0V78KG/uyMP7JCcQnQx4fQ3zJplP/kcPwEjE55s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qu7Z3yPt2CoJXN1IZW1PMKeRr97ec00QRJ47UP0YVlZPfAGVDnuQZwg5yz6yxKjtl
         lcAAZ6z1b9XnW6i+lBq1LPmpOXDMZQAiUJvPouyKWDkOUo6GcV+iR9XwzubxR8kb0e
         uKXB9+YDkLCAAlZR5n39J76FmWPVak90izzBtKbQ=
Date:   Tue, 21 May 2019 12:43:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20190521044321.GX15856@dragon>
References: <20190521083756.4c8aee8a@canb.auug.org.au>
 <DB3PR0402MB39165C5944880EA0B0A37F91F5070@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39165C5944880EA0B0A37F91F5070@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:16:47AM +0000, Anson Huang wrote:
> Hi, Stephen/Shawn
> 	I realized this issue last week when I updated my Linux-next tree (NOT sure why I did NOT meet such issue when I did the patch), so I resent the patch series of adding head file "io.h" to fix this issue, please apply below V2 patch series instead, sorry for the inconvenience.
> 
> https://patchwork.kernel.org/patch/10944681/

Okay, fixed.  Sorry for the breakage, Stephen.

Shawn

> > -----Original Message-----
> > From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> > Sent: Tuesday, May 21, 2019 6:38 AM
> > To: Shawn Guo <shawnguo@kernel.org>
> > Cc: Linux Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel Mailing
> > List <linux-kernel@vger.kernel.org>; Anson Huang <anson.huang@nxp.com>;
> > Aisheng Dong <aisheng.dong@nxp.com>
> > Subject: linux-next: build failure after merge of the imx-mxs tree
> > 
> > Hi Shawn,
> > 
> > After merging the imx-mxs tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> > 
> > drivers/clk/imx/clk.c: In function 'imx_mmdc_mask_handshake':
> > drivers/clk/imx/clk.c:20:8: error: implicit declaration of function
> > 'readl_relaxed'; did you mean 'xchg_relaxed'? [-Werror=implicit-function-
> > declaration]
> >   reg = readl_relaxed(ccm_base + CCM_CCDR);
> >         ^~~~~~~~~~~~~
> >         xchg_relaxed
> > drivers/clk/imx/clk.c:22:2: error: implicit declaration of function
> > 'writel_relaxed'; did you mean 'xchg_relaxed'? [-Werror=implicit-function-
> > declaration]
> >   writel_relaxed(reg, ccm_base + CCM_CCDR);
> >   ^~~~~~~~~~~~~~
> >   xchg_relaxed
> > 
> > Caused by commit
> > 
> >   0dc6b492b6e0 ("clk: imx: Add common API for masking MMDC handshake")
> > 
> > I have used the imx-mxs tree from next-20190520 for today.
> > 
> > --
> > Cheers,
> > Stephen Rothwell
