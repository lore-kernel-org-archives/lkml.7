Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B273C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6C72075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfD1MQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:16:38 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:56089 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726480AbfD1MQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 08:16:37 -0400
X-UUID: 1f637e104eea43569a06ec1c775d2b48-20190428
X-UUID: 1f637e104eea43569a06ec1c775d2b48-20190428
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1683014745; Sun, 28 Apr 2019 20:16:30 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 28 Apr
 2019 20:16:29 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 28 Apr 2019 20:16:28 +0800
Message-ID: <1556453788.10179.224.camel@mhfsdcap03>
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
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 28 Apr 2019 20:16:28 +0800
In-Reply-To: <20190426204906.GB15074@bogus>
References: <1556261237-13823-1-git-send-email-chunfeng.yun@mediatek.com>
         <1556261237-13823-4-git-send-email-chunfeng.yun@mediatek.com>
         <20190426204906.GB15074@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 15:49 -0500, Rob Herring wrote:
> On Fri, Apr 26, 2019 at 02:47:14PM +0800, Chunfeng Yun wrote:
> > Now the USB Role Switch is supported, so add properties about it
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v4: no changes
> > v3: no changes
> > 
> > v2 changes:
> >   1. fix typo
> >   2. refer new binding about connector property
> > ---
> >  .../devicetree/bindings/usb/mediatek,mtu3.txt          | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > index 3382b5cb471d..6e004c4a89af 100644
> > --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > @@ -27,7 +27,9 @@ Optional properties:
> >   - ranges : allows valid 1:1 translation between child's address space and
> >  	parent's address space
> >   - extcon : external connector for vbus and idpin changes detection, needed
> > -	when supports dual-role mode.
> > +	when supports dual-role mode; it's consiedered valid for compatibility
> > +	reasons, and not allowed for new bindings, use the property
> > +	usb-role-switch instead.
> >   - vbus-supply : reference to the VBUS regulator, needed when supports
> >  	dual-role mode.
> >   - pinctrl-names : a pinctrl state named "default" is optional, and need be
> > @@ -36,7 +38,8 @@ Optional properties:
> >  	is not set.
> >   - pinctrl-0 : pin control group
> >  	See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> > -
> > + - usb-role-switch : use USB Role Switch to support dual-role switch, but
> > +	not extcon
> 
> Coordinate with the Renesas and HiSilicon folks implementing the same 
> thing and put this in a common spot. 
I'll prepare a patch for it, and CC Biju and Yu

> However, I think this should not 
> even be needed as knowing the controller capabilities (based on the 
> compatible) and knowing the type of connector should be enough 
> information to tell you if dual role is supported or not.
Some Dual-Role controller drivers already used extcon framework to
handle role switch, if try to support the new USB Role Switch framework,
the driver may want to know which way will be used.

Sometimes users also want to use dual-role even use the type-A, such as
use sys interface to handle role switch, so only knowing the connector
type can't tell driver which way to use
> 
> >   - maximum-speed : valid arguments are "super-speed", "high-speed" and
> >  	"full-speed"; refer to usb/generic.txt
> >   - enable-manual-drd : supports manual dual-role switch via debugfs; usually
> > @@ -61,6 +64,9 @@ The xhci should be added as subnode to mtu3 as shown in the following example
> >  if host mode is enabled. The DT binding details of xhci can be found in:
> >  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> >  
> > +The port would be added as subnode if use usb-role-switch property
> > +	see graph.txt
> > +
> >  Example:
> >  ssusb: usb@11271000 {
> >  	compatible = "mediatek,mt8173-mtu3";
> > -- 
> > 2.21.0
> > 


