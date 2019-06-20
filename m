Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A501C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8A62070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfFTQ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:56:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50584 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:56:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 5FE2B26A371
Message-ID: <385c93321be1ec5875769d1a825d0fcd44677959.camel@collabora.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: rockchip: document VOP gamma
 LUT address
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Jun 2019 13:56:23 -0300
In-Reply-To: <CAD=FV=UpZAjrWkQ7qj5Wo2tf2wkg5Q-34Sun0MOtYLBAwY731Q@mail.gmail.com>
References: <20190618213406.7667-1-ezequiel@collabora.com>
         <20190618213406.7667-2-ezequiel@collabora.com>
         <CAD=FV=UpZAjrWkQ7qj5Wo2tf2wkg5Q-34Sun0MOtYLBAwY731Q@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-20 at 09:43 -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 18, 2019 at 2:43 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > Add the register specifier description for an
> > optional gamma LUT address.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  .../bindings/display/rockchip/rockchip-vop.txt         | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-
> > vop.txt
> > index 4f58c5a2d195..97ad78cc7e03 100644
> > --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> > +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> > @@ -20,6 +20,13 @@ Required properties:
> >                 "rockchip,rk3228-vop";
> >                 "rockchip,rk3328-vop";
> > 
> > +- reg: Must contain one entry corresponding to the base address and length
> > +       of the register space. Can optionally contain a second entry
> > +       corresponding to the CRTC gamma LUT address.
> > +
> > +- reg-names: "base" for the base register space. If present, the CRTC
> > +       gamma LUT name should be "lut".
> 
> As per Rob Herring, current suggestion is to avoid reg-names when
> possible.  The code should just look for the presence of a 2nd entry
> and assume that if it's there that it's the lut range.  Full context:
> 
> > https://lore.kernel.org/lkml/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com/
> 

Oh, that's news to me. I was assuming having reg-names was preferred.

Thanks for the feedback, I'll send a new version.

