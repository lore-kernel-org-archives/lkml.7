Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89668C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F46020684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfCEBTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:19:42 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60357 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbfCEBTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:19:41 -0500
X-UUID: 355412a86d774a2fba8f40eb322bfcd0-20190305
X-UUID: 355412a86d774a2fba8f40eb322bfcd0-20190305
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1665920540; Tue, 05 Mar 2019 09:19:33 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Mar
 2019 09:19:31 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Mar 2019 09:19:31 +0800
Message-ID: <1551748771.12020.36.camel@mhfsdcap03>
Subject: Re: [PATCH v5 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From:   Min Guo <min.guo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Tue, 5 Mar 2019 09:19:31 +0800
In-Reply-To: <CAL_JsqKb_afdZFaOoB5yvs2hX-T9HPVy_d30zu7f7yiqaRPaLg@mail.gmail.com>
References: <1550561795-31132-1-git-send-email-min.guo@mediatek.com>
         <1550561795-31132-2-git-send-email-min.guo@mediatek.com>
         <20190222164923.GA26413@bogus> <1551058604.12020.34.camel@mhfsdcap03>
         <CAL_JsqKb_afdZFaOoB5yvs2hX-T9HPVy_d30zu7f7yiqaRPaLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 2019-03-04 at 11:42 -0600, Rob Herring wrote:
> On Sun, Feb 24, 2019 at 7:36 PM Min Guo <min.guo@mediatek.com> wrote:
> >
> > Hi Rob,
> > On Fri, 2019-02-22 at 10:49 -0600, Rob Herring wrote:
> > > On Tue, Feb 19, 2019 at 03:36:30PM +0800, min.guo@mediatek.com wrote:
> > > > From: Min Guo <min.guo@mediatek.com>
> > > >
> > > > This adds support for MediaTek musb controller in
> > > > host, peripheral and otg mode.
> > > >
> > > > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > > > ---
> > > > changes in v5:
> > > > suggested by Rob:
> > > > 1. Modify compatible as
> > > > - compatible : should be one of:
> > > >                "mediatek,mt-2701"
> > > >                ...
> > > >                followed by "mediatek,mtk-musb"
> > > > 2. Add usb connector child node
> > > >
> > > > changes in v4:
> > > > suggested by Sergei:
> > > > 1. String alignment
> > > >
> > > > changes in v3:
> > > > 1. no changes
> > > >
> > > > changes in v2:
> > > > suggested by Bin:
> > > > 1. Modify DRC to DRD
> > > > suggested by Rob:
> > > > 2. Drop the "<soc-model>-musb" in compatible
> > > > 3. Remove phy-names
> > > > 4. Add space after comma in clock-names
> > > > ---
> > > >  .../devicetree/bindings/usb/mediatek,musb.txt      | 54 ++++++++++++++++++++++
> > > >  1 file changed, 54 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > > > new file mode 100644
> > > > index 0000000..0632e6e
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > > > @@ -0,0 +1,54 @@
> > > > +MediaTek musb DRD/OTG controller
> > > > +-------------------------------------------
> > > > +
> > > > +Required properties:
> > > > + - compatible      : should be one of:
> > > > +                     "mediatek,mt-2701"
> > >
> > > That looks like a top-level SoC compatible and doesn't match the
> > > example.
> > "mediatek,mt-2701" is an example, just to describe a specific SOC.
> > May I modify compatibel like:
> > compatible : should be "mediatek,mtk-musb"
> 
> No, you should fix the example adding "mediatek,mtk-musb".
OK.

> Rob

Regards,
Min.



