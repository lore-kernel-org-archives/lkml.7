Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111ACC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C8E21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFNJl5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:41:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38230 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfFNJl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:41:57 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbiiX-0004CH-2f; Fri, 14 Jun 2019 11:41:53 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Configure BT_HOST_WAKE as wake-up signal on veyron
Date:   Fri, 14 Jun 2019 11:41:52 +0200
Message-ID: <1649765.SGRQ98Vtau@phil>
In-Reply-To: <CAD=FV=U-BOF79yJOW7S1CRudTqDN0BA8Ur3mJfg3C-+8P6fCew@mail.gmail.com>
References: <20190605204320.22343-1-mka@chromium.org> <20190606175654.GQ40515@google.com> <CAD=FV=U-BOF79yJOW7S1CRudTqDN0BA8Ur3mJfg3C-+8P6fCew@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 7. Juni 2019, 01:34:32 CEST schrieb Doug Anderson:
> Hi,
> 
> On Thu, Jun 6, 2019 at 10:56 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Thu, Jun 06, 2019 at 12:46:03PM +0200, Heiko Stuebner wrote:
> > > Am Mittwoch, 5. Juni 2019, 23:52:00 CEST schrieb Heiko Stübner:
> > > > Am Mittwoch, 5. Juni 2019, 23:24:27 CEST schrieb Matthias Kaehlcke:
> > > > > On Wed, Jun 05, 2019 at 11:11:12PM +0200, Heiko Stübner wrote:
> > > > > > Am Mittwoch, 5. Juni 2019, 22:43:20 CEST schrieb Matthias Kaehlcke:
> > > > > > > This enables wake up on Bluetooth activity when the device is
> > > > > > > suspended. The BT_HOST_WAKE signal is only connected on devices
> > > > > > > with BT module that are connected through UART.
> > > > > > >
> > > > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > >
> > > > > > Housekeeping question, with the two Signed-off-by lines, is Doug the
> > > > > > original author, or was this Co-developer-by?
> > > > >
> > > > > Good question, it's derived from Doug's patch for CrOS 3.14 and
> > > > > https://crrev.com/c/1575556 also from Doug. Let's say I did the
> > > > > porting to upstream, but I'm pretty sure Doug spent more time on it.
> > > > >
> > > > > Maybe I should resend it with Doug as author and include the original
> > > > > commit message, which has more information.
> > > >
> > > > It's just that the first Signed-off should be from the original author.
> > > > (And the sender the second)
> > > > In the co-developed-by case (see Kernel documentation) the order
> > > > doesn't matter.
> > >
> > > Holding off on this patch till we could clarify the authorship.
> >
> > I'd say let's attribute the authorship to Doug. FTR, the original
> > downstream Chrome OS patch is https://crrev.com/c/278190.
> >
> > Not sure if the information in the commit message of the original
> > patch is relevant for the upstream version, in the end it seems LPM
> > was never implemented, so it should be sufficient to say what is
> > actually done today.
> >
> > In summary, I propose to take the patch with the current commit
> > message, with Doug as the author. Heiko, can you change the authorship
> > or should I send a new version?
> >
> > Doug if you have objections or want updates in the commit message
> > (yours tend to be more verbose ;-), holler.
> 
> It's fine with me.

while I did just want to apply this one with the relevant adaptions,
I didn't get to it early enough and Matthias was faster with his v2
fixed patch, so I've applied that one instead ;-)

Heiko


