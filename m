Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA40C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD50F2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfD3G5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:57:44 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8461 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbfD3G5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:57:44 -0400
X-UUID: 2d217474e79a4b76987e911cdbe6e632-20190430
X-UUID: 2d217474e79a4b76987e911cdbe6e632-20190430
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1809240108; Tue, 30 Apr 2019 14:57:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 30 Apr
 2019 14:57:37 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Apr 2019 14:57:37 +0800
Message-ID: <1556607457.10179.259.camel@mhfsdcap03>
Subject: Re: [PATCH v4 3/6] dt-bindings: usb: mtu3: add properties about USB
 Role Switch
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linux USB List" <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "Biju Das" <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Apr 2019 14:57:37 +0800
In-Reply-To: <CAL_JsqKXKRetoy4u_yAMgS+RA0vaRhzjR0zpLjKMtgRvFHXn7A@mail.gmail.com>
References: <1556261237-13823-1-git-send-email-chunfeng.yun@mediatek.com>
         <1556261237-13823-4-git-send-email-chunfeng.yun@mediatek.com>
         <20190426204906.GB15074@bogus> <1556453788.10179.224.camel@mhfsdcap03>
         <CAL_JsqKXKRetoy4u_yAMgS+RA0vaRhzjR0zpLjKMtgRvFHXn7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-29 at 11:25 -0500, Rob Herring wrote:
> On Sun, Apr 28, 2019 at 7:16 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> >
> > On Fri, 2019-04-26 at 15:49 -0500, Rob Herring wrote:
> > > On Fri, Apr 26, 2019 at 02:47:14PM +0800, Chunfeng Yun wrote:
> > > > Now the USB Role Switch is supported, so add properties about it
> > > >
> > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > ---
> > > > v4: no changes
> > > > v3: no changes
> > > >
> > > > v2 changes:
> > > >   1. fix typo
> > > >   2. refer new binding about connector property
> > > > ---
> > > >  .../devicetree/bindings/usb/mediatek,mtu3.txt          | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > > > index 3382b5cb471d..6e004c4a89af 100644
> > > > --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > > > @@ -27,7 +27,9 @@ Optional properties:
> > > >   - ranges : allows valid 1:1 translation between child's address space and
> > > >     parent's address space
> > > >   - extcon : external connector for vbus and idpin changes detection, needed
> > > > -   when supports dual-role mode.
> > > > +   when supports dual-role mode; it's consiedered valid for compatibility
> > > > +   reasons, and not allowed for new bindings, use the property
> > > > +   usb-role-switch instead.
> > > >   - vbus-supply : reference to the VBUS regulator, needed when supports
> > > >     dual-role mode.
> > > >   - pinctrl-names : a pinctrl state named "default" is optional, and need be
> > > > @@ -36,7 +38,8 @@ Optional properties:
> > > >     is not set.
> > > >   - pinctrl-0 : pin control group
> > > >     See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> > > > -
> > > > + - usb-role-switch : use USB Role Switch to support dual-role switch, but
> > > > +   not extcon
> > >
> > > Coordinate with the Renesas and HiSilicon folks implementing the same
> > > thing and put this in a common spot.
> > I'll prepare a patch for it, and CC Biju and Yu
> >
> > > However, I think this should not
> > > even be needed as knowing the controller capabilities (based on the
> > > compatible) and knowing the type of connector should be enough
> > > information to tell you if dual role is supported or not.
> > Some Dual-Role controller drivers already used extcon framework to
> > handle role switch, if try to support the new USB Role Switch framework,
> > the driver may want to know which way will be used.
> 
> Wouldn't it know by presence of 'extcon' property or not?

non-presence of 'extcon' doesn't mean the driver need USB Role Switch,
e.g. support manual role switch decided by user, of course, we can check
some cases and then decide whether need USB Role Switch or not, maybe
provide a property will make it easier.

> 
> > Sometimes users also want to use dual-role even use the type-A, such as
> > use sys interface to handle role switch, so only knowing the connector
> > type can't tell driver which way to use
> 
> That use case doesn't sound like something that should be in DT
> though. That would be possible for any controller that supports
> dual-role. 
I give manual role switch by sysfs interface a higher priority than
other ways, if manual switch is enabled, e.g. 'extcon' will be ignored.
this may be different from other USB dual-role controller drivers.

> Though perhaps that requires some specific Vbus wiring? Or
> a cable with Vbus disconnected. 
Yes, some projects use PMIC or Charger to detect Vbus, but some don't
have Vbus detection circuit, and some even don't provide vbus pin

> Either way, doesn't sound USB compliant.
Yes, it's more related with customer usage, or cost down, anyway, it's
better to support cases as many as possible.

> 
> Rob


