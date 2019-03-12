Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571BEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A2A2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfCLCSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:18:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17877 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726316AbfCLCSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:18:42 -0400
X-UUID: a12a79d006a74e179eb8ccdfeea05c9c-20190312
X-UUID: a12a79d006a74e179eb8ccdfeea05c9c-20190312
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 84296105; Tue, 12 Mar 2019 10:18:37 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Mar
 2019 10:18:35 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Mar 2019 10:18:33 +0800
Message-ID: <1552357113.10179.32.camel@mhfsdcap03>
Subject: Re: [PATCH 1/5] dt-bindings: connector: add optional properties for
 Type-B
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
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
Date:   Tue, 12 Mar 2019 10:18:33 +0800
In-Reply-To: <e5eed281-ee9b-6e1c-caea-1372329316be@redhat.com>
References: <1552025622-15582-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552025622-15582-2-git-send-email-chunfeng.yun@mediatek.com>
         <693b11e7-fa9e-ab1f-561a-beb758b1872f@redhat.com>
         <1552282383.10179.21.camel@mhfsdcap03>
         <c8084259-74d3-c85f-1275-854826c935a0@redhat.com>
         <3684aa62-68ad-13ef-7c6e-2b57f7cd62b8@redhat.com>
         <e5eed281-ee9b-6e1c-caea-1372329316be@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

   Please pay attention to Hans' comments for your patch

On Mon, 2019-03-11 at 12:04 +0100, Hans de Goede wrote:
> Hi,
> 
> On 11-03-19 12:00, Hans de Goede wrote:
> > Hi,
> > 
> > On 11-03-19 09:06, Hans de Goede wrote:
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
> >>>>>    .../devicetree/bindings/connector/usb-connector.txt    | 10 ++++++++++
> >>>>>    1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> >>>>> index a9a2f2fc44f2..7a07b0f4f973 100644
> >>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> >>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> >>>>> @@ -17,6 +17,16 @@ Optional properties:
> >>>>>    - self-powered: Set this property if the usb device that has its own power
> >>>>>      source.
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
> >>
> >> Note we cannot simply assume there will be only one role-switch,
> >> we really need some link from the usb_connector to the role-switch
> >> (or if it is a GPIO driven role-switch simply a role-switch-gpios
> >> member in the usb_connector).
> > 
> > I see now in your "[PATCH v3 1/2] dt-bindings: usb: add documentation for
> > typec switch via GPIO" that you plan to use a
> > Documentation/devicetree/bindings/graph.txt style binding for this,
> > adding a remote-endpoint to the orientation-switch (in that patch), or
> > to the role-switch.
> > 
> > But a Type-C port can have both an orientation-switch and a role-switch
> > (and a mux if it supports e.g. DP-altmode), how is the driver driving
> > the device which has the actual usb_c_connecter child-node to which
> > the remote-endpoints for both the orientation- and the role-switch points
> > supposed to figure out which is which ?
> > 
> > Also it feels the wrong-way around to me to have the orientation-switch
> > point to the usb_c_connector, to me it would make more sense to have
> > the usb_c_connector point to a port on the orientation-switch.
> 
> I just noticed you put an "orientation-switch" bool property in the device
> which has the orientation-switch property, if we do something similar for
> the role-switch then that should solve this.
> 
> Regards,
> 
> Hans


