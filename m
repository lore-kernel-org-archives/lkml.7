Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD7DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB94216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F+eBurhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEGIsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:48:35 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:62081
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfEGIsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq3CVt2b3lc5FgEiUrsD8dwwYa/6bf7sNuyyllfY9Qc=;
 b=F+eBurhH5ulkkI/Ip3iWxA7Fvj17RV1u8yGpfDq2GcYSOGcKaSsdjTZjZHY6s93kE8DnQjT3m7+kCUQO6lVrYMFlbjFILdD4KWz8BrNH3kJgoUkdiZcT37LnV/3GuMAVZsN/6a6O7s5iVo4VN/WEHAv3zZtaONraskrqCzgypKE=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2849.eurprd04.prod.outlook.com (10.175.40.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 7 May 2019 08:48:31 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51%9]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 08:48:31 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: dts: ls1028a: Add USB dt nodes
Thread-Topic: [PATCH v2] arm64: dts: ls1028a: Add USB dt nodes
Thread-Index: AQHU+/SBIFirjMEfrESTZvW0Hl61haZW+m4AgAhvTQA=
Date:   Tue, 7 May 2019 08:48:31 +0000
Message-ID: <AM5PR0402MB286539A070BDEEDFC3304F0EF1310@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190426055558.44544-1-ran.wang_1@nxp.com>
 <20190501235410.GA25492@bogus>
In-Reply-To: <20190501235410.GA25492@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd759458-80dc-4b19-23ff-08d6d2c8c853
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2849;
x-ms-traffictypediagnostic: AM5PR0402MB2849:
x-microsoft-antispam-prvs: <AM5PR0402MB2849500B82E1C50B29BEE3BFF1310@AM5PR0402MB2849.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(305945005)(86362001)(71190400001)(71200400001)(6506007)(6246003)(81156014)(6916009)(53546011)(33656002)(81166006)(54906003)(53936002)(8676002)(26005)(55016002)(446003)(5660300002)(186003)(7736002)(9686003)(8936002)(74316002)(52536014)(256004)(102836004)(6436002)(73956011)(7696005)(316002)(11346002)(486006)(66556008)(66476007)(64756008)(66446008)(14454004)(66946007)(99286004)(68736007)(76116006)(76176011)(229853002)(66066001)(25786009)(2906002)(4326008)(478600001)(14444005)(476003)(3846002)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2849;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Adic0pvt9H5MNoFvyJ0glYIODbCuQCtSp47pzv5ExGAAkbdyCY+sMLA9zEkT3YBpeKBg8w0dOLsavZlo+ymemg5m/UfvyIUJWPDuQMO47r+JUYjWNWun5jucu7lCg0IppuHIXUqM8mw5CeZSd+Bf3z0CvUiWUGoaOGU5pRofAN+8X+YbK8QOX2A+K6qB8ca0dX0syNsE57aQKeZtSLKEZMuITh4YlB5ypCozvgR4TcU1mFlWCPWWbO1EFt0NEoQcQRE2UpG4gtDo4TDZQtbFU5cqLDTVZYxukVpItMyfqNHsPSa/tbf9MJIXO+x0nff3eji7OCWZK1gwhIiAtpySQRDIsYvpbAUFXbJpkgwFq8z20Z4lJ91S7L74ya2TaE9LuIji+XYweQQnnIobwK+SbBjra7lhVq/AuMIZLmlYEuA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd759458-80dc-4b19-23ff-08d6d2c8c853
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 08:48:31.4346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thursday, May 02, 2019 07:54 Rob Herring wrote:
>=20
> On Fri, Apr 26, 2019 at 05:54:26AM +0000, Ran Wang wrote:
> > This patch adds USB dt nodes for LS1028A.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> > Changes in v2:
> >   - Rename node from usb3@... to usb@... to meet DTSpec
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   20
> ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 8dd3501..188cfb8 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -144,6 +144,26 @@
> >  			clocks =3D <&sysclk>;
> >  		};
> >
> > +		usb0:usb@3100000 {
>                      ^ space needed

Yes, will update this in next version.
=20
> > +			compatible=3D "snps,dwc3";
>=20
> Needs an SoC specific compatible.

Do you mean change compatible to "snps,dwc3", "fsl,ls1028a-dwc3" ?

As I know, so far there is no SoC specific programming for this IP, so do
you think it's still necessary to add it?

Regards,
Ran

> > +			reg=3D <0x0 0x3100000 0x0 0x10000>;
> > +			interrupts=3D <0 80 0x4>;
> > +			dr_mode=3D "host";
> > +			snps,dis_rxdet_inp3_quirk;
> > +			snps,quirk-frame-length-adjustment =3D <0x20>;
> > +			snps,incr-burst-type-adjustment =3D <1>, <4>, <8>, <16>;
> > +		};
> > +
> > +		usb1:usb@3110000 {
> > +			compatible=3D "snps,dwc3";
> > +			reg=3D <0x0 0x3110000 0x0 0x10000>;
> > +			interrupts=3D <0 81 0x4>;
> > +			dr_mode=3D "host";
> > +			snps,dis_rxdet_inp3_quirk;
> > +			snps,quirk-frame-length-adjustment =3D <0x20>;
> > +			snps,incr-burst-type-adjustment =3D <1>, <4>, <8>, <16>;
> > +		};
> > +
> >  		i2c0: i2c@2000000 {
> >  			compatible =3D "fsl,vf610-i2c";
> >  			#address-cells =3D <1>;
> > --
> > 1.7.1
> >
