Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5C9C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455B821835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571070035;
	bh=oZaj+ScZ6I1k6tX7lCFyDcuNyxoMhfnp8ALm8sIP41Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nGLhzHU9/R0jGwUPiczaw2hci8aMvUoLEuzU+eE2KYHuK8idvbC3r39WxqAym5eUN
	 X2UuN5YI9JUosHWJTF8LUs4tu7NfRMEeHHtqQi4h/dVj9TyyVDKqBlg2b9D9c/J3Ib
	 CSn2mpKbxoL/I7TNa2X0NxSXpCzjjUGvbA3nR8Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbfJNQUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbfJNQUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:20:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 011522133F;
        Mon, 14 Oct 2019 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571070033;
        bh=oZaj+ScZ6I1k6tX7lCFyDcuNyxoMhfnp8ALm8sIP41Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mf39s8I0HuBnOrqaQwqxpXSJtLitEorvrbW7QyKsEExq5XMosHsONryJU3khI7odT
         Nl53TdSUelOxp03w2YWpW8c1aYJyiXdvhIWR8Boi/Uw/HkVPhrPKNV9bToaQU/m5bc
         QdbAAGbVyfW1QxTKBrVX0O1ICYlJ4dh6bIfpVa/g=
Date:   Mon, 14 Oct 2019 17:20:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
Message-ID: <20191014162028.eixypo7vlsb3pdgn@willie-the-truck>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org>
 <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
 <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
 <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
 <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck>
 <73701e9f-bee1-7ae8-2277-7a3576171cd4@huawei.com>
 <CAK8P3a1C8cFB6DS9eVXTEiTQu1kPzy65JvL=BxqEe5MTkds8sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1C8cFB6DS9eVXTEiTQu1kPzy65JvL=BxqEe5MTkds8sQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 04:05:57PM +0200, Arnd Bergmann wrote:
> On Sat, Oct 12, 2019 at 9:33 AM Hanjun Guo <guohanjun@huawei.com> wrote:
> >
> > On 2019/10/11 18:27, Will Deacon wrote:
> > [...]
> > >
> > > Does anybody use BIG_ENDIAN? If we're not even building it then maybe we
> > > should get rid of it altogether on arm64. I don't know of any supported
> > > userspace that supports it or any CPUs that are unable to run little-endian
> > > binaries.
> >
> > FWIW, massive telecommunication products (based on ARM64) form Huawei are using
> > BIG_ENDIAN, and will use BIG_ENDIAN in the near future as well.
> 
> Ok, thanks for the information -- that definitely makes it clear that
> it cannot go
> away anytime soon (though it doesn't stop us from change the
> allmodconfig default
> if we decide that's a good idea).

Agreed on both counts.

> Do you know if there are currently any patches against mainline to
> make big-endian
> work in products, or is everything working out of the box?

I suspect "everything" is probably much narrower in scope than for
little-endian configurations simply because of the lack of distribution
support and associated testing. If the companies using it are willing
to contribute back fixes as they run into problems, then that's probably
the best we can hope for.

Will
