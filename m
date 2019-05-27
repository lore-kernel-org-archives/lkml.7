Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A329C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B10721707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfE0DIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 23:08:45 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:25117 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725923AbfE0DIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 23:08:45 -0400
X-UUID: 2fe144548fe644e0b5a1723aa2584b31-20190527
X-UUID: 2fe144548fe644e0b5a1723aa2584b31-20190527
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 639884790; Mon, 27 May 2019 11:08:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 27 May
 2019 11:08:36 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 27 May 2019 11:08:35 +0800
Message-ID: <1558926515.10179.439.camel@mhfsdcap03>
Subject: Re: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
 node
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Biju Das <biju.das@bp.renesas.com>
CC:     Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Adam Thomson" <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 May 2019 11:08:35 +0800
In-Reply-To: <20190524124445.GP1887@kuha.fi.intel.com>
References: <20190520080359.GC1887@kuha.fi.intel.com>
         <OSBPR01MB2103385D996762FA54F8E437B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190520083601.GE1887@kuha.fi.intel.com>
         <OSBPR01MB2103C4C8920C40E42BC1B2A9B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190521095839.GI1887@kuha.fi.intel.com>
         <OSBPR01MB21032206146152983C8F4E8EB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <1558517436.10179.388.camel@mhfsdcap03>
         <OSBPR01MB21038F2B99EF74831A22727BB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190522142640.GN1887@kuha.fi.intel.com>
         <OSBPR01MB2103B669C24E9E261B4AFA73B8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190524124445.GP1887@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki & Biju,
