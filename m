Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF5EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D7A2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCMKPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:15:20 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36507 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbfCMKPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:15:19 -0400
X-UUID: 9110ccc94a3a4f03a84b618665ed23dd-20190313
X-UUID: 9110ccc94a3a4f03a84b618665ed23dd-20190313
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1615897056; Wed, 13 Mar 2019 18:15:11 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Mar
 2019 18:15:09 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Mar 2019 18:15:09 +0800
Message-ID: <1552472109.10179.103.camel@mhfsdcap03>
Subject: Re: [PATCH 1/5] dt-bindings: connector: add optional properties for
 Type-B
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 13 Mar 2019 18:15:09 +0800
In-Reply-To: <464f1021-4c5e-9137-489d-65fd578575d3@redhat.com>
References: <1552025622-15582-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552025622-15582-2-git-send-email-chunfeng.yun@mediatek.com>
         <693b11e7-fa9e-ab1f-561a-beb758b1872f@redhat.com>
         <1552282383.10179.21.camel@mhfsdcap03>
         <c8084259-74d3-c85f-1275-854826c935a0@redhat.com>
         <1552360688.10179.55.camel@mhfsdcap03>
         <464f1021-4c5e-9137-489d-65fd578575d3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, 2019-03-12 at 13:45 +0100, Hans de Goede wrote:
> Hi,
> On 12-03-19 04:18, Chunfeng Yun wrote:
> > Hi,
> > On Mon, 2019-03-11 at 09:06 +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 11-03-19 06:33, Chunfeng Yun wrote:
> >>> Hi,
> >>>
> >>> On Fri, 2019-03-08 at 13:07 +0100, Hans de Goede wrote:
> >>>> Hi,
> >>>>
> >>>> On 08-03-19 07:13, Chunfeng Yun wrote:
> >>>>> Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
> >>>>> usb-b-connector
> >>>>>
> >>>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> >>>>> ---
> >>>>>     .../devicetree/bindings/connector/usb-connector.txt    | 10 ++++++++++
> >>>>>     1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> >>>>> index a9a2f2fc44f2..7a07b0f4f973 100644
> >>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> >>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> >>>>> @@ -17,6 +17,16 @@ Optional properties:
> >>>>>     - self-powered: Set this property if the usb device that has its own power
> >>>>>       source.
> >>>>>     
> >>>>> +Optional properties for usb-b-connector:
> >>>>> +- id-gpios: gpio for USB ID pin.
> >>>>
> >>>> What about boards where the ID pin is *not* connected to a GPIO,
> >>>> but e.g. to a special pin on the PMIC which can also detect
> >>>> an ACA adapter ? Currently this case is handled by extcon
> >>>> drivers, but we have no way to set e.g. vbus-supply for the
> >>>> connector. Maybe in this case the usb-connector node should
> >>>> be a child of the PMIC node ?
> >>> Yes, it would be, PMIC is in charger of detecting the status of ID pin
> >>
> >> Ok, then I think this should be documented too.
> >>
> >>>> And in many cases there also is a mux to switch the datalines
> >>>> between the host and device(gadget) controllers, how should
> >>>> that be described in this model?  See the new usb-role-switch
> >>>> code under drivers/usb/roles
> >>>>
> >>>> In some cases the mux is controlled through a gpio, so we
> >>>> may want to add a "mux-gpios" here in which case we also
> >>>> need to define what 0/1 means.
> >>> I'm not sure, the mux seems not belong to this connector,
> >>> and may need another driver to register usb-role-switch,
> >>> similar to:
> >>>
> >>> [v2,2/2] usb: typec: add typec switch via GPIO control
> >>> https://patchwork.kernel.org/patch/10834327/
> >>
> >> Right the mux/role-switch will need a driver, but the "owner"
> >> of the usb_connector, e.g. the PMIC or the owner of the
> >> id GPIO pin needs to know which device is the role-switch so
> >> that it can set the role correctly based on the id-pin.
> >>
> >> Your binding already contains Vbus info, allowing the owner
> >> of the usb_connector to enable/disable Vbus based on the id-pin,
> >> but the owner will also be responsible for setting the role-switch.
> > In this patch series, I make usb_connector driver enable/disable Vbus,
> > but not the parent(USB controller) of usb_connector which registers a
> > usb-role-switch, which way do you think it is better?
> 
> IMHO there should not be a driver for the usb_connector child-node,
> only for the parent-device of that child-node.
If so, each USB controller driver should process this special case by
itself when use a gpio to detect the status of ID pin, it's not a
friendly way. And it's easy by using extcon-usb-gpio driver before, so
we also want to provide a simple way when support usb_connector, no
matter what method we choose.

Ideally, the only one thing that USB controller driver need to do, just
register a usb-role-switch, and leave decision when switch the role to
other drivers, such as type-C, PMIC/charger, also include gpio

> 
> There are going to be too many specific setups surrounding PMICs to
> be able to do a single generic driver for the connector.
> 
Fortunately, these patches only focus on the simplest gpio driven role
switch :)

Thanks

> Regards,
> 
> Hans
> 


