Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2A420815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558360344;
	bh=zLJE7fSlwx12Tuz3qbPRzVc45vPUmMh4VY0VfsaR9RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X9d/EsuMY27SfjFDPkicFveufXR9PIKJCLk7kzokPfbBbu7s519IMoD5U9z1cFlac
	 6Xg29FGWBAJUxaJergab0hqyW6/LIlAuYhsw4iRm3Z314wSP4GdtOa/IUoTS6ScIzK
	 eGbhPRPM9TS6tTHFT62xvyk8srBrOEO/b2uHWuAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390169AbfETNwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731680AbfETNwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:52:19 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45FD20815;
        Mon, 20 May 2019 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558360338;
        bh=zLJE7fSlwx12Tuz3qbPRzVc45vPUmMh4VY0VfsaR9RM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOiDe3tf3f0Ln5UOM5A2JNH33E918pBqbFredvvn4u+nDJF37rujbMacv2USRbBD3
         StIl13N2S13xocm/FFLwNWTKXPhw+TN1Nm17+MI3CQd7VnoaBK4d1eoQxStwDmTxue
         ARyppLCzzAqLuPJTgO+1MZysDYDf3KgRJsfUI+n8=
Date:   Mon, 20 May 2019 16:52:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [EXT] Re: [PATCH] checkpatch: add test for empty line after
 Fixes statement
Message-ID: <20190520135214.GM4573@mtr-leonro.mtl.com>
References: <20190520124238.10298-1-michal.kalderon@marvell.com>
 <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
 <MN2PR18MB318292E37F3AB9383D9FBE0FA1060@MN2PR18MB3182.namprd18.prod.outlook.com>
 <60717bc4cdf327ffe671c328d47c315eefd385c8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60717bc4cdf327ffe671c328d47c315eefd385c8.camel@perches.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 06:34:49AM -0700, Joe Perches wrote:
> On Mon, 2019-05-20 at 13:16 +0000, Michal Kalderon wrote:
> > > From: Joe Perches <joe@perches.com>
> > > Sent: Monday, May 20, 2019 3:57 PM
> > > Subject: [EXT] Re: [PATCH] checkpatch: add test for empty line after Fixes
> > > statement
> > >
> > > External Email
> > >
> > > ----------------------------------------------------------------------
> > > On Mon, 2019-05-20 at 15:42 +0300, Michal Kalderon wrote:
> > > > Check that there is no empty line after a fixes statement
> > >
> > > why?
> > >
> > This comment is given a lot on the netdev and rdma mailing lists when patches are submitted with
> > an empty line between Fixes: tag and SOB tags. Since "Fixes:" is just another tag and should be kept
> > together with the other ones.
>
> So test that all signature blocks and Fixes do not have
> blank lines between them instead of just the "Fixes:" line.
>
> And if there is some specific ordering required, perhaps a
> test for that ordering should be added as well.

I'm aware of only one request - Fixes above SOB.

Thanks

>
