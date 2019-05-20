Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A39C04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8922020675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfETCaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 22:30:06 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:6456 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729975AbfETCaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 22:30:05 -0400
X-UUID: 2c25f6d257554899b5db5360f97876a1-20190520
X-UUID: 2c25f6d257554899b5db5360f97876a1-20190520
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1068025239; Mon, 20 May 2019 10:29:51 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 20 May
 2019 10:29:50 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 10:29:49 +0800
Message-ID: <1558319389.10179.347.camel@mhfsdcap03>
Subject: Re: [v3 PATCH] dt-binding: usb: add usb-role-switch property
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Yu Chen <chenyu56@huawei.com>, Min Guo <min.guo@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Date:   Mon, 20 May 2019 10:29:49 +0800
In-Reply-To: <20190517132721.GB1887@kuha.fi.intel.com>
References: <c3596e996c9ab39c6b9bc14b93309244c4a55014.1557306151.git.chunfeng.yun@mediatek.com>
         <20190517132721.GB1887@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-17 at 16:27 +0300, Heikki Krogerus wrote:
> On Wed, May 08, 2019 at 05:17:44PM +0800, Chunfeng Yun wrote:
> > Add a property usb-role-switch to tell the driver that use
> > USB Role Switch framework to handle the role switch,
> > it's useful when the driver has already supported other ways,
> > such as extcon framework etc.
> > 
> > Cc: Biju Das <biju.das@bp.renesas.com>
> > Cc: Yu Chen <chenyu56@huawei.com>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> Who is meant to pick this? 

> Can you include this in your series where
> you introduce that USB Type-B GPIO connector driver?
> 
Ok, I'll do it if need

> FWIW:
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> > ---
> > v3:
> >     add property type, modify description suggested by Heikki
> > 
> > v2:
> >     describe it in terms of h/w functionality suggested by Rob
> > 
> > v1:
> >     the property is discussed in:
> >     [v2,2/7] dt-bindings: usb: renesas_usb3: add usb-role-switch property
> >     https://patchwork.kernel.org/patch/10852497/
> > 
> >     Mediatek and Hisilicon also try to use it:
> >     [v4,3/6] dt-bindings: usb: mtu3: add properties about USB Role Switch
> >     https://patchwork.kernel.org/patch/10918385/
> >     [v4,6/6] usb: mtu3: register a USB Role Switch for dual role mode
> >     https://patchwork.kernel.org/patch/10918367/
> > 
> >     [v6,10/13] usb: dwc3: Registering a role switch in the DRD code
> >     https://patchwork.kernel.org/patch/10909981/
> > ---
> >  Documentation/devicetree/bindings/usb/generic.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> > index 0a74ab8dfdc2..cf5a1ad456e6 100644
> > --- a/Documentation/devicetree/bindings/usb/generic.txt
> > +++ b/Documentation/devicetree/bindings/usb/generic.txt
> > @@ -30,6 +30,10 @@ Optional properties:
> >  			optional for OTG device.
> >   - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
> >  			optional for OTG device.
> > + - usb-role-switch: boolean, indicates that the device is capable of assigning
> > +			the USB data role (USB host or USB device) for a given
> > +			USB connector, such as Type-C, Type-B(micro).
> > +			see connector/usb-connector.txt.
> >  
> >  This is an attribute to a USB controller such as:
> >  
> > -- 
> > 2.21.0
> 
> thanks,
> 


