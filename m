Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0F7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612F82086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbfCaMps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:45:48 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:1126 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726863AbfCaMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:45:47 -0400
X-UUID: 80e83be773de4c9292d0639c4707d64d-20190331
X-UUID: 80e83be773de4c9292d0639c4707d64d-20190331
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2134828865; Sun, 31 Mar 2019 20:45:38 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 31 Mar
 2019 20:45:37 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 31 Mar 2019 20:45:36 +0800
Message-ID: <1554036336.10179.175.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/6] dt-bindings: connector: add optional properties
 for Type-B
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
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Sun, 31 Mar 2019 20:45:36 +0800
In-Reply-To: <5ca060de.1c69fb81.12138.c73c@mx.google.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552635513-2378-2-git-send-email-chunfeng.yun@mediatek.com>
         <5ca060de.1c69fb81.12138.c73c@mx.google.com>
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
On Sun, 2019-03-31 at 01:40 -0500, Rob Herring wrote:
> On Fri, Mar 15, 2019 at 03:38:28PM +0800, Chunfeng Yun wrote:
> > Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
> > usb-b-connector
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v2 changes:
> >   1. describe more clear for vbus-gpios and vbus-supply suggested by Hans
> > ---
> >  .../devicetree/bindings/connector/usb-connector.txt      | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> > index a9a2f2fc44f2..1c4ed6c9afa8 100644
> > --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> > +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> > @@ -17,6 +17,15 @@ Optional properties:
> >  - self-powered: Set this property if the usb device that has its own power
> >    source.
> >  
> > +Optional properties for usb-b-connector:
> > +- id-gpios: gpio for USB ID pin.
> > +- vbus-gpios: gpio for USB VBUS pin, used to detect presence of VBUS 5V.
> > +  see gpio/gpio.txt.
> 
> Please make it explicit that this is an input gpio. An output GPIO 
> controlling a Vbus regulator should be modelled as a regulator.
Ok, thanks

> 
> > +- vbus-supply: a phandle to the regulator for USB VBUS if needed.
> > +- pinctrl-names : a pinctrl state named "default" is optional
> > +- pinctrl-0 : pin control group
> > +  see pinctrl/pinctrl-bindings.txt
> > +
> >  Optional properties for usb-c-connector:
> >  - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
> >    connector has power support.
> > -- 
> > 2.20.1
> > 
> 


