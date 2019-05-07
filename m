Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF53C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7135206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557260274;
	bh=Zp/rnTfJkpJZNmoGs+xBSvXnImnrSx0zg7++B1WSdz8=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=vM9nX99ooWOCWdW/5V21Qpz68QBHzideRN2uHejtieJEOTC7vLem/Uc3y3Yf/YaST
	 G87W05KyqsuuaXIAln11f8BKb3/R9do5qkdXWqiJRXbf5gKklXgmvchX+dQonKcTsF
	 19i23wtGDtW4Hn17PANfyy4UaGUB93S3QvSchhVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEGURx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfEGURw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:17:52 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9EC20675;
        Tue,  7 May 2019 20:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557260271;
        bh=Zp/rnTfJkpJZNmoGs+xBSvXnImnrSx0zg7++B1WSdz8=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=wpdR9llHaGX6478IU1bK4g5PgQ41VfPDmGa02s8bbErr25gTi/YY3ft5eWwqdZ6sv
         t+PVm5NU/PTcy6AEvXpIP9ADhatNWb2Fbd+geG2mTQlXY6i5VBtXyTgL8KZ7skYkpE
         tdoIrsWbWRGrNjq4uPobzwYdg0Dr8cuk1MCwHXDI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <568ba27d-a6a5-b158-bab1-f22cd8ccb34e@redhat.com>
References: <20190429150135.15070-1-hdegoede@redhat.com> <CAHp75VeE=88mCcgVx3Y3PQJPQ819Z7=3s=jRGz1y=t09phk=rA@mail.gmail.com> <085c5b6e-d220-ebd1-38d2-def7efca24b8@redhat.com> <CAHp75Vfe9uK_b_V+uG29wb1L6J7u1hpbU+P4beXso9KNPM+8Rg@mail.gmail.com> <568ba27d-a6a5-b158-bab1-f22cd8ccb34e@redhat.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to critclk_systems DMI table
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Semyon Verchenko <semverchenko@factor-ts.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Message-ID: <155726027056.14659.1724431433952718602@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 07 May 2019 13:17:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hans de Goede (2019-05-06 08:05:42)
> Hi,
>=20
> On 06-05-19 16:59, Andy Shevchenko wrote:
> > On Mon, May 6, 2019 at 5:47 PM Hans de Goede <hdegoede@redhat.com> wrot=
e:
> >>
> >> Hi,
> >>
> >> On 06-05-19 14:38, Andy Shevchenko wrote:
> >>> On Mon, Apr 29, 2019 at 6:01 PM Hans de Goede <hdegoede@redhat.com> w=
rote:
> >>>>
> >>>> The Lex 3I380D industrial PC has 4 ethernet controllers on board
> >>>> which need pmc_plt_clk0 - 3 to function, add it to the critclk_syste=
ms
> >>>> DMI table, so that drivers/clk/x86/clk-pmc-atom.c will mark the cloc=
ks
> >>>> as CLK_CRITICAL and they will not get turned off.
> >>>>
> >>>
> >>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >>> supposedly to go via CLK tree.
> >>>
> >>> P.S. If you want it through PDx86, I need immutable branch / tag from=
 CLK.
> >>
> >> Stephen added the patches this depends on to his fixes branch, so they
> >> are in the 5.1 / Torvald's master branch, since we are now in the 5.2 =
merge
> >> window, you should be able to cleanly apply this directly.
> >=20
> > We don't do back merges, so, our base is v5.1-rc1. Does it mean the
> > commit in question is in v5.1-rc1?
> > AFAICS it was appeared in v5.1-rc5.
>=20
> Ah, I see, my bad.
>=20
> Stephen can you pick up this patch and the
> "[PATCH 1/1] Add several Beckhoff Automation boards to critclk_systems DM=
I table"
> patch then?
>=20

I guess this is urgent? I'm lost why Andy can't apply the patch and
merge it up to Linus. I don't maintain this driver here, and even if
there's a cross tree dependency I don't understand why a base of
v5.1-rc1 is limiting abilities to apply patches.

I'd think that if an "immutable branch" was all that was required you
could 'git checkout 7c2e07130090ae001a97a6b65597830d6815e93e' and then
apply the patch there and merge it all up into the PDx86 tree. In the
end, when sending the PR to Linus the already merged changes won't show
up in the diff because it's all been merged already on the other side.

Either way, I'm going to send off the clk PR real soon so this may need
to wait until after the merge window, or if it's really urgent I could
send a fixes branch before the merge window closes next week.

