Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA4820657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfCKGnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:43:47 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:51721 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725808AbfCKGnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:43:46 -0400
X-UUID: 2230a57e1b204d309986847c9f8f2c1a-20190311
X-UUID: 2230a57e1b204d309986847c9f8f2c1a-20190311
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 757522629; Mon, 11 Mar 2019 14:43:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Mar
 2019 14:43:37 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 14:43:36 +0800
Message-ID: <1552286616.10179.29.camel@mhfsdcap03>
Subject: RE: [PATCH 1/5] dt-bindings: connector: add optional properties for
 Type-B
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Jun Li <jun.li@nxp.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 11 Mar 2019 14:43:36 +0800
In-Reply-To: <VI1PR04MB45586752BAEEDBB3F979E0BB89480@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <1552025622-15582-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552025622-15582-2-git-send-email-chunfeng.yun@mediatek.com>
         <693b11e7-fa9e-ab1f-561a-beb758b1872f@redhat.com>
         <1552282383.10179.21.camel@mhfsdcap03>
         <VI1PR04MB45586752BAEEDBB3F979E0BB89480@VI1PR04MB4558.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,
On Mon, 2019-03-11 at 06:06 +0000, Jun Li wrote:
> 
> > -----Original Message-----
> > From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Sent: 2019年3月11日 13:33
> > To: Hans de Goede <hdegoede@redhat.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Heikki Krogerus
> > <heikki.krogerus@linux.intel.com>; Mark Rutland <mark.rutland@arm.com>;
> > Matthias Brugger <matthias.bgg@gmail.com>; Adam Thomson
> > <Adam.Thomson.Opensource@diasemi.com>; Jun Li <jun.li@nxp.com>; Badhri
> > Jagan Sridharan <badhri@google.com>; Andy Shevchenko
> > <andy.shevchenko@gmail.com>; Min Guo <min.guo@mediatek.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-mediatek@lists.infradead.org
> > Subject: Re: [PATCH 1/5] dt-bindings: connector: add optional properties for
> > Type-B
> > 
> > Hi,
> > 
> > On Fri, 2019-03-08 at 13:07 +0100, Hans de Goede wrote:
> > > Hi,
> > >
> > > On 08-03-19 07:13, Chunfeng Yun wrote:
> > > > Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
> > > > usb-b-connector
> > > >
> > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > ---
> > > >   .../devicetree/bindings/connector/usb-connector.txt    | 10 ++++++++++
> > > >   1 file changed, 10 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/connector/usb-connector.txt
> > > > b/Documentation/devicetree/bindings/connector/usb-connector.txt
> > > > index a9a2f2fc44f2..7a07b0f4f973 100644
> > > > --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> > > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> > > > @@ -17,6 +17,16 @@ Optional properties:
> > > >   - self-powered: Set this property if the usb device that has its own power
> > > >     source.
> > > >
> > > > +Optional properties for usb-b-connector:
> > > > +- id-gpios: gpio for USB ID pin.
> > >
> > > What about boards where the ID pin is *not* connected to a GPIO, but
> > > e.g. to a special pin on the PMIC which can also detect an ACA adapter
> > > ? Currently this case is handled by extcon drivers, but we have no way
> > > to set e.g. vbus-supply for the connector. Maybe in this case the
> > > usb-connector node should be a child of the PMIC node ?
> > Yes, it would be, PMIC is in charger of detecting the status of ID pin
> > >
> > > And in many cases there also is a mux to switch the datalines between
> > > the host and device(gadget) controllers, how should that be described
> > > in this model?  See the new usb-role-switch code under
> > > drivers/usb/roles
> > >
> > > In some cases the mux is controlled through a gpio, so we may want to
> > > add a "mux-gpios" here in which case we also need to define what 0/1
> > > means.
> > I'm not sure, the mux seems not belong to this connector, and may need another
> > driver to register usb-role-switch, similar to:
> > 
> > [v2,2/2] usb: typec: add typec switch via GPIO control
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork
> > .kernel.org%2Fpatch%2F10834327%2F&amp;data=02%7C01%7Cjun.li%40nxp.co
> > m%7C963df62e15ed4bedb14d08d6a5e30de2%7C686ea1d3bc2b4c6fa92cd99c5
> > c301635%7C0%7C0%7C636878791953122760&amp;sdata=grPIs2MbdaarTa17dr
> > pASVkGpyW7TAexB24igOJopGU%3D&amp;reserved=0
> > 
> 
> No, this is not for usb role switch, this is a typec switch driver to select the super speed
> active channel by orientation(CC1/CC2).
Got it, it's just an analogy:)
> 
> Li Jun
> > 
> > >
> > > > +- vbus-gpios: gpio for USB VBUS pin.
> > > > +  see gpio/gpio.txt.
> > > > +- vbus-supply: reference to the VBUS regulator, needed when
> > > > +supports
> > > > +  dual-role mode.
> > >
> > > I think this needs some text that there can be either a vbus-gpio or a
> > > vbus-supply. Oh wait reading:
> > >
> > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > >
> > chwork.kernel.org%2Fpatch%2F10819377%2F&amp;data=02%7C01%7Cjun.li%4
> > 0nx
> > >
> > p.com%7C963df62e15ed4bedb14d08d6a5e30de2%7C686ea1d3bc2b4c6fa92cd9
> > 9c5c3
> > >
> > 01635%7C0%7C0%7C636878791953122760&amp;sdata=Judz7gdwQTOC7Jh84
> > 57N4x21a
> > > fWci%2FEH79ARqWZzbX8%3D&amp;reserved=0
> > >
> > > I see that this GPIO is for detecting vbus presence, not for
> > > driving/enabling 5v to Vbus from the board, that needs to be described more
> > clearly.
> > Ok
> > 
> > Thanks a lot
> > >
> > > > +- pinctrl-names : a pinctrl state named "default" is optional
> > > > +- pinctrl-0 : pin control group
> > > > +  see pinctrl/pinctrl-bindings.txt
> > > > +
> > > >   Optional properties for usb-c-connector:
> > > >   - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
> > > >     connector has power support.
> > > >
> > >
> > >
> > > Regards,
> > >
> > > Hans
> > 
> 


