Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE6C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F9321743
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rjCipubR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfGIBks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:40:48 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:15266
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfGIBks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAYUNZqACxVsg1LbGPW+thCUDZSdznnMZMPyN61jD34=;
 b=rjCipubRR4UclVv3h8eLgufxtDjlIkog6MpAxM2YJFPCiueEPTMctnFyqfPQeNbWGmaG2wAwJQrtU9sFG1+5wby68cBZSkwvOK+Ljx9rztrTnKlsZgxJ/PoB0TPwDD8UujPs+N5C8XHp0CO99+wmvSY3p0IC1VkKGIlTgPjIIyg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5988.eurprd04.prod.outlook.com (20.178.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 01:40:42 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 01:40:42 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
 mailbox
Thread-Topic: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
 mailbox
Thread-Index: AQHVGeZSRIOE2F02XEeufaIbr7CheqbBgrOAgAA3osA=
Date:   Tue, 9 Jul 2019 01:40:41 +0000
Message-ID: <AM0PR04MB44816C38C43A3C8E09E8FFF588F10@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-2-peng.fan@nxp.com> <20190708221947.GA13552@bogus>
In-Reply-To: <20190708221947.GA13552@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42ec24e4-e0d3-4b63-e910-08d7040e741e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5988;
x-ms-traffictypediagnostic: AM0PR04MB5988:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB598855F981999A8D8B9363D588F10@AM0PR04MB5988.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(8936002)(68736007)(66066001)(11346002)(99286004)(4326008)(446003)(33656002)(6116002)(3846002)(71190400001)(74316002)(14454004)(476003)(6916009)(15650500001)(2906002)(14444005)(71200400001)(44832011)(81166006)(229853002)(64756008)(6246003)(55016002)(6306002)(9686003)(26005)(6436002)(256004)(66476007)(7416002)(66446008)(53936002)(66556008)(305945005)(7736002)(66946007)(81156014)(8676002)(76116006)(73956011)(86362001)(52536014)(316002)(54906003)(7696005)(186003)(25786009)(102836004)(45080400002)(76176011)(486006)(5660300002)(6506007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5988;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6NqkskxAMPb2EUyQIGQuK27+AabGMhVGbiND4/ZC2eIdV0UnvIEhef0tYarcRR+mz64xaNdNQsK1WnLBNMoDO5KPpT2j/k1raGxvCgFtQXfUwTD7223jTka3k2KONw/ldFu1x/4tbDPZTbpYIix3yz/3LsQmZLb2DsEvKKcHu9u5k12BmjsMMhKsoVwh8+TzkqwJQYe7cmT6wAxKOadebYOadLxiqBnLnWi5GVvzXwJGOk8PZOzMgF1u2BlEDGBqSQwlcCM4crQ3PWJnAS7xfwhijujLPYv5pcj7YJ84LKFHOI8g6l0peg7me+vYHuk/qZuEgYHpN0NsFY5mm0B6jaFqq0mRNz3x1VyAM+2l+H7GY8+v8xPqTdtK5mYgmfYhEkqky5/uGfZmqrWh9E9tScRkBMtGgOji1XC+7/+tGSg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ec24e4-e0d3-4b63-e910-08d7040e741e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 01:40:41.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
> mailbox
>=20
> On Mon, Jun 03, 2019 at 04:30:04PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The ARM SMC mailbox binding describes a firmware interface to trigger
> > actions in software layers running in the EL2 or EL3 exception levels.
> > The term "ARM" here relates to the SMC instruction as part of the ARM
> > instruction set, not as a standard endorsed by ARM Ltd.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> > Introduce interrupts as a property.
> >
> > V1:
> > arm,func-ids is still kept as an optional property, because there is
> > no defined SMC funciton id passed from SCMI. So in my test, I still
> > use arm,func-ids for ARM SIP service.
> >
> >  .../devicetree/bindings/mailbox/arm-smc.txt        | 101
> +++++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mailbox/arm-smc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > new file mode 100644
> > index 000000000000..401887118c09
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > @@ -0,0 +1,101 @@
> > +ARM SMC Mailbox Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +This mailbox uses the ARM smc (secure monitor call) instruction to
> > +trigger a mailbox-connected activity in firmware, executing on the
> > +very same core as the caller. By nature this operation is synchronous
> > +and this mailbox provides no way for asynchronous messages to be
> > +delivered the other way round, from firmware to the OS, but
> > +asynchronous notification could also be supported. However the value
> > +of r0/w0/x0 the firmware returns after the smc call is delivered as a
> > +received message to the mailbox framework, so a synchronous
> > +communication can be established, for a asynchronous notification, no
> > +value will be returned. The exact meaning of both the action the
> > +mailbox triggers as well as the return value is defined by their users=
 and is
> not subject to this binding.
> > +
> > +One use case of this mailbox is the SCMI interface, which uses shared
> > +memory to transfer commands and parameters, and a mailbox to trigger
> > +a function call. This allows SoCs without a separate management
> > +processor (or when such a processor is not available or used) to use
> > +this standardized interface anyway.
> > +
> > +This binding describes no hardware, but establishes a firmware interfa=
ce.
> > +Upon receiving an SMC using one of the described SMC function
> > +identifiers, the firmware is expected to trigger some mailbox connecte=
d
> functionality.
> > +The communication follows the ARM SMC calling convention[1].
> > +Firmware expects an SMC function identifier in r0 or w0. The
> > +supported identifiers are passed from consumers, or listed in the the
> > +arm,func-ids properties as described below. The firmware can return
> > +one value in the first SMC result register, it is expected to be an
> > +error value, which shall be propagated to the mailbox client.
> > +
> > +Any core which supports the SMC or HVC instruction can be used, as
> > +long as a firmware component running in EL3 or EL2 is handling these c=
alls.
> > +
> > +Mailbox Device Node:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This node is expected to be a child of the /firmware node.
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:		Shall be "arm,smc-mbox"
> > +- #mbox-cells		Shall be 1 - the index of the channel needed.
> > +- arm,num-chans		The number of channels supported.
> > +- method:		A string, either:
> > +			"hvc": if the driver shall use an HVC call, or
> > +			"smc": if the driver shall use an SMC call.
> > +
> > +Optional properties:
> > +- arm,func-ids		An array of 32-bit values specifying the function
> > +			IDs used by each mailbox channel. Those function IDs
> > +			follow the ARM SMC calling convention standard [1].
> > +			There is one identifier per channel and the number
> > +			of supported channels is determined by the length
> > +			of this array.
> > +- interrupts		SPI interrupts may be listed for notification,
> > +			each channel should use a dedicated interrupt
> > +			line.
> > +
> > +Example:
> > +--------
> > +
> > +	sram@910000 {
> > +		compatible =3D "mmio-sram";
> > +		reg =3D <0x0 0x93f000 0x0 0x1000>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		ranges =3D <0 0x0 0x93f000 0x1000>;
> > +
> > +		cpu_scp_lpri: scp-shmem@0 {
> > +			compatible =3D "arm,scmi-shmem";
> > +			reg =3D <0x0 0x200>;
> > +		};
> > +
> > +		cpu_scp_hpri: scp-shmem@200 {
> > +			compatible =3D "arm,scmi-shmem";
> > +			reg =3D <0x200 0x200>;
> > +		};
> > +	};
> > +
> > +	smc_mbox: mailbox {
>=20
> This should be a child of 'firmware' node at least and really a child of =
the
> firmware component that implements the feature.

I checked other mbox driver, including the mbox used by ti sci, mbox used b=
y
i.MX8QXP. both mbox dts node not a child a firmware node,
I am not sure why put mbox node into a child a firmware node here.

Thanks,
Peng.

>=20
> > +		#mbox-cells =3D <1>;
> > +		compatible =3D "arm,smc-mbox";
> > +		method =3D "smc";
> > +		arm,num-chans =3D <0x2>;
> > +		/* Optional */
> > +		arm,func-ids =3D <0xc20000fe>, <0xc20000ff>;
> > +	};
> > +
> > +	firmware {
> > +		scmi {
> > +			compatible =3D "arm,scmi";
> > +			mboxes =3D <&mailbox 0 &mailbox 1>;
> > +			mbox-names =3D "tx", "rx";
> > +			shmem =3D <&cpu_scp_lpri &cpu_scp_hpri>;
> > +		};
> > +	};
> > +
> > +
> > +[1]
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Finf=
o
> >
> +center.arm.com%2Fhelp%2Findex.jsp%3Ftopic%3D%2Fcom.arm.doc.den002
> 8a%2
> >
> +Findex.html&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7Cd8cf8b81b4f
> b49be5
> >
> +97c08d703f26576%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7
> C63698221
> >
> +1931902513&amp;sdata=3DRtHkNN07b%2FuzdJkiu0QujeJ6czrcwOwEI6Y6JW
> VpPkY%3D
> > +&amp;reserved=3D0
> > --
> > 2.16.4
> >
