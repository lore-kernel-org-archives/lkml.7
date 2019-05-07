Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F31AC04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335D120B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEGC0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 22:26:43 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:54942 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbfEGC0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 22:26:43 -0400
X-UUID: 996369109acf407595d83a84a6852306-20190507
X-UUID: 996369109acf407595d83a84a6852306-20190507
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2014171805; Tue, 07 May 2019 10:26:37 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 7 May
 2019 10:26:36 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 7 May 2019 10:26:34 +0800
Message-ID: <1557195994.10179.263.camel@mhfsdcap03>
Subject: Re: [PATCH] dt-binding: usb: add usb-role-switch property
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "Yu Chen" <chenyu56@huawei.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Min Guo <min.guo@mediatek.com>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>
Date:   Tue, 7 May 2019 10:26:34 +0800
In-Reply-To: <20190502194905.GA22144@bogus>
References: <5756e05930f5e6a3940ad9d019399c8e63d24f18.1556454324.git.chunfeng.yun@mediatek.com>
         <20190502194905.GA22144@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-02 at 14:49 -0500, Rob Herring wrote:
> On Sun, Apr 28, 2019 at 08:27:46PM +0800, Chunfeng Yun wrote:
> > Add a property usb-role-switch to tell Dual-Role controller driver
> > that use USB Role Switch framework to handle the role switch between
> > host mode and device mode, it's useful when the driver has already
> > supported other ways, such as extcon framework etc.
> > 
> > Cc: Biju Das <biju.das@bp.renesas.com>
> > Cc: Yu Chen <chenyu56@huawei.com>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v1:
> > the property is discussed in:
> > [v2,2/7] dt-bindings: usb: renesas_usb3: add usb-role-switch property
> > https://patchwork.kernel.org/patch/10852497/
> > 
> > Mediatek and Hisilicon also try to use it:
> > [v4,3/6] dt-bindings: usb: mtu3: add properties about USB Role Switch
> > https://patchwork.kernel.org/patch/10918385/
> > [v4,6/6] usb: mtu3: register a USB Role Switch for dual role mode
> > https://patchwork.kernel.org/patch/10918367/
> > 
> > [v6,10/13] usb: dwc3: Registering a role switch in the DRD code
> > https://patchwork.kernel.org/patch/10909981/
> > ---
> >  Documentation/devicetree/bindings/usb/generic.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> > index 0a74ab8dfdc2..c73950b72513 100644
> > --- a/Documentation/devicetree/bindings/usb/generic.txt
> > +++ b/Documentation/devicetree/bindings/usb/generic.txt
> > @@ -30,6 +30,9 @@ Optional properties:
> >  			optional for OTG device.
> >   - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
> >  			optional for OTG device.
> > + - usb-role-switch: tells Dual-Role USB controller driver that we want to use
> > +			USB Role Switch framework to handle the role switch
> > +			between host mode and device mode.
> 
> Please describe this in terms of h/w functionality, not drivers and 
> Linux things.
Sorry for the late reply, v2 is posted

> 
> Rob


