Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B34C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAE9213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="cI0PY1t9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfDAIlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:41:21 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:12817 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfDAIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:41:21 -0400
X-IronPort-AV: E=Sophos;i="5.60,295,1549954800"; 
   d="scan'208";a="27404551"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 01 Apr 2019 01:41:21 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 1 Apr 2019 01:41:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhMbDXXOSJvwLglCxxecomFGzIk0ACEaHaShL5u/NWQ=;
 b=cI0PY1t9ZVBOGFgh8PZ9IqfhtGIb6YtrlSAd3PRCWifOQA6l1hWlSskhMvJKGTAN8t/xfyZ53MJ0Hr3wbjkgLwz8w3G2u1M7hdBpONI7iC+qXpW5UKFlGjgEaDbPMCWc3x1Jiszb5GBS4fETbOm2Lwb4MyIOtth3nW3fNHn//lM=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1615.namprd11.prod.outlook.com (10.172.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 08:41:17 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6%2]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 08:41:17 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] MAINTAINERS: change section name to be more generic
Thread-Topic: [PATCH 3/5] MAINTAINERS: change section name to be more generic
Thread-Index: AQHU6GaszgVz3A2Y1k6jI7C5e8ZrYw==
Date:   Mon, 1 Apr 2019 08:41:17 +0000
Message-ID: <2bdad4f2-5c2c-a45c-b25d-a8c52ced7d50@microchip.com>
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-4-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1552580772-8499-4-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0265.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::13) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cbe93d8-f658-4e97-c54f-08d6b67dceb0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1615;
x-ms-traffictypediagnostic: MWHPR11MB1615:
x-microsoft-antispam-prvs: <MWHPR11MB161549527872E6566C1B464AE0550@MWHPR11MB1615.namprd11.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(136003)(366004)(199004)(189003)(386003)(53936002)(6512007)(110136005)(52116002)(72206003)(106356001)(4744005)(54906003)(2616005)(81156014)(31696002)(2906002)(6486002)(478600001)(14444005)(71200400001)(36756003)(31686004)(305945005)(76176011)(229853002)(25786009)(8676002)(6246003)(8936002)(7736002)(256004)(71190400001)(81166006)(99286004)(2201001)(476003)(446003)(2501003)(68736007)(11346002)(6436002)(5660300002)(4326008)(186003)(14454004)(6506007)(97736004)(26005)(6116002)(316002)(3846002)(486006)(53546011)(86362001)(102836004)(66066001)(105586002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1615;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dI341+2ez1DgRelKPN1aoEQqRnJ6yHJV/12ydnom1aMYaVxHrS40ysBIM1zDqQZKLtvjHiiaEYVVwANjR1ZhVSs8Zxsj9j4ie0qpCafZ0hOuutRLyLK8F1bplsku1oclBdN9i3PRDFbd9SfXSOLcdwjkM/bYm6+FxaIcgL8S2vC+sT6h5JynHxcEZY6EvApxMKUXLHgd6e7fTNE5hk+VsbJDJUh7vdqfmrxuS96MvRSayN1TnITW/EIadro5MlDWWEeZhM4wXKp2EEHw5QPWzGCeC+SAKyoZ2aM6NRT9mjPDl2tS0qJgBtjXDNJ4w3xkma/JgneMvE5ix/UhfZJ5yDoJzavC8UV0He+Vo6Jp140E63IxW2Lw62BvzGcqZT7Bku/Bc+xX68CCKx23Ejw4BcLvZSRAvchRd9WKP1uoo94=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFA5E439A7D2E94DB620201AA552390B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbe93d8-f658-4e97-c54f-08d6b67dceb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 08:41:17.9326
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
Cj4gQ2hhbmdlIE1pY3JvY2hpcCB0aW1lcnMgc2VjdGlvbiBuYW1lIHRvIGJlIG1vcmUgZ2VuZXJp
Yy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBt
aWNyb2NoaXAuY29tPg0KDQpBY2tlZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBt
aWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgIE1BSU5UQUlORVJTIHwgMiArLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggNGQwNGNlYmI0YTcxLi4wOTQ4
ZDY1OTJlYTUgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJT
DQo+IEBAIC0xMDAxNiw3ICsxMDAxNiw3IEBAIFM6CVN1cHBvcnRlZA0KPiAgIEY6CWRyaXZlcnMv
bWlzYy9hdG1lbC1zc2MuYw0KPiAgIEY6CWluY2x1ZGUvbGludXgvYXRtZWwtc3NjLmgNCj4gICAN
Cj4gLU1JQ1JPQ0hJUCBUSU1FUiBDT1VOVEVSIChUQykgQU5EIENMT0NLU09VUkNFIERSSVZFUlMN
Cj4gK01JQ1JPQ0hJUCBUSU1FUlMgQU5EIENMT0NLU09VUkNFIERSSVZFUlMNCj4gICBNOglOaWNv
bGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+ICAgTDoJbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVy
cykNCj4gICBTOglTdXBwb3J0ZWQNCj4gDQoNCg0KLS0gDQpOaWNvbGFzIEZlcnJlDQo=
