Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F446C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66E8206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="O/8ZMvCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKMT0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:26:37 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:44420 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfKMT0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wryp9jGGVuImtf+976fNyBccolmYyzey/YrHktJaiVI=; b=O/8ZMvCU84EUDuGhqEK6xz7Hgd
        Aft5QSY1fJuN37QnylH4SD0n/xaflJz9+o9+HlujKjQg/X+3FlCFDl56ni0YB5rAG4xhy2bqvrfvP
        V1PN52aB9LdcKle6B+e1SIUJdxGQTL0fY/q7n9MjnVrQu5D19wdB525O2lc0O/PH5Ez8=;
Received: from p200300ccff08d9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:d900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iUyHi-0003Z7-My; Wed, 13 Nov 2019 20:26:34 +0100
Date:   Wed, 13 Nov 2019 20:26:33 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, phh@phh.me,
        b.galvani@gmail.com, stefan@agner.ch
Subject: Re: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable
Message-ID: <20191113202633.66a91d96@aktux>
In-Reply-To: <20191113183211.GB4402@sirena.co.uk>
References: <20191113182643.23885-1-andreas@kemnade.info>
        <20191113183211.GB4402@sirena.co.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 13 Nov 2019 18:32:11 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 13, 2019 at 07:26:43PM +0100, Andreas Kemnade wrote:
> > LDO9 and LDO10 were listed with the same enable bits.
> > That looks insane and there are no provisions in the code for handling such
> > a special case. Also other out-of-tree drivers use a separate bit to
> > enable it.  
> 
> This definitely looks like a bug but without a datasheet or testing it's
> worrying guessing at the register bit to use for the enable for the
> second LDO...

I am hoping for a Tested-By: from the one who has submitted the patch
for the regulator. 

Well, it is not just guessing, it is there in the url I referenced. But
I would of course prefer a better source. At first I wanted to spread
my findings.
I am not pushing anyone to accept it without Tested-By/Reviewed-Bys.
What is a good way to avoid people bumping into this bug?
Maybe I can find the right C on the board to check.

Regards,
Andreas