On Fri, 2019-05-24 at 15:44 +0300, Heikki Krogerus wrote:
> On Wed, May 22, 2019 at 02:57:33PM +0000, Biju Das wrote:
> > Hi Heikki,
> > 
> > Thanks for the patch
> > 
> > > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
> > > node
> > > 
> > > On Wed, May 22, 2019 at 10:55:17AM +0000, Biju Das wrote:
> > > > Hi Chunfeng Yun,
> > > >
> > > > Thanks for the feedback.
> > > >
> > > > > Subject: RE: [PATCH v5 4/6] usb: roles: add API to get
> > > > > usb_role_switch by node
> > > > >
> > > > > Hi Biju,
> > > > > On Wed, 2019-05-22 at 08:05 +0000, Biju Das wrote:
> > > > > > Hi Heikki,
> > > > > >
> > > > > > Thanks for the feedback.
> > > > > >
> > > > > > > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get
> > > > > > > usb_role_switch by node
> > > > > > >
> > > > > > > On Mon, May 20, 2019 at 09:45:46AM +0000, Biju Das wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > Hi Heikki,
> > > > > > > >
> > > > > > > > Thanks for the feedback.
> > > > > > > >
> > > > > > > > > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get
> > > > > > > > > usb_role_switch by node
> > > > > > > > >
> > > > > > > > > On Mon, May 20, 2019 at 08:06:41AM +0000, Biju Das wrote:
> > > > > > > > > > Hi Heikki,
> > > > > > > > > >
> > > > > > > > > > > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get
> > > > > > > > > > > usb_role_switch by node
> > > > > > > > > > >
> > > > > > > > > > > On Mon, May 20, 2019 at 10:39:11AM +0800, Chunfeng Yun
> > > wrote:
> > > > > > > > > > > > Hi,
> > > > > > > > > > > > On Fri, 2019-05-17 at 16:05 +0300, Heikki Krogerus wrote:
> > > > > > > > > > > > > Hi,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, May 17, 2019 at 01:37:36PM +0300, Heikki
> > > > > > > > > > > > > Krogerus
> > > > > wrote:
> > > > > > > > > > > > > > On Tue, May 14, 2019 at 04:47:21PM +0800, Chunfeng
> > > > > > > > > > > > > > Yun
> > > > > > > wrote:
> > > > > > > > > > > > > > > Add fwnode_usb_role_switch_get() to make easier
> > > > > > > > > > > > > > > to get usb_role_switch by fwnode which register it.
> > > > > > > > > > > > > > > It's useful when there is not device_connection
> > > > > > > > > > > > > > > registered between two drivers and only knows
> > > > > > > > > > > > > > > the fwnode which register usb_role_switch.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Chunfeng Yun
> > > > > > > > > > > > > > > <chunfeng.yun@mediatek.com>
> > > > > > > > > > > > > > > Tested-by: Biju Das <biju.das@bp.renesas.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Acked-by: Heikki Krogerus
> > > > > > > > > > > > > > <heikki.krogerus@linux.intel.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hold on. I just noticed Rob's comment on patch 2/6,
> > > > > > > > > > > > > where he points out that you don't need to use
> > > > > > > > > > > > > device graph since the controller is the parent of
> > > > > > > > > > > > > the connector. Doesn't that mean you don't really need
> > > this API?
> > > > > > > > > > > > No, I still need it.
> > > > > > > > > > > > The change is about the way how to get fwnode; when
> > > > > > > > > > > > use device graph, get fwnode by
> > > > > > > > > > > > of_graph_get_remote_node(); but now will get fwnode by
> > > > > > > > > > > > of_get_parent();
> > > > > > > > > > >
> > > > > > > > > > > OK, I get that, but I'm still not convinced about if
> > > > > > > > > > > something like this function is needed at all. I also
> > > > > > > > > > > have concerns regarding how you are using the function.
> > > > > > > > > > > I'll explain in comment to the patch 5/6 in this
> > > > > > > > > series...
> > > > > > > > > >
> > > > > > > > > > FYI, Currently  I am also using this api in my patch series.
> > > > > > > > > > https://patchwork.kernel.org/patch/10944637/
> > > > > > > > >
> > > > > > > > > Yes, and I have the same question for you I jusb asked in
> > > > > > > > > comment I added to the patch 5/6 of this series. Why isn't
> > > > > > > > > usb_role_switch_get()
> > > > > > > enough?
> > > > > > > >
> > > > > > > > Currently no issue. It will work with this api as well, since
> > > > > > > > the port node is
> > > > > > > part of controller node.
> > > > > > > > For eg:-
> > > > > > > > https://patchwork.kernel.org/patch/10944627/
> > > > > > > >
> > > > > > > > However if any one adds port node inside the connector node,
> > > > > > > > then this
> > > > > > > api may won't work as expected.
> > > > > > > > Currently I get below error
> > > > > > > >
> > > > > > > > [    2.299703] OF: graph: no port node found in
> > > > > > > /soc/i2c@e6500000/hd3ss3220@47
> > > > > > >
> > > > > > > We need to understand why is that happening?
> > > > > > >
> > > > > >
> > > > > > Form the stack trace  the parent node is
> > > > > > "parent_node=hd3ss3220@47" ,
> > > > > instead of the "connector" node.
> > > > > > That is the reason for the above error.
> > > > > >
> > > > > > [    2.442429]  of_graph_get_next_endpoint.part.0+0x28/0x168
> > > > > > [    2.447889]  of_fwnode_graph_get_next_endpoint+0x5c/0xb0
> > > > > > [    2.453267]  fwnode_graph_get_next_endpoint+0x20/0x30
> > > > > > [    2.458374]  device_connection_find_match+0x74/0x1a0
> > > > > > [    2.463399]  usb_role_switch_get+0x20/0x28
> > > > > > [    2.467542]  hd3ss3220_probe+0xc4/0x218
> > > > > >
> > > > > > The use case is
> > > > > >
> > > > > > &i2c0 {
> > > > > > 	hd3ss3220@47 {
> > > > > >                  	compatible = "ti,hd3ss3220";
> > > > > >
> > > > > >                  	usb_con: connector {
> > > > > >                           		compatible = "usb-c-connector";
> > > > > >                          		port {
> > > > > >                                 		 hd3ss3220_ep: endpoint {
> > > > > >                                         			remote-endpoint =
> > > > > <&usb3_role_switch>;
> > > > > >                                 		};
> > > > > >                          		};
> > > > > >                 	 };
> > > > > > 	 };
> > > > > > };
> > > > > >
> > > > > > &usb3_peri0 {
> > > > > >          companion = <&xhci0>;
> > > > > >          usb-role-switch;
> > > > > >
> > > > > >          port {
> > > > > >                 usb3_role_switch: endpoint {
> > > > > >                         remote-endpoint = <&hd3ss3220_ep>;
> > > > > >                  };
> > > > > >          };
> > > > > > };
> > > > > >
> > > > > > Q1) How do we modify the usb_role_switch_get() function to search
> > > > > > Child(connector) and child's endpoint?
> > > > > How about firstly finding connector node in
> > > > > fwnode_graph_devcon_match(), then search each endpoint?
> > > >
> > > >  I have done a quick prototyping with the changes you suggested and it
> > > works.
> > > >
> > > > -       struct fwnode_handle *ep;
> > > > +       struct fwnode_handle *ep,*child,*tmp = fwnode;
> > > >
> > > > -       fwnode_graph_for_each_endpoint(fwnode, ep) {
> > > > +       child = fwnode_get_named_child_node(fwnode, "connector");
> > > > +       if (child)
> > > > +               tmp = child;
> > > > +
> > > > +       fwnode_graph_for_each_endpoint(tmp, ep) {
> > > >
> > > > Form the stack trace  the parent node is "parent_node= connector" .
> > > >
> > > > [    2.440922]  of_graph_get_next_endpoint.part.0+0x28/0x168
> > > > [    2.446381]  of_fwnode_graph_get_next_endpoint+0x5c/0xb0
> > > > [    2.451758]  fwnode_graph_get_next_endpoint+0x20/0x30
> > > > [    2.456866]  device_connection_find_match+0x84/0x1c0
> > > > [    2.461888]  usb_role_switch_get+0x20/0x28
> > > >
> > > > Heikki,
> > > > Are you ok  with the above changes?
> > > 
> > > Doesn't that mean that if we made fwnode_usb_role_switch_get() the way I
> > > proposed, there is no problem? You just find the "connector" child node in
> > > your driver, and pass that to fwnode_usb_role_switch_get():
> > 
> > Yes, That is correct.
> > 
> > >         struct fwnode_handle *connector;
> > >         ...
> > >         connector = device_get_named_child_node(&client->dev, "connector");
> > >         if (IS_ERR(connector))
> > >                 <do something>
> > > 
> > >         hd3ss3220->role_sw = fwnode_usb_role_switch_get(connector);
> > >         ...
> > > 
> > > The difference is that instead of just converting a device node of an usb role
> > > switch to the usb role switch, it works just like usb_role_switch_get(), just
> > > taking fwnode instead of device entry as parameter.
> > > 
> > > I prepared the patches implementing fwnode_usb_role_switch_get() the
> > > way I though it needs to work for my own tests. Please find the patches
> > > attached.
> > 
> > I have tested  this patches and conform it works. 
> > Do you plan to post this patches to ML? 
> 
> Could make them part of this series?
I'll do it, thanks
> 
> 
> thanks,
> 


