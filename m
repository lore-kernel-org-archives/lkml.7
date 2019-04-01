Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685B0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB64213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="K1jiaBAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfDAIlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:41:06 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:4297 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfDAIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:41:05 -0400
X-IronPort-AV: E=Sophos;i="5.60,295,1549954800"; 
   d="scan'208";a="29223602"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Apr 2019 01:41:04 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 1 Apr 2019 01:41:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96hXELbudW2ZYiEAh3Z8loYR6cepKYqbnbk8irGHsNo=;
 b=K1jiaBAjfB652GCy2YBsK4JOt3NFapD6NnkdRWXE+KcFtr31P1qGY8imm9Qb+iDawPeAO65ewS4Xf4kIYJb44UrL+2StuiUCAjO8zTgk2gAFXXfeJeHYjdCzR1vZOp/VOPfOewPIsLMlO0n5Af1/zuV0NXE7SvIGzeKtGeomHeU=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1615.namprd11.prod.outlook.com (10.172.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 08:41:02 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6%2]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 08:41:02 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: arm: atmel: add bindings for PIT64B
Thread-Topic: [PATCH 1/5] dt-bindings: arm: atmel: add bindings for PIT64B
Thread-Index: AQHU6Gaez/LorvXdEkqU3mnG6JPalg==
Date:   Mon, 1 Apr 2019 08:41:02 +0000
Message-ID: <02142a4f-9b72-ea49-4026-08a1ca02e217@microchip.com>
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-2-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1552580772-8499-2-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::17) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85a8d5db-9dbe-44d3-4e29-08d6b67dc566
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1615;
x-ms-traffictypediagnostic: MWHPR11MB1615:
x-microsoft-antispam-prvs: <MWHPR11MB16158B7CBADB959CEC247984E0550@MWHPR11MB1615.namprd11.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(136003)(366004)(199004)(189003)(386003)(53936002)(6512007)(110136005)(52116002)(72206003)(106356001)(54906003)(2616005)(81156014)(31696002)(2906002)(6486002)(478600001)(71200400001)(36756003)(31686004)(305945005)(76176011)(229853002)(25786009)(8676002)(6246003)(8936002)(7736002)(256004)(71190400001)(81166006)(99286004)(2201001)(476003)(446003)(2501003)(68736007)(11346002)(6436002)(5660300002)(4326008)(186003)(14454004)(6506007)(97736004)(26005)(6116002)(316002)(3846002)(486006)(53546011)(86362001)(102836004)(66066001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1615;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yJfW1Y9HeaeuzrPjAIxfE8qKFjL/VP+XoYndXlnGf9edSVuuKYh3G1vUdNwS0tHRyNTYejAS1SD/g9PDhILGE5VQelyGcQqojDUw3UaBfFzyzHr70MNFUPmpnyB8CDj8oIvl1I8L+eiI7X4KPIdv9JhPNC6Ei3OJgOsreLAursWjOAf2kQXEYOIEuwUAvEhs/2H2J6rjsH4HFPSSnqW8oEBmbuzlUiZAd/bihLOCDNTQv0yHx3hwK/SNqDBH/EMmdMZUWLF3zdpHbA6VVPBKpaCzwSqVScjRbzNUSiG3DoIynf8HN8a7KpM4erkCdArq/H/5ai1h8HMcyKpeP5T64d2YhC8XR6qpr0/7xF/fjr996v0u9lilZ5guR2l/ltaeM8MTiuW6MmaNDIx/+wcvDYhexfUWDYqQVVd4cUs9eqs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6012ACEF50BC8F45A8F1CAF6D3901922@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a8d5db-9dbe-44d3-4e29-08d6b67dc566
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 08:41:02.4412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1615
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDMvMjAxOSBhdCAxNzoyNiwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+
IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gQWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciBQSVQ2NEIgdGltZXIuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4N
Cg0KQWNrZWQtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4N
Cg0KPiAtLS0NCj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVs
LXN5c3JlZ3MudHh0IHwgNyArKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vYXRtZWwtc3lzcmVncy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0DQo+IGluZGV4IDE0ZjMxOWY2OTRiNy4uYzdiN2VhZDc5
NjZiIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2F0bWVsLXN5c3JlZ3MudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQNCj4gQEAgLTEwLDYgKzEwLDEzIEBAIFBJVCBUaW1l
ciByZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgIC0gaW50ZXJydXB0czogU2hvdWxkIGNvbnRhaW4g
aW50ZXJydXB0IGZvciB0aGUgUElUIHdoaWNoIGlzIHRoZSBJUlEgbGluZQ0KPiAgICAgc2hhcmVk
IGFjcm9zcyBhbGwgU3lzdGVtIENvbnRyb2xsZXIgbWVtYmVycy4NCj4gICANCj4gK1BJVDY0QiBU
aW1lciByZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiArLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgIm1p
Y3JvY2hpcCxzYW05eDYwLXBpdDY0YiINCj4gKy0gcmVnOiBTaG91bGQgY29udGFpbiByZWdpc3Rl
cnMgbG9jYXRpb24gYW5kIGxlbmd0aA0KPiArLSBjbG9jay1mcmVxdWVuY3k6IFNob3VsZCBjb250
YWluIFBJVDY0QiB0aW1lciBmcmVxdWVuY3kNCj4gKy0gaW50ZXJydXB0czogU2hvdWxkIGNvbnRh
aW4gaW50ZXJydXB0IGZvciBQSVQ2NEIgdGltZXINCj4gKy0gY2xvY2tzOiBTaG91bGQgY29udGFp
biB0aGUgYXZhaWxhYmxlIGNsb2NrIHNvdXJjZXMgZm9yIFBJVDY0QiB0aW1lci4NCj4gKw0KPiAg
IFN5c3RlbSBUaW1lciAoU1QpIHJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAgLSBjb21wYXRpYmxl
OiBTaG91bGQgYmUgImF0bWVsLGF0OTFybTkyMDAtc3QiLCAic3lzY29uIiwgInNpbXBsZS1tZmQi
DQo+ICAgLSByZWc6IFNob3VsZCBjb250YWluIHJlZ2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3Ro
DQo+IA0KDQoNCi0tIA0KTmljb2xhcyBGZXJyZQ0K
