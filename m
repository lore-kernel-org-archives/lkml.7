Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBBA208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Yf1Fbl1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfDXIML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:12:11 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:12790 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfDXIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:12:10 -0400
X-IronPort-AV: E=Sophos;i="5.60,389,1549954800"; 
   d="scan'208";a="28023134"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Apr 2019 01:12:09 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 24 Apr 2019 01:12:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWp4Cd8bNRiuRa5BnniCrXuRxf2i8wdyKy0GG+LjAAg=;
 b=Yf1Fbl1DkDvvL7mQAwsN7Mj1MZuX+GM0n+MfS1fyXYendDFE1qRiy5NNSZpSDG6OridNAOamA/cX8OIfD9pGvUOLdYPOv7EFYMiif7o/NhCeS7iU762ssAmJEv/L8Xn6uox/lfbzYHMRpuKkpDP0e5EjieKBcraRQpzbmyQrmy0=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1488.namprd11.prod.outlook.com (10.172.53.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.18; Wed, 24 Apr 2019 08:12:05 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 08:12:05 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60
 HLCDC's PWM
Thread-Topic: [PATCH v2 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60
 HLCDC's PWM
Thread-Index: AQHU0ztO/XA/ucaOTEyHzcBvHIJYz6ZLREmA
Date:   Wed, 24 Apr 2019 08:12:05 +0000
Message-ID: <bf1cc1b6-3995-320f-90d3-2926ea8a083b@microchip.com>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
 <1551780434-4580-6-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551780434-4580-6-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::24) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190424111153001
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5b45180-ccae-485f-fe7d-08d6c88c8954
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1488;
x-ms-traffictypediagnostic: MWHPR11MB1488:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR11MB1488F05E1FE8C6E366D304ED873C0@MWHPR11MB1488.namprd11.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(39860400002)(346002)(189003)(199004)(386003)(6506007)(66476007)(110136005)(6116002)(76176011)(6436002)(54906003)(97736004)(2501003)(53546011)(3846002)(316002)(5660300002)(52116002)(99286004)(256004)(2906002)(81156014)(66066001)(8676002)(36756003)(8936002)(81166006)(68736007)(64756008)(476003)(71190400001)(71200400001)(6486002)(2616005)(478600001)(229853002)(66556008)(6306002)(31686004)(4326008)(53936002)(11346002)(6512007)(86362001)(6246003)(66446008)(14454004)(966005)(31696002)(7736002)(305945005)(186003)(2201001)(7416002)(26005)(446003)(486006)(72206003)(102836004)(73956011)(25786009)(66946007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1488;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1RTSXnlu6mQbkPgVEsfHtjm+4eef4PCkov0UjK/d1vrcQ7v9GLdbXJn4Y0HsvQYI6AmIrqm9xHtAmqBXkJSenLwZDiax9nt8QFGU11KKlXwNIbQ60B0gPogLWdUh0lGercyEND43oaKkkwUBPcO+atPwZ2sxX3oRZz4WN6YDSu5HhT2THjc1PR/KaXMmHF8Kqwn8aliLQt36C4HJDY483uBUs2fDK4zlrMpCoiM8CYLfnP78ZSvBEwmOjDDacaq4Ytv6vvHyJ2eaUhCQDNbcgkXo5Yo/s/76NYUXV/lWmItiMUZXb20I4OGQwjbRXg1UwGKqyjeDRVZaeHz5R2uz+1m4Ld6NWnE/nK0MEBcd0UMidlD1aVig1u/h4xjc4e3UdjtkwTXkiWc8WmoYKreP+PDCY6Nr7uzBE32Si6FS4Ss=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAF77C294939664386CB14FD33AA7BA1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b45180-ccae-485f-fe7d-08d6c88c8954
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 08:12:05.3096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1488
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlLA0KDQpPbiB2MSBvZiB0aGlzIHNlcmllcyBUaGllcnJ5IHN1Z2dlc3RlZCB0aGF0IHRo
aXMgcGF0Y2ggd291bGQgYmUgZ29vZCB0bw0KYWxzbyBnbyB0aHJvdWdoIE1GRCB0cmVlLiBXb3Vs
ZCB5b3UgYmUgYWJsZSB0byBhbHNvIHBpY2sgdGhpcyBwYXRjaD8NCg0KQmVsbG93IGlzIGhpcyBj
b21tZW50IG9uIHYxIHZlcnNpb24gb2YgdGhpcyBwYXRjaDoNCmh0dHBzOi8vcGF0Y2h3b3JrLm96
bGFicy5vcmcvcGF0Y2gvMTA0OTAwNi8NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0K
T24gMDUuMDMuMjAxOSAxMjowNywgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IEZy
b206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiANCj4g
QWRkIGNvbXBhdGlibGUgc3RyaW5nIGZvciBTQU05WDYwIEhMQ0RDJ3MgUFdNLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
DQo+IEFja2VkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jIHwgMyArKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3
bS9wd20tYXRtZWwtaGxjZGMuYyBiL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jDQo+IGlu
ZGV4IDU0YzY2MzNkOWI1ZC4uMzMxY2EwMjMzZDllIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3B3
bS9wd20tYXRtZWwtaGxjZGMuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMu
Yw0KPiBAQCAtMjQ2LDYgKzI0Niw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IGF0bWVsX2hsY2RjX2R0X2lkc1tdID0gew0KPiAgCQkuY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1h
NWQ0LWhsY2RjIiwNCj4gIAkJLmRhdGEgPSAmYXRtZWxfaGxjZGNfcHdtX3NhbWE1ZDNfZXJyYXRh
LA0KPiAgCX0sDQo+ICsJew0KPiArCQkuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1o
bGNkYyIsDQo+ICsJfSwNCj4gIAl7IC8qIHNlbnRpbmVsICovIH0sDQo+ICB9Ow0KPiAgTU9EVUxF
X0RFVklDRV9UQUJMRShvZiwgYXRtZWxfaGxjZGNfZHRfaWRzKTsNCj4gDQo=
