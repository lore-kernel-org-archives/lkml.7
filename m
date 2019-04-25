Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B2AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B81120644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556205813;
	bh=07G3X/xb+RegUNju/+WhbGOZ4aicrNKZLEvCLqmyG6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Yt4TntUqLGJwfBrvONls7zCu4Als04QWl3puaGaAKBE8GEl8eHrggyw0X2jRpLv+7
	 G7/bdsm9LiCPnLYhsnCUd/gNG1IhRoJMMck/wg6RBePujh5KtsBGU9rzspH+VnFQ9O
	 cjMS3tDTTQ/0kbq54IBXA2A4VDgpBsnBapNWcqA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfDYPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:23:31 -0400
Received: from casper.infradead.org ([85.118.1.10]:40534 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfDYPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UT6IRc0WSZARp/hKxS50DDEb6VKsw01SZc2NsyJXLzI=; b=AaoYB0ooNzGmVWnAFCkvuqAuf6
        aTfNWLAMnGXfUbbkQYtCzo992sURf6aRNdbpK5CF47RNutNB6vW12Dzp6sFH5TumLH02hKc0SGU5E
        oP5xzbAmvux7iH4kWqZVD7s7Ub2b3TMaEyT3sQPlS1XMOE/b2jspR/6fNbUuD7GiH5zgqspC4IGKC
        u/GPmB2ff2qJf2giIE4Q54EyPfDe5YGuKAUrmxYjq1yJGZUNJ2kO4SZB+YAuMYY4OU3eGmaOLQr80
        EYP5c5deVbqG7smcklTL1fI02OeMq1mYH42Wv6VrubGbHVD6lvzSxJLM4Mmo4u/AAn1p8pvaZyug0
        gQY1svXw==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJgDf-0006U6-Kh; Thu, 25 Apr 2019 15:23:28 +0000
Date:   Thu, 25 Apr 2019 12:23:20 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Young <sean@mess.org>
Subject: Re: linux-next: manual merge of the v4l-dvb-next tree with the
 v4l-dvb tree
Message-ID: <20190425122320.2a2ee0f5@coco.lan>
In-Reply-To: <CAK8P3a1LDL51KW2jJdOacAxNP=Gk9YSdcP2LfX8ZasLOdcibDg@mail.gmail.com>
References: <20190423105131.7f460991@canb.auug.org.au>
        <CAK8P3a1LDL51KW2jJdOacAxNP=Gk9YSdcP2LfX8ZasLOdcibDg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 23 Apr 2019 10:12:42 +0200
Arnd Bergmann <arnd@arndb.de> escreveu:

> On Tue, Apr 23, 2019 at 2:51 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the v4l-dvb-next tree got a conflict in:
> >
> >   drivers/media/platform/Kconfig
> >
> > between commit:
> >
> >   63604a143fe1 ("media: seco-cec: fix building with RC_CORE=m")
> >
> > from the v4l-dvb tree and commit:
> >
> >   81527254e151 ("media: seco: depend on CONFIG_RC_CORE=y when not a module")
> >
> > from the v4l-dvb-next tree.
> >
> > I fixed it up (I just used the v4l-dvb tree version) and can carry the
> > fix as necessary. This is now fixed as far as linux-next is concerned,
> > but any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.  You may also want
> > to consider cooperating with the maintainer of the conflicting tree to
> > minimise any particularly complex conflicts.  
> 
> Thanks!
> 
> Both patches are correct, they just use slightly different syntax, so
> the merge is fine as well.

I just removed the one from fixes, keeping just the one on my master
branch.

Thanks,
Mauro
