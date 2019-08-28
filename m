Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF3AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3EC214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfH1B2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:28:25 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:5087 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726096AbfH1B2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:28:25 -0400
X-UUID: 96f7fddde3974cd790b42912ff8297f0-20190828
X-UUID: 96f7fddde3974cd790b42912ff8297f0-20190828
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 237847491; Wed, 28 Aug 2019 09:28:26 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 28 Aug
 2019 09:28:24 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 09:28:23 +0800
Message-ID: <1566955695.7317.17.camel@mhfsdcap03>
Subject: Re: [PATCH next v10 03/11] dt-bindings: usb: add binding for USB
 GPIO based connection detection driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Date:   Wed, 28 Aug 2019 09:28:15 +0800
In-Reply-To: <20190827183154.GA10374@bogus>
References: <1566547041-20804-1-git-send-email-chunfeng.yun@mediatek.com>
         <1566547041-20804-4-git-send-email-chunfeng.yun@mediatek.com>
         <20190827183154.GA10374@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 259D35EFF30C0616C1A211BC45937CDECB94215148384FD745984477FEA65A402000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 13:31 -0500, Rob Herring wrote:
> On Fri, Aug 23, 2019 at 03:57:13PM +0800, Chunfeng Yun wrote:
> > It's used to support dual role switch via GPIO when use Type-B
> > receptacle, typically the USB ID pin is connected to an input
> > GPIO, and also used to enable/disable device when the USB Vbus
> > pin is connected to an input GPIO.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v9~v10 no changes
> > 
> > v8 changes:
> >  1. rename the title
> >  2. change the compatible as "linux,usb-conn-gpio" instead of
> >     "linux,typeb-conn-gpio"
> 
> I don't think that is an improvement. How about 'gpio-usb-b-connector' 
> to be consistent.
Ok

> 
> > 
> > v7 changes:
> >  1. add description for device only mode
> > 
> > v6 changes:
> >  1. remove status and port nodes in example
> >  2. make vbus-supply as optional property
> > 
> > v5 changes:
> >  1. treat type-B connector as child device of USB controller's, but not
> >     as a separate virtual device, suggested by Rob
> >  2. put connector's port node under connector node, suggested by Rob
> > 
> > v4 no changes
> > 
> > v3 changes:
> >  1. treat type-B connector as a virtual device, but not child device of
> >     USB controller's
> > 
> > v2 changes:
> >   1. new patch to make binding clear suggested by Hans
> > ---
> >  .../devicetree/bindings/usb/usb-conn-gpio.txt | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> > new file mode 100644
> > index 000000000000..d4d107fedc22
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> > @@ -0,0 +1,31 @@
> > +USB GPIO Based Connection Detection
> > +
> > +This is typically used to switch dual role mode from the USB ID pin connected
> > +to an input GPIO, and also used to enable/disable device mode from the USB
> > +Vbus pin connected to an input GPIO.
> > +
> > +Required properties:
> > +- compatible : should include "linux,usb-conn-gpio" and "usb-b-connector".
> > +- id-gpios, vbus-gpios : input gpios, either one of them must be present,
> > +	and both can be present as well.
> > +	see connector/usb-connector.txt
> > +
> > +Optional properties:
> > +- vbus-supply : can be present if needed when supports dual role mode.
> > +	see connector/usb-connector.txt
> > +
> > +- Sub-nodes:
> > +	- port : can be present.
> > +		see graph.txt
> > +
> > +Example:
> > +
> > +&mtu3 {
> > +	connector {
> > +		compatible = "linux,usb-conn-gpio", "usb-b-connector";
> > +		label = "micro-USB";
> 
> 'label' is for a human identifying a particular connector when there are 
> multiple (of the same type). So not a great example here.
Got it, will remove it

Thanks a lot
> 
> > +		type = "micro";
> > +		id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
> > +		vbus-supply = <&usb_p0_vbus>;
> > +	};
> > +};
> > -- 
> > 2.23.0
> > 


