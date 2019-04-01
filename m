Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25201C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3AB2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y/MaX4wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDAIlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:41:47 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:10459 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfDAIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:41:46 -0400
X-IronPort-AV: E=Sophos;i="5.60,295,1549954800"; 
   d="scan'208";a="28994582"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Apr 2019 01:41:45 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 1 Apr 2019 01:41:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acBnsVyWCQn3QF5Tc5qq6EIZar/UPr+r0G6Qvk8k0AQ=;
 b=Y/MaX4wblssgoQ9ot+/MyBIZpOYpVJBHycZQNgbCXMMObE3eBLzXKfjf0xYoE3sF1jJisygGWOLKu1z5WN74PXCKfsjvTvHfxwwJZN3PvoNBajoBMmQDFIRC+hjTzKClZaB0/v3qCmi+2Yp13YL8fE67teZpwnQQ768b7iY8uho=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1615.namprd11.prod.outlook.com (10.172.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 08:41:42 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6%2]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 08:41:42 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] MAINTAINERS: add myself as maintainer
Thread-Topic: [PATCH 4/5] MAINTAINERS: add myself as maintainer
Thread-Index: AQHU6Ga7LUaF4DJvmk+TPkiND6+IFA==
Date:   Mon, 1 Apr 2019 08:41:42 +0000
Message-ID: <659d6568-73fc-ef1c-2b67-65193d0d72e1@microchip.com>
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-5-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1552580772-8499-5-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0286.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::34) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9e782e3-14f9-432c-3f07-08d6b67ddd7a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1615;
x-ms-traffictypediagnostic: MWHPR11MB1615:
x-microsoft-antispam-prvs: <MWHPR11MB1615DB9EEC55E75CC8E993BBE0550@MWHPR11MB1615.namprd11.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(136003)(366004)(199004)(189003)(386003)(53936002)(6512007)(110136005)(52116002)(72206003)(106356001)(4744005)(54906003)(2616005)(81156014)(31696002)(2906002)(6486002)(478600001)(71200400001)(36756003)(31686004)(305945005)(76176011)(229853002)(25786009)(8676002)(6246003)(8936002)(7736002)(256004)(71190400001)(81166006)(99286004)(2201001)(476003)(446003)(2501003)(68736007)(11346002)(6436002)(5660300002)(4326008)(186003)(14454004)(6506007)(97736004)(26005)(6116002)(316002)(3846002)(486006)(53546011)(86362001)(102836004)(66066001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1615;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J4CndWs4i/U5fZmldF8891kJKElUv1oamRY+Hzd3LKebjYZegQzgQuie4Fe1SaW3UTImkbvxUV4Qc99/93VsUZxtgLhiXWb2nZzp+AKxx2xFy39ni3+UCRbbRXjDecxHyGjSn5BNCNG2VYXSFc1ovaL/Zrxa4qsb1nqpKrlmBjuanJ3niBtjnjj3UsLl3b7fksoD9LEP5Z3DgXCKVfx8WtVModP5OUJMpH1dswg/n08o/QTytr2x053zjDM+2Clk6G/eLg+gTUVB5b8P4xO/EJceCjBxikO0f0EacBRt1M2/8SDqDbXTxuLsk0tFU9SGCMQ5RKKh8iMFd8CCTvFkUuumpe1gqXlT5fLNjenFP4R65zQ3aloGzt1TgEXBQUDd+uByZFW462JGHjhvB+nSlqaD3lFNnGGDaGciaGfzVQs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88AB4AE1932BF040AAC3F4BCA17A5DAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e782e3-14f9-432c-3f07-08d6b67ddd7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 08:41:42.5640
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
Cj4gQWRkIG15c2VsZiBhcyBtYWludGFpbmVyIGZvciBNaWNyb2NoaXAgdGltZXJzIGFuZCBjbG9j
a3NvdXJjZQ0KPiBkcml2ZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFja2VkLWJ5OiBOaWNvbGFzIEZlcnJl
IDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQoNClRoYW5rcyBDbGF1ZGl1IQ0KDQo+IC0t
LQ0KPiAgIE1BSU5UQUlORVJTIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRl
eCAwOTQ4ZDY1OTJlYTUuLjg1YmM4MTk4NjdkYSAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMN
Cj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTEwMDE4LDYgKzEwMDE4LDcgQEAgRjoJaW5jbHVk
ZS9saW51eC9hdG1lbC1zc2MuaA0KPiAgIA0KPiAgIE1JQ1JPQ0hJUCBUSU1FUlMgQU5EIENMT0NL
U09VUkNFIERSSVZFUlMNCj4gICBNOglOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3Jv
Y2hpcC5jb20+DQo+ICtNOglDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCj4gICBMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVy
YXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQ0KPiAgIFM6CVN1cHBvcnRlZA0KPiAgIEY6CWRyaXZl
cnMvbWlzYy9hdG1lbF90Y2xpYi5jDQo+IA0KDQoNCi0tIA0KTmljb2xhcyBGZXJyZQ0K
