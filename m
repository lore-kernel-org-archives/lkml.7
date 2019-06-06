Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF96C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 03:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3149A20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 03:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nHQPlhki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFFDYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 23:24:43 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:55926
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbfFFDYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 23:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOOuwUCUiVc6WZkaFHa4DL/UnHk2vuFFTUvIS+XE/yM=;
 b=nHQPlhkitmnSLTH4moWsWcndSusPKuOpPyHadm23ouSdgc4pzjRV9vSQ1m7owB9aSQzwWdDUgwGKrgRs6oM9kpH5nhCyqGSDg5/C+Mo4M7wDaA/rnWGb2QQKmZwOX/Ya7++j8tIcy8lEx/fUSsXXBFmmxLn0AjNXcYOm8PogPRk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6484.eurprd04.prod.outlook.com (20.179.253.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.13; Thu, 6 Jun 2019 03:24:38 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015%3]) with mapi id 15.20.1943.023; Thu, 6 Jun 2019
 03:24:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
 mailbox
Thread-Topic: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
 mailbox
Thread-Index: AQHVGeZSRIOE2F02XEeufaIbr7CheqaKHTcAgAAJqoCAAAYrAIADzXeQ
Date:   Thu, 6 Jun 2019 03:24:38 +0000
Message-ID: <AM0PR04MB4481632406DF235996719C0788170@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
        <20190603083005.4304-2-peng.fan@nxp.com>
        <ae4c79f0-4aec-250e-e312-20aba5554665@gmail.com>
        <20190603165651.GA12196@e107155-lin>
 <20190603181856.34996aaa@donnerap.cambridge.arm.com>
In-Reply-To: <20190603181856.34996aaa@donnerap.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a62be9d-0f03-48e8-cd66-08d6ea2e81bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6484;
x-ms-traffictypediagnostic: AM0PR04MB6484:
x-microsoft-antispam-prvs: <AM0PR04MB6484A7483A3A2076490127C788170@AM0PR04MB6484.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(7696005)(33656002)(186003)(53546011)(102836004)(26005)(3846002)(6116002)(7416002)(6506007)(76176011)(66066001)(229853002)(6436002)(6246003)(8676002)(14454004)(15650500001)(74316002)(316002)(110136005)(5660300002)(54906003)(478600001)(71200400001)(71190400001)(99286004)(52536014)(4326008)(66556008)(25786009)(7736002)(256004)(53936002)(55016002)(2906002)(81156014)(86362001)(81166006)(8936002)(14444005)(68736007)(486006)(44832011)(446003)(11346002)(476003)(66476007)(66946007)(76116006)(73956011)(64756008)(66446008)(9686003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6484;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EANI2+MuLpqHK8Wycwtqs5ea69v7RjMfu3vwMzfrGpE/mf9lLQlFUK0CFJPD/VQ+WaMUhE/Dvgo6bLDEZXm7XayHXMzth84b0p2BVTK1/zQXBox8Njn9M9YVTagkV5ZvX4R1lB8x+tjhu2yXvdVRlWfPfnkaDahKKf8YXC0eI+a9uuFvuSqjGuRCDL/apRGRADEX/sE5mtqqYWuD6lTW4ejuKGwqr9NX6F5x8ytBzjwYVkgkl2syYN3PuPpZY1CSt9yuGwMarXitsJ7XOgUyg3L5XlJWP9A6PzjMXy1eDljjsOvRH9qus0i4nnL+bIkK/wS8wq4608JCgablQIPdDopUDiuHzx/Eazo+oMy8/yjM5pOeIQd/0pPB3w4YMFtE44B6xmlK+Fq8FFrsfbl3aNGIrQgMnHluxAnfxx7gxH8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a62be9d-0f03-48e8-cd66-08d6ea2e81bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 03:24:38.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
> mailbox
>=20
> On Mon, 3 Jun 2019 17:56:51 +0100
> Sudeep Holla <sudeep.holla@arm.com> wrote:
>=20
> Hi,
>=20
> > On Mon, Jun 03, 2019 at 09:22:16AM -0700, Florian Fainelli wrote:
> > > On 6/3/19 1:30 AM, peng.fan@nxp.com wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > The ARM SMC mailbox binding describes a firmware interface to
> > > > trigger actions in software layers running in the EL2 or EL3 except=
ion
> levels.
> > > > The term "ARM" here relates to the SMC instruction as part of the
> > > > ARM instruction set, not as a standard endorsed by ARM Ltd.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >
> > > > V2:
> > > > Introduce interrupts as a property.
> > > >
> > > > V1:
> > > > arm,func-ids is still kept as an optional property, because there
> > > > is no defined SMC funciton id passed from SCMI. So in my test, I
> > > > still use arm,func-ids for ARM SIP service.
> > > >
> > > >  .../devicetree/bindings/mailbox/arm-smc.txt        | 101
> +++++++++++++++++++++
> > > >  1 file changed, 101 insertions(+)  create mode 100644
> > > > Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > > b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > > new file mode 100644
> > > > index 000000000000..401887118c09
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > > @@ -0,0 +1,101 @@
> >
> > [...]
> >
> > > > +Optional properties:
> > > > +- arm,func-ids		An array of 32-bit values specifying the function
> > > > +			IDs used by each mailbox channel. Those function IDs
> > > > +			follow the ARM SMC calling convention standard [1].
> > > > +			There is one identifier per channel and the number
> > > > +			of supported channels is determined by the length
> > > > +			of this array.
> > > > +- interrupts		SPI interrupts may be listed for notification,
> > > > +			each channel should use a dedicated interrupt
> > > > +			line.
> > >
> > > I would not go about defining a specific kind of interrupt, since
> > > SPI is a GIC terminology, this firmware interface could be used in
> > > premise with any parent interrupt controller, for which the concept
> > > of a SPI/PPI/SGI may not be relevant.
> > >
> >
> > While I agree the binding document may not contain specifics, I still
> > don't see how to use SGI with this. Also note it's generally reserved
> > for OS future use(IPC) and using this for other than IPC may be bit
> > challenging IMO. It opens up lots of questions.
>=20
> Well, a PPI might be possible to use, although it's somewhat dodgy to hij=
ack
> the GIC's (re-)distributor from EL3 to write to GICD_ISPENDR<n>. Need to =
ask
> Marc about his feelings towards this. But it's definitely possible from a
> hypervisor to inject arbitrary interrupts into a guest.
>=20
> But more importantly: is there any actual reason this needs to be a GIC
> interrupt?=20

No. I just test ATF with SPI when I posting out this. Should not restrict t=
o be GIC.

If I understand the code correctly, this could just be any interrupt,
> including one of an interrupt combiner or a GPIO chip. So why not just us=
e the
> standard wording of: "exactly one interrupt specifier for each channel"?

Agree.

>=20
> By the way: Shouldn't new bindings use the YAML format instead?

I'll convert to YAML in next version.

Thanks,
Peng.

>=20
> Cheers,
> Andre.
