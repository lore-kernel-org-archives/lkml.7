Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1102C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C1C20700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oIECdQaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfCYSqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:46:44 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:24198
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729478AbfCYSqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/iQ6PpkFEjj5m8MgxZyf1G5eK5pHu/UZ1XNGZqBrdQ=;
 b=oIECdQaVdUHZ/SGnBNgxIN2lXPdKL5ZnMl0L9poGCml28BkFD1mAXP1t5/+4fuN1i4JJs8DuGQ/t+dTVH9a27z4ZLoQK9beYIgvos8NyehOmQlCMft9EZQ3gtI2Ivh0/CNLwinXzlTk3MXTfT/MMw+BMUhZ3Nc3qyHAPiaeyAOQ=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB5079.eurprd04.prod.outlook.com (20.177.34.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 18:46:39 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::4801:29e5:12d6:cbeb]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::4801:29e5:12d6:cbeb%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 18:46:39 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH] ARM: dts: ls1021: Fix SGMII PCS link remaining down after
 PHY disconnect
Thread-Topic: [PATCH] ARM: dts: ls1021: Fix SGMII PCS link remaining down
 after PHY disconnect
Thread-Index: AQHU4u10/As1+FdGfk+r8tl5GBIdhaYcpd3A
Date:   Mon, 25 Mar 2019 18:46:39 +0000
Message-ID: <AM6PR04MB586318A19F0EE5D9B92B01BC8F5E0@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <1553506240-2584-1-git-send-email-vladimir.oltean@nxp.com>
In-Reply-To: <1553506240-2584-1-git-send-email-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81141c80-ec1e-4cd0-2baf-08d6b1523745
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5079;
x-ms-traffictypediagnostic: AM6PR04MB5079:
x-microsoft-antispam-prvs: <AM6PR04MB5079EE261D385B999183003E8F5E0@AM6PR04MB5079.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(13464003)(256004)(446003)(8936002)(97736004)(74316002)(33656002)(8676002)(316002)(9686003)(52536014)(6636002)(14444005)(99286004)(105586002)(26005)(186003)(102836004)(7736002)(305945005)(106356001)(76176011)(25786009)(5660300002)(81166006)(81156014)(2906002)(6246003)(6436002)(229853002)(4326008)(6116002)(71200400001)(11346002)(486006)(3846002)(55016002)(66066001)(478600001)(53546011)(6506007)(71190400001)(476003)(7696005)(14454004)(2501003)(53936002)(86362001)(68736007)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5079;H:AM6PR04MB5863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fvifTwJmjdF4Ktuz/JytA/U8A4R6CJOexnJzuGV8HSWm3VKgO1fN6iAVMGfTHlnlQoM7AYqj2mD10JTy1CYrj3NRAnuZgNPmXv9rX84k1EisholDM1tNqieOIo2aajKPLoNgwQh1FlIoGC6zCo3sIQAiCc4a7mZppsMo8kWEYUwAQZqzOtwF8nzGyreKfPNUHZWrI4Jzph1zM7Y8lQFcGbEOsdB2hIMLRBpCjcedfvyPSoec+ipgWZlxqDsB+FEjpd41mrbfuyQ4nR2yt1uQzKObQaotN1Cna6ZdelX74MdXkv5z6abxNHN0HT+HMXZeiq4TWS7luRjzZEvzQP8qNkWROi6eNmbd5bBthLKS/+AWM28yyFEX0guhZ7qAmdvGrkIz1h1qa9Anxm0r1ue+iJTjiyPwil5hipPXaRCMpa8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81141c80-ec1e-4cd0-2baf-08d6b1523745
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 18:46:39.1397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vladimir Oltean
> Sent: Monday, March 25, 2019 4:31 AM
> To: shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; Claudiu Manoil
> <claudiu.manoil@nxp.com>
> Cc: robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; davem@davemloft.net; Vladimir Oltean
> <vladimir.oltean@nxp.com>
> Subject: [PATCH] ARM: dts: ls1021: Fix SGMII PCS link remaining down afte=
r
> PHY disconnect
>=20
> Each eTSEC MAC has its own TBI (SGMII) PCS and private MDIO bus.
> But due to a DTS oversight, both SGMII-compatible MACs of the LS1021 SoC
> are pointing towards the same internal PCS. Therefore nobody is controlli=
ng
> the internal PCS of eTSEC0.
>=20
> Upon initial ndo_open, the SGMII link is ok by virtue of U-boot initializ=
ation.
> But upon an ifdown/ifup sequence, the code path from ndo_open ->
> init_phy -> gfar_configure_serdes does not get executed for the PCS of
> eTSEC0 (and is executed twice for MAC eTSEC1). So the SGMII link remains
> down for eTSEC0. On the LS1021A-TWR board, to signal this failure conditi=
on,
> the PHY driver keeps printing
> '803x_aneg_done: SGMII link is not ok'.
>=20
> Fixes: 055223d4d22d ("ARM: dts: ls1021a: Enable the eTSEC ports on QDS
> and TWR")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a-twr.dts | 9 ++++++++-
>  arch/arm/boot/dts/ls1021a.dtsi    | 9 +++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/ls1021a-twr.dts
> b/arch/arm/boot/dts/ls1021a-twr.dts
> index 97e1fb7..9b1fe99 100644
> --- a/arch/arm/boot/dts/ls1021a-twr.dts
> +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> @@ -145,7 +145,7 @@
>  };
>=20
>  &enet0 {
> -	tbi-handle =3D <&tbi1>;
> +	tbi-handle =3D <&tbi0>;
>  	phy-handle =3D <&sgmii_phy2>;
>  	phy-connection-type =3D "sgmii";
>  	status =3D "okay";
> @@ -225,6 +225,13 @@
>  	sgmii_phy2: ethernet-phy@2 {
>  		reg =3D <0x2>;
>  	};
> +	tbi0: tbi-phy@1f {
> +		reg =3D <0x1f>;
> +		device_type =3D "tbi-phy";
> +	};
> +};
> +
> +&mdio1 {
>  	tbi1: tbi-phy@1f {
>  		reg =3D <0x1f>;
>  		device_type =3D "tbi-phy";
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi
> b/arch/arm/boot/dts/ls1021a.dtsi index b4f2723..3a3d264 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -709,6 +709,15 @@
>  			      <0x0 0x2d10030 0x0 0x4>;
>  		};
>=20
> +		mdio1: mdio@2d64000 {
> +			compatible =3D "gianfar";

I know it is not your fault to use this compatible string as it already use=
d this for mdio node in the device tree, but it is somewhat ambiguous to us=
e the same compatible string as the ethernet controller.  And this dts is t=
he only one in all kernel device trees using this compatible string for mdi=
o node.  I would think it will be more clear to use "fsl,etsec2-mdio" or "f=
sl,etsec2-tbi".

> +			device_type =3D "mdio";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x0 0x2d64000 0x0 0x4000>,
> +			      <0x0 0x2d50030 0x0 0x4>;
> +		};
> +
>  		ptp_clock@2d10e00 {
>  			compatible =3D "fsl,etsec-ptp";
>  			reg =3D <0x0 0x2d10e00 0x0 0xb0>;
> --
> 2.7.4

