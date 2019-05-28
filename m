Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A9AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD3E20717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cBkcZmNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfE1TYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:24:09 -0400
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:18339
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726787AbfE1TYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai9jwiNPVbNdbcJ/T84LdDnIB5vxKJDYi8EuBQKg02s=;
 b=cBkcZmNWxtxHIKfhWmHJ1RuLpMdI7Tz2xr6AAOB4w/wkpO2sNnDTKm3IxTnMcizgj52YW3Ws1s/7QerNPWmZOKcBpqzKtny67p+OxaNqDn9h5uJ6ca9KpjdHRRrFKyDmv/1JrDxeU4YOhylGZ4olu2gwqGftr9YfV5ug6uNIm58=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB4557.eurprd04.prod.outlook.com (20.177.55.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 28 May 2019 19:24:05 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 19:24:05 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND 2/5] ARM: dts: imx7d-sdb: Assign corresponding
 power supply for LDOs
Thread-Topic: [PATCH RESEND 2/5] ARM: dts: imx7d-sdb: Assign corresponding
 power supply for LDOs
Thread-Index: AQHVCKkZHNdBkg2sXkeS6OCWrMrKwQ==
Date:   Tue, 28 May 2019 19:24:04 +0000
Message-ID: <VI1PR04MB5055647612FAC2FE6FBE139FEE1E0@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <1557654739-12564-1-git-send-email-Anson.Huang@nxp.com>
 <1557654739-12564-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7eaac96-865a-4e83-fbc3-08d6e3a20c55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4557;
x-ms-traffictypediagnostic: VI1PR04MB4557:
x-microsoft-antispam-prvs: <VI1PR04MB4557DCB8F61FA857AE351E1FEE1E0@VI1PR04MB4557.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(229853002)(446003)(74316002)(9686003)(5660300002)(6436002)(55016002)(6862004)(6246003)(76176011)(6636002)(4326008)(7696005)(54906003)(53936002)(99286004)(66066001)(256004)(71190400001)(71200400001)(478600001)(14454004)(316002)(4744005)(33656002)(3846002)(476003)(6116002)(2906002)(44832011)(486006)(305945005)(186003)(81166006)(52536014)(102836004)(73956011)(66946007)(68736007)(66556008)(81156014)(86362001)(7736002)(64756008)(66446008)(8936002)(66476007)(76116006)(8676002)(25786009)(53546011)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4557;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0j+DgTF6NH1DBCGTSwBl0+4yMycwEiAvvQ4QXasZWxZxIYXpescSRWXRqyuVaN0tzhlSjL9wWgepDghtc0XRNKCxbOfBP/TMffyfYBhNyHPJnFnHgIpoAUtoNN/g38N0KFPOVxfApM2mSdJagd9Q5NXMq7tWpBkS/M93fFNErwMwsUTJHKa3c8MdyWbOF6gY7nmR2AB7IJ/4K9Yqs0Q000MVcORtfSnqds8CMmFF7t93wlqY630KJAaq3VtK73Pk6rpoHL8KMRO0wafb1om5vRu5uwVyAelOYCVUR4cL8F3K7zTgOuR43SMjiU/VmRx1d/mojE87fNHns6+fGNita8dXa5fo3IB/QhQjL3UMKty8k8UMsYQ8oUHgW3jameE4xPhDCQ/dNPddP27TN+3wqymAZr036kfjCBBIVVbOS6U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eaac96-865a-4e83-fbc3-08d6e3a20c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 19:24:04.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.2019 12:57, Anson Huang wrote:=0A=
> On i.MX7D SDB board, sw2 supplies 1p0d/1p2 LDO, this patch assigns=0A=
> corresponding power supply for 1p0d/1p2 LDO to avoid confusion by=0A=
> below log:=0A=
> =0A=
> vdd1p0d: supplied by regulator-dummy=0A=
> vdd1p2: supplied by regulator-dummy=0A=
> =0A=
> With this patch, the power supply is more accurate:=0A=
> =0A=
> vdd1p0d: supplied by SW2=0A=
> vdd1p2: supplied by SW2=0A=
> =0A=
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sd=
b.dts=0A=
>=0A=
> +&reg_1p0d {=0A=
> +	vin-supply =3D <&sw2_reg>;=0A=
> +};=0A=
> +=0A=
> +&reg_1p2 {=0A=
> +	vin-supply =3D <&sw2_reg>;=0A=
> +};=0A=
=0A=
It's not clear why but this patch breaks imx7d-sdb boot. Checked two =0A=
boards: in a board farm and on my desk.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
