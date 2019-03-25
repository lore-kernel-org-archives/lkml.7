Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB6C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83937208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfCYQKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:10:34 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:49121 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYQKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:10:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E9288FB03;
        Mon, 25 Mar 2019 17:10:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VCxZE6-8OXHJ; Mon, 25 Mar 2019 17:10:30 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 6E7A740385; Mon, 25 Mar 2019 17:10:30 +0100 (CET)
Date:   Mon, 25 Mar 2019 17:10:30 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: Add Rocktech jh057n00900 panel
 bindings
Message-ID: <20190325161030.GA30679@bogon.m.sigxcpu.org>
References: <cover.1553522676.git.agx@sigxcpu.org>
 <6a50cfdf0fd68aa120f7d8b67357ab45a2275355.1553522676.git.agx@sigxcpu.org>
 <CAOMZO5BfhaR2BjBKvLwGk_=ULtGUx_x46jskX1WiAOY5vzxgbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BfhaR2BjBKvLwGk_=ULtGUx_x46jskX1WiAOY5vzxgbw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Mar 25, 2019 at 11:10:47AM -0300, Fabio Estevam wrote:
> On Mon, Mar 25, 2019 at 11:06 AM Guido Günther <agx@sigxcpu.org> wrote:
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> > @@ -0,0 +1,18 @@
> > +Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
> > +
> > +Required properties:
> > +- compatible: should be "rocktech,jh057n00900"
> > +- reg: DSI virtual channel of the peripheral
> > +- reset-gpios: panel reset gpio
> > +- backlight: phandle of the backlight device attached to the panel
> > +
> > +Example:
> > +
> > +       &mipi_dsi {
> > +               panel {
> > +                       compatible = "rocktech,jh057n00900";
> > +                       reg = <0>;
> 
> Passing the reg property without its corresponding @0 would cause a
> dtc warning when building with W=1.

Thanks, I've put that in for v5 and sent a patch to correct
the other drivers in display/panel:

  https://patchwork.kernel.org/patch/10869563/

Cheers,
 -- Guido
    
