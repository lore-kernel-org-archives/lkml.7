Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA17C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD3A2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y1//RZ2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbfDRGVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:21:24 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:29668 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDRGVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:21:23 -0400
X-IronPort-AV: E=Sophos;i="5.60,364,1549954800"; 
   d="scan'208";a="30368322"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Apr 2019 23:21:22 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 17 Apr 2019 23:21:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcSX3OggfMM7YnTJty2/9uqI9aoAGnqfjtxL+rdtdbg=;
 b=Y1//RZ2O/jLs84Nx/oO3UTaNjw6r6neEIVCv0VQRl1KWTc7yFHdpbw+FMKd3C6eZaXksYU/isxBYODHEq5aVVTUFXwDEjXzVH9LoG0SlNMqYtsvT1ynxH8lLpILitMmUgZbxfp8GoRG6NQ75b/nF2ZbgQVEeSPk9CbS13jfzSFA=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0027.namprd11.prod.outlook.com (10.164.155.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 06:21:19 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 06:21:19 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <colin.king@canonical.com>, <mchehab@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hverkuil@xs4all.nl>
Subject: Re: [PATCH] media: atmel-isc: fix spelling mistake "profie" ->
 "profile"
Thread-Topic: [PATCH] media: atmel-isc: fix spelling mistake "profie" ->
 "profile"
Thread-Index: AQHU9TuzmexTaj5QpEm+t0u0YyYrxaZBciWA
Date:   Thu, 18 Apr 2019 06:21:19 +0000
Message-ID: <ecaa2038-3df6-8fbe-ad7e-b8472c4fb32a@microchip.com>
References: <20190417163425.12826-1-colin.king@canonical.com>
In-Reply-To: <20190417163425.12826-1-colin.king@canonical.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0182.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::12) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190418091649182
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08f19c76-2cfa-4ca9-6597-08d6c3c61209
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR11MB0027;
x-ms-traffictypediagnostic: DM5PR11MB0027:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM5PR11MB0027367442E958D50E4009BFE8260@DM5PR11MB0027.namprd11.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(2616005)(81166006)(8936002)(81156014)(6436002)(2501003)(26005)(305945005)(52116002)(186003)(6512007)(76176011)(2906002)(6306002)(7736002)(102836004)(3846002)(68736007)(5660300002)(229853002)(6246003)(72206003)(66066001)(6506007)(53546011)(6116002)(36756003)(25786009)(53936002)(110136005)(4326008)(386003)(54906003)(6486002)(2201001)(966005)(316002)(31696002)(71200400001)(256004)(14444005)(86362001)(11346002)(31686004)(71190400001)(478600001)(99286004)(97736004)(446003)(486006)(14454004)(8676002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0027;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sJ3Bfcmnjw87zgnRO/FPSvgZrCXkGL5xMgR0I5hqPpG685ByxO11IV3FMqXwoCsdGiBF6rNBY0OP7XvjOhNnf7A5KtFqB4ZfAwLsm3MEsRt38kXx3DDn9q1iKs87qY1v2gNAsH/aQ+WdP3/jOG2dJlcYtD1V+vaDa3F3760mSUS0HINkOyPzlkO4zfwxKDsbbWhGMRgY1PX022i9k1FleQ5ZhBeODC2+bz2nS0SLdQd5Fv4/r/1GX4jEIsU7DeqaOfs52xa0/X/BKxxOzns8Y5da8T1fVWbgkyHSZ+NOVamlHwZ4Yqz0Oin+iXiykWXwtR/Zb/3SRkOm+p5SJouYUBRGmCoMMdni2AxUld1NM3NgyLV/VYNq57Tvx8hDAjn90nkUfIXVybWyt1p/jieTCWtm1+nocj41Hphm6z17Fec=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6808ECBF251B040B4FB04D2DA3C2BA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f19c76-2cfa-4ca9-6597-08d6c3c61209
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 06:21:19.8284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0027
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaCBidXQgSSB0aGluayB0aGlzIGNvbmZs
aWN0cyB3aXRoIG15IHByZXZpb3VzIHBhdGNoIA0Kd2hpY2ggYWxyZWFkeSBjaGFuZ2VzIHRoaXMg
dHlwbzoNCg0KaHR0cHM6Ly9naXQubGludXh0di5vcmcvaHZlcmt1aWwvbWVkaWFfdHJlZS5naXQv
Y29tbWl0Lz9oPWZvci12NS4yYiZpZD1mNDliMzk3NDY0Mjk5MWZmZTNmNzI4YzUzMWI4ODgxNDE5
ZGY2M2EwDQoNCnBhdGNod29yazoNCmh0dHBzOi8vcGF0Y2h3b3JrLmxpbnV4dHYub3JnL3BhdGNo
LzU1MzE4Lw0KDQpOb3QgeWV0IG1lcmdlZCBpbnRvIG1lZGlhX3RyZWUgYnV0IG9uIGl0J3Mgd2F5
IEkgYmVsaWV2ZS4uLg0KDQpFdWdlbg0KDQpPbiAxNy4wNC4yMDE5IDE5OjM0LCBDb2xpbiBLaW5n
IHdyb3RlOg0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29t
Pg0KPiANCj4gVGhlcmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIGEgdjRsMl93YXJuIHdhcm5p
bmcgbWVzc2FnZS4gRml4IGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcg
PGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hdG1lbC9hdG1lbC1pc2MuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1l
bC9hdG1lbC1pc2MuYw0KPiBpbmRleCA5YTM5OWFhN2NhOTIuLmUzY2ZjZTA1ZDZiNiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MuYw0KPiArKysg
Yi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jDQo+IEBAIC0xMDExLDcg
KzEwMTEsNyBAQCBzdGF0aWMgaW50IGlzY191cGRhdGVfcHJvZmlsZShzdHJ1Y3QgaXNjX2Rldmlj
ZSAqaXNjKQ0KPiAgIAl9DQo+ICAgDQo+ICAgCWlmIChjb3VudGVyIDwgMCkgew0KPiAtCQl2NGwy
X3dhcm4oJmlzYy0+djRsMl9kZXYsICJUaW1lIG91dCB0byB1cGRhdGUgcHJvZmllXG4iKTsNCj4g
KwkJdjRsMl93YXJuKCZpc2MtPnY0bDJfZGV2LCAiVGltZSBvdXQgdG8gdXBkYXRlIHByb2ZpbGVc
biIpOw0KPiAgIAkJcmV0dXJuIC1FVElNRURPVVQ7DQo+ICAgCX0NCj4gICANCj4gDQo=
