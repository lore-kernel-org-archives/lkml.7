Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3671DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92172086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIdpzTd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfF1GpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:45:11 -0400
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:37696
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbfF1GpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzpOF9k3OtNN6SAfRIg3+Gwqwhl8IFtRP9SE64p5lTk=;
 b=GIdpzTd8qAtdUPpPeTTwMcwAyxPxPrcattEO4M/k0Ho5YLI0DLvZfAmDUsWZXhTPGfl69jU1qKqLoNeYuhoRcBHQC+fSgEy+Z1HiBFOdA4jsWdpjxZIPQQCy0oRFpujccYVXL5lEy1oYWhEv6FmwhqTdIVFhEPazBPCMb3gR4mo=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5039.eurprd04.prod.outlook.com (20.177.50.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Fri, 28 Jun 2019 06:45:07 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b%5]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 06:45:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: Correct OPP table according to
 latest datasheet
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mq: Correct OPP table according to
 latest datasheet
Thread-Index: AQHVLWLGEgwa/2nQ4E+GYs5uFNg8hw==
Date:   Fri, 28 Jun 2019 06:45:07 +0000
Message-ID: <VI1PR04MB505542FB866BC18A27D22B90EEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190628032800.8428-1-Anson.Huang@nxp.com>
 <VI1PR04MB50553915C0D978A8019BDC5CEEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
 <DB3PR0402MB39161C60DC780B693933F9EAF5FC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f1ae866-ddc7-44cc-c6b9-08d6fb9428a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5039;
x-ms-traffictypediagnostic: VI1PR04MB5039:
x-microsoft-antispam-prvs: <VI1PR04MB5039C882AB3613AC6E44147FEEFC0@VI1PR04MB5039.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(486006)(33656002)(446003)(99286004)(68736007)(44832011)(25786009)(9686003)(53936002)(476003)(6246003)(14454004)(4326008)(55016002)(7416002)(66066001)(229853002)(74316002)(3846002)(6116002)(2501003)(305945005)(316002)(8676002)(6436002)(81156014)(81166006)(8936002)(64756008)(54906003)(66476007)(91956017)(76116006)(256004)(73956011)(186003)(2906002)(71190400001)(71200400001)(102836004)(6506007)(76176011)(7696005)(478600001)(53546011)(66446008)(5660300002)(14444005)(86362001)(26005)(110136005)(66556008)(52536014)(66946007)(7736002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5039;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o6/b9SLGTYtpiJZj8Y0s70joOGF+K1wD3bEQqNaDf/TWjgWrMSWgjnB8TIS6JY9smV3k5BAdfqVoeUPg0VEQ6JxjBB3ok2/UvzPKxCsFHorjfiCzNHxFrH9Rx1OCBx+nDVk10AesjRi45wluqZrL4KBCXiLGsGjfRXLTUku8G/lETPLxyOCvzZ7pqGn4pC5eWbFSyNhllwuCbyGvU93ACrZHpDHVFrrVB51Nj8elZ1pNQRJ2hR+uy6FIqK5VOlwAipveR0vi7qtwwR9LVezvCfaDpiRUmyhFam2NuJrfUZDtScSBhBXQf9rDf6Vao4AtADV0FxvRpwdDIFoE/llvrJ0ZB6Olqciet8wUV9eJHPGawoGGpBEmYN9aAVHxBJQpbZfSDdmSNvDB51bCEKmBrNzUaOgUsw0eG0YH1xOVsNc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ae866-ddc7-44cc-c6b9-08d6fb9428a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 06:45:07.3730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/2019 9:16 AM, Anson Huang wrote:=0A=
>> From: Leonard Crestez=0A=
>>> From: Anson Huang <Anson.Huang@nxp.com>=0A=
>>>=0A=
>>> According to latest datasheet (Rev.1, 10/2018) from below links, in=0A=
>>> the consumer datasheet, 1.5GHz is mentioned as highest opp but depends=
=0A=
>>> on speed grading fuse, and in the industrial datasheet, 1.3GHz is=0A=
>>> mentioned as highest opp but depends on speed grading fuse. 1.5GHz and=
=0A=
>>> 1.3GHz opp use same voltage, so no need for consumer part to support=0A=
>>> 1.3GHz opp, with same voltage, CPU should run at highest frequency in=
=0A=
>>> order to go into idle as quick as possible, this can save power.=0A=
>>=0A=
>> I looked at the same datasheets and it's not clear to me that 1.3 Ghz sh=
ould=0A=
>> be disallowed for consumer parts. Power consumption increases with both=
=0A=
>> voltage and frequency so having two OPPs with same voltage does make=0A=
>> sense.=0A=
> =0A=
> The consumer part datasheet does NOT mention 1.3GHz at all, so consumer p=
art ONLY=0A=
> support 1GHz/1.5GHz, and industrial part ONLY support 800MHz/1.3GHz, this=
 is what=0A=
> we did in our internal tree and NPI release, so better to make them align=
ed, otherwise,=0A=
> we have to change it when kernel upgrade.=0A=
=0A=
Datasheet seems ambiguous: it mentions "max freq for volt" so my =0A=
understanding is that any lower freqs should also work at that voltage.=0A=
=0A=
This also seems to be the understanding behind commit 8cfd813c7307 =0A=
("arm64: dts: imx8mq: fix higher CPU operating point") by Lucas.=0A=
=0A=
On datasheet page 7 it mentions that product code can have "JZ" or "HZ" =0A=
for 1.3Ghz or 1.5Ghz. Are you saying that only industrial parts can be "JZ"=
?=0A=
=0A=
>>>    			opp-hz =3D /bits/ 64 <1500000000>;=0A=
>>>    			opp-microvolt =3D <1000000>;=0A=
>>>    			/* Consumer only but rely on speed grading */=0A=
>>> -			opp-supported-hw =3D <0x8>, <0x7>;=0A=
>>> +			opp-supported-hw =3D <0x8>, <0x3>;=0A=
>>=0A=
>> If you don't want to rely on the fact that only consumer parts should be=
=0A=
>> fused for 1.5 Ghz then please delete the comment.=0A=
> =0A=
> Don't quite understand, 1.5GHz is indeed consumer ONLY, but if the consum=
er=0A=
> part is fused to 1GHz, then 1.5GHz is also NOT available, so it also rely=
 on speed=0A=
> grading. So keep the comment there is OK?=0A=
=0A=
What I meant with that comment is that 1.5Ghz is only mentioned for =0A=
consumer parts but instead of explicitly banning it on industrial parts =0A=
we rely on MFG never fusing industrial parts for 1.5Ghz.=0A=
=0A=
Now you're explicitly banning it on industrial parts.=0A=
=0A=
This comment is indeed confusing so better to just remove all instances.=0A=
