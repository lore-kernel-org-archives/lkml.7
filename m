Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087FDECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D369A217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571070263;
	bh=c8QyGqChONq6g32PggqpJBFivCcUNWeRCnyGPEMWtEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sQW3MiGD1Ogaj4GJzV7mtBZje09znImgGOkxPL2qArjnBW1cN5T/8buHE5eblNcaf
	 QduGYrPDgSWfDXD8n1DUZb92f3Uesrs/gzsxTYj0Mxkbz5pF5YIAkGxGI6/uScxYPE
	 UQ/qojKykbiGNzhsbFL3f6VAY9dBwRT3wBmpHYRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbfJNQYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbfJNQYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:24:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB882133F;
        Mon, 14 Oct 2019 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571070261;
        bh=c8QyGqChONq6g32PggqpJBFivCcUNWeRCnyGPEMWtEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rw0ERafuM08i/sIP4JH+O3mMpkfOwb9ZRg2ZrAg7qwIU6zAFYUfRS5GSso0ExPLKF
         slQVqtdfdCAKGvRJ6NYEGYyT6L6gRKFBmk25iyP+3rqW8lOYqke85GkZm0D7NNJncs
         hvOjkGcOqb3KsMOgwtuPFCmcZjjDr9/oklvOcEXg=
Date:   Mon, 14 Oct 2019 17:24:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chunrong Guo <chunrong.guo@nxp.com>
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
Message-ID: <20191014162416.uz33olqhgvzioqdk@willie-the-truck>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org>
 <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
 <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
 <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
 <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck>
 <20191011103342.GL25745@shell.armlinux.org.uk>
 <CAK8P3a1ADTc0woWWNjpeqYEtgb=snj264P4QNWOj7ZRMDv8WNg@mail.gmail.com>
 <20191012145055.GO25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012145055.GO25745@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 03:50:55PM +0100, Russell King - ARM Linux admin wrote:
> On Sat, Oct 12, 2019 at 12:47:45AM +0200, Arnd Bergmann wrote:
> > On Fri, Oct 11, 2019 at 12:33 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > 32-bit ARM experience is that telco class users really like big
> > > endian.
> > 
> > Right, basically anyone with a large code base migrated over from a
> > big-endian MIPS or PowerPC legacy that found it cheaper to change
> > the rest of the world than to fix their own code.
> 
> I think you need to step off your soap box!  Big endian isn't going
> away, and it likely has nothing to do with code bases.  Just look at
> networking and telco protocols.  Everything in that world tends to
> be big endian.  BE is what is understood in that world, and there's
> little we can do to change it.
> 
> Demanding that they switch to LE is tantamount to you demanding that
> their entire world change - it ain't going to happen.

Oh, I wasn't demanding anything! Just interested to know if big-endian is
actually being used because it's not something that I'm able to test
sensibly and I haven't see anywhere near the amount of (public) effort to
keep it supported as for little-endian. However, having asked the question,
it's clear that it does have some users so we'll keep maintaining it on a
best-effort basis and rely on those users to let us know if anything breaks.

Will
