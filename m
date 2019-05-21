Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F87C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA667217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfEUHfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:35:16 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:3346 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726227AbfEUHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:35:15 -0400
X-UUID: 4a52d235df804a5ca0fb31ee7171f658-20190521
X-UUID: 4a52d235df804a5ca0fb31ee7171f658-20190521
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1524086201; Tue, 21 May 2019 15:35:06 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 21 May
 2019 15:35:05 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 May 2019 15:35:04 +0800
Message-ID: <1558424104.10179.365.camel@mhfsdcap03>
Subject: RE: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
 node
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Biju Das <biju.das@bp.renesas.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
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
Date:   Tue, 21 May 2019 15:35:04 +0800
In-Reply-To: <OSBPR01MB2103C4C8920C40E42BC1B2A9B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
         <1557823643-8616-5-git-send-email-chunfeng.yun@mediatek.com>
         <20190517103736.GA1490@kuha.fi.intel.com>
         <20190517130511.GA1887@kuha.fi.intel.com>
         <1558319951.10179.352.camel@mhfsdcap03>
         <20190520080359.GC1887@kuha.fi.intel.com>
         <OSBPR01MB2103385D996762FA54F8E437B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190520083601.GE1887@kuha.fi.intel.com>
         <OSBPR01MB2103C4C8920C40E42BC1B2A9B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
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
On Mon, 2019-05-20 at 09:45 +0000, Biju Das wrote:
> 
> Hi Heikki,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
> > node
> > 
> > On Mon, May 20, 2019 at 08:06:41AM +0000, Biju Das wrote:
> > > Hi Heikki,
> > >
> > > > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get
> > > > usb_role_switch by node
> > > >
> > > > On Mon, May 20, 2019 at 10:39:11AM +0800, Chunfeng Yun wrote:
> > > > > Hi,
> > > > > On Fri, 2019-05-17 at 16:05 +0300, Heikki Krogerus wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Fri, May 17, 2019 at 01:37:36PM +0300, Heikki Krogerus wrote:
> > > > > > > On Tue, May 14, 2019 at 04:47:21PM +0800, Chunfeng Yun wrote:
> > > > > > > > Add fwnode_usb_role_switch_get() to make easier to get
> > > > > > > > usb_role_switch by fwnode which register it.
> > > > > > > > It's useful when there is not device_connection registered
> > > > > > > > between two drivers and only knows the fwnode which register
> > > > > > > > usb_role_switch.
> > > > > > > >
> > > > > > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > > > > Tested-by: Biju Das <biju.das@bp.renesas.com>
> > > > > > >
> > > > > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > >
> > > > > > Hold on. I just noticed Rob's comment on patch 2/6, where he
> > > > > > points out that you don't need to use device graph since the
> > > > > > controller is the parent of the connector. Doesn't that mean you
> > > > > > don't really need this API?
> > > > > No, I still need it.
> > > > > The change is about the way how to get fwnode; when use device
> > > > > graph, get fwnode by of_graph_get_remote_node(); but now will get
> > > > > fwnode by of_get_parent();
> > > >
> > > > OK, I get that, but I'm still not convinced about if something like
> > > > this function is needed at all. I also have concerns regarding how
> > > > you are using the function. I'll explain in comment to the patch 5/6 in this
> > series...
> > >
> > > FYI, Currently  I am also using this api in my patch series.
> > > https://patchwork.kernel.org/patch/10944637/
> > 
> > Yes, and I have the same question for you I jusb asked in comment I added
> > to the patch 5/6 of this series. Why isn't usb_role_switch_get() enough?
> 
> Currently no issue. It will work with this api as well, since the port node is part of controller node.
> For eg:-
> https://patchwork.kernel.org/patch/10944627/
> 
> However if any one adds port node inside the connector node, then this api may won't work as expected.
> Currently I get below error
> 
> [    2.299703] OF: graph: no port node found in /soc/i2c@e6500000/hd3ss3220@47
> 
> For eg:-
> 
> 	hd3ss3220@47 {
> 		compatible = "ti,hd3ss3220";
> 		...
> 		....
> 		usb_con: connector {
>                                      ....
>                                      ....
> 			port {
> 				hd3ss3220_ep: endpoint@0 {
> 					reg = <0>;
> 					remote-endpoint = <&usb3peri_role_switch>;
> 				};
> 			};
> 		};
> 	};
> 
> Regards,
> Biju

I tested 3 cases:

case 1:

connector {
    compatible = "linux,typeb-conn-gpio", "usb-b-connector";
    label = "micro-USB";
    type = "micro";
    id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
    vbus-supply = <&usb_p0_vbus>;

    port {
        bconn_ep: endpoint@0 {
            remote-endpoint = <&usb_role_sw>;
        };
    };
};

&mtu3 {
    usb-role-switch;

    port {
        usb_role_sw: endpoint@0 {
            remote-endpoint = <&bconn_ep>;
        };
    };
};

the driver of connector could use usb_role_switch_get(dev) to get
mtu3's USB Role Switch. (dev is the device of connector)

case 2:

&mtu3 {
    usb-role-switch;

    connector {
        compatible = "linux,typeb-conn-gpio", "usb-b-connector";
        label = "micro-USB";
        type = "micro";
        id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
        vbus-supply = <&usb_p0_vbus>;
    };
};

the driver of connector using usb_role_switch_get(dev) failed to get
mtu3's USB Role Switch.
error log:
#OF: graph: no port node found in /usb@11271000/connector
this is because connector hasn't child node connected to remote
endpoint which register USB Role Switch

case 3:

rsw_iddig: role_sw_iddig {
    compatible = "linux,typeb-conn-gpio";
    status = "okay";

    connector {
        compatible = "usb-b-connector";
        label = "micro-USB";
        type = "micro";
        id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
        vbus-supply = <&usb_p0_vbus>;

        port {
            bconn_ep: endpoint@0 {
                remote-endpoint = <&usb_role_sw>;
            };
        };
    };
};

&mtu3 {
    usb-role-switch;

    port {
        usb_role_sw: endpoint@0 {
            remote-endpoint = <&bconn_ep>;
        };
    };
};


the driver of connector using usb_role_switch_get(dev) also failed to
get mtu3's USB Role Switch. Because usb_role_switch_get() only search
its child nodes (connector node), but not child's child (port node)
This case is the same as Biju's

Usually type-c is similar with case 3;
the next version v6 of this series will use case 2 as Rob suggested,
see [v5, 2/6]

for case 2, will need the new API fwnode_usb_role_switch_get();
for case 3, use the new API, or need modify usb_role_switch_get();


