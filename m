Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97197C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4422721850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZUr+/oOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfB1GSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:18:35 -0500
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:36836
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbfB1GSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NftF+fu0/rghldZCd/a9ijeGi8kiTmw7PXgPzxbMHw=;
 b=ZUr+/oOU9qKr3fKoDt89WgFWwUhD0hgDcMVMx0pYIu4j7od+xQ1xh3erM7D2iHAXmjMt5Ndd8qNJWK9p3uHzPLNl5cTSi2VpRU9JpbyXff2xJvYqDN2r0aFUs3DPdsOVtwQ0sRiAAQ/CDBpUANEXf+QtRAr08scJjfbyLuatvJc=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3719.eurprd04.prod.outlook.com (52.133.29.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 06:18:30 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 06:18:30 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V7 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUzZKTh0f7Vnjj2USCuQHnsmV9d6X0jW0AgAAx4mA=
Date:   Thu, 28 Feb 2019 06:18:30 +0000
Message-ID: <AM6PR0402MB3911278158F4980C83331B40F5750@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1551157967-30925-1-git-send-email-Anson.Huang@nxp.com>
 <20190228031832.GH26041@dragon>
In-Reply-To: <20190228031832.GH26041@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fb5a953-8595-4fca-78d6-08d69d448f17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3719;
x-ms-traffictypediagnostic: AM6PR0402MB3719:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTZQUjA0MDJNQjM3MTk7MjM6Sm5NWEpML3hFTU15Q3lIMng3eUxFYkEx?=
 =?gb2312?B?K1JRSW03WWNJL2hGVDRnbnZYRVBNTW94Sm1OS3lmWTBTOHZ2SEYyZWJQTUJU?=
 =?gb2312?B?RndnejVwaGhwZHk2NFg5U1B6VDFFcUFwQ2hzT1I1VDc5bGFCUHZNd0hnbFRp?=
 =?gb2312?B?SDZEZ1V0eENNbWQ2NHhOdUxaY244VFJnVkdCa0tCdlovb2gxWUdVUTJocjlT?=
 =?gb2312?B?SjJYdnc0UVRpOTBzbXM3S1dtVlNOVnJ6ZlNXeDAvNVdLNkQzamJhWXlKU0xK?=
 =?gb2312?B?L3NMYXExMHdjS3JYM0Q2VXd6dkh2d01nRWRCWXpJSDV3SEMzR28rVUltR3dz?=
 =?gb2312?B?SFFsTWtnd1BtUjkvbXo5NFFLeHR6bXg3MmE3NWJRNkZsNkFQdGVwbzJkRkFO?=
 =?gb2312?B?NXplQk4zK0VDdzhQd0NZWSs4dmg3b1A3ek05ZWNvSGRxTEFDa3pNMkR2L0Fh?=
 =?gb2312?B?SWJaWnJ5SjV6UWtwZ0t3R2VMdlE4TlJDQ1ZjekdMNVBBcWhlY3NPVHpKWWF1?=
 =?gb2312?B?d1I1ZjF6NUJSZGsyVHRpZmQyS2NqdlV6UnM3SzI4d09BUDhsNkkzcXNQcmo2?=
 =?gb2312?B?SXNXOENtNWdyNkgvQlJrT1Q4eEJXdGRvWmJJakp3WFBhT1haZkZ0QVFsOWk5?=
 =?gb2312?B?eU16WllWakpmZUI4YUl4WVlvUFFxSysvMTdsMFUzZlc1Z0FLekJGU0p2L2JH?=
 =?gb2312?B?NTFHYUtKR1lCcWJPRHJiNFd3VzV5VUYyQ01DSldydURsNTdOckdFOVBPWUpK?=
 =?gb2312?B?dXZlbFVFRmdnb0M0eFRKWE5IWGRUT3ZGMXVJaXVUWHZ0dTVjeE14RHlEU0tq?=
 =?gb2312?B?THBJdmhUeE04VUROcmdhWHdaT1ZMeDRJVlRaekdpVGVUNS9Ha1hyaDFSeThh?=
 =?gb2312?B?VzBBQTh3Z3NmRU1vaDJvYUN6UkdPOWgzR1VlZmtIVFhKMzZzYlh3YmV2dHh4?=
 =?gb2312?B?Z2lUUDkycFJFbW5mSWpOb01MWGJQTUxTanlPM2NkQXltZHF5eWhwS0J5UDRR?=
 =?gb2312?B?empPaDZCaVFON0d4STNuRkxYci9LaTlNTVV3SG1leHRad0hPTkhtSytlUG5Z?=
 =?gb2312?B?QTdiYmVyMXBNOHhDWG1ZTVYzdGVONmxIbEtwbFpyL2dBbi9nM1hMRkVmNEky?=
 =?gb2312?B?NSs2SDY0M0xWMzNCcFF0dkVQMHJuMUZ0dnh1cmxZcytpSGc0eFlEY0ZtaFVL?=
 =?gb2312?B?ZWh2SXluQmV5ekVzRmFpQk5wbkNScUM0Z3AzZzROSE56dmJXb2NYTE11MHRn?=
 =?gb2312?B?QnhYcmxRQUlTMEpJMCt6U1FMSHhJc2pVM3k1OUFzbXcwZVMyUGpGaGJVS0lh?=
 =?gb2312?B?U2szdUZWL1BkV0l0R2FSMjJsTXRLa1JzLzd1eVZqejEvYXhGVGtFQllwL0dY?=
 =?gb2312?B?azFaOVRQK1NUWFd4cnIyaXIrdkpCMlZEV2FqNy9zT0pSUUo1K0Q2TDFlOXRR?=
 =?gb2312?B?d0lLV0xjeU1XT1liU05QNS9oTElvQ0lmbGpmcnN5b2RIRm9nRDhvR2EzbEZ6?=
 =?gb2312?B?ZnFlbUZIbmNOb2FWaFUwbkVtMWdtc2xtUUlmK0tlMWZWQXlDUjlpVWx4VkRv?=
 =?gb2312?B?REZSUk5TYU56LzUybnEzNVpnN3NZYWNacjNDSUM4cW8yZHVhWHpVUTdZNlRJ?=
 =?gb2312?B?NDF6aWdvZUdQZ2dOd29CRXRCVDJtLzZPY1NJcFlIY2NQNXVzSXhHaGJ2TUF5?=
 =?gb2312?B?Y3U1d0puMXhVbXFjWExhWFFJTDl3QmFjcWVwT1B3cGNkNTdha1hrUzFaMlR6?=
 =?gb2312?B?OUE3SGVtRzkweWh4c0dYOWprWDJBcGNHQXdoN2VrenFDTkxaQm1rOXRheVFD?=
 =?gb2312?B?WFptUGRPeGtqbzlVOEpMbXdTMFQzSndIek1ieHNLL29SMVlnV1VxV0ZOZkFZ?=
 =?gb2312?Q?wlCtn9TubOn+x41dHzIZ0uAIiUVL7Kkpc0?=
x-microsoft-antispam-prvs: <AM6PR0402MB3719634732BDF1D7E83C59A5F5750@AM6PR0402MB3719.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(13464003)(189003)(199004)(53936002)(99286004)(7736002)(476003)(74316002)(14454004)(86362001)(305945005)(478600001)(966005)(6306002)(102836004)(7416002)(9686003)(25786009)(81166006)(45080400002)(68736007)(6506007)(11346002)(486006)(186003)(316002)(53546011)(446003)(71200400001)(55016002)(44832011)(76176011)(6436002)(66066001)(2906002)(54906003)(4326008)(7696005)(14444005)(256004)(6246003)(8676002)(81156014)(26005)(8936002)(71190400001)(229853002)(6916009)(52536013)(33656002)(5660300002)(3846002)(106356001)(97736004)(105586002)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3719;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pax9KfqirrZfTGDv/H3VjfYoskTvRZm4VaHr1ejjFVdGj6XQv/iF6HvIhMgfCsA39wOvNhDNUG59QbPQS0dn5uKsu0SdZ8U5fUZwx+engEXL6N5r4NBGnrLJ6P2rFN3aW2JqsgMf+DplK9hAnffPSQblZvuTd37NuIUBfn+KyTkpfULIKCV6gK243RUqjwXL+GoucBGoYvVzQVyyZUD3VTSrjs3PX5M1S3MH8w0M7l9EB4jKcp/1QsFInQJ5SVm/Lr7D1FiakFD8ihg9ILTyngahE1vGip3JBJTyxdw9HNrHK8yhRy+O1isJQ6jriL1fBnA+Z/2xamdsBGuwrH1o6NppkrIZVXsDgsLCGDjqNuKtnFXzvaSV7O9wphYdso/3uXpBX+E3B1kXJBcANpOedLD5QW5ie6YaUfjdkd+z8+g=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb5a953-8595-4fca-78d6-08d69d448f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 06:18:30.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIFttYWlsdG86c2hhd25ndW9Aa2VybmVs
Lm9yZ10NCj4gU2VudDogMjAxOcTqMtTCMjjI1SAxMToxOQ0KPiBUbzogQW5zb24gSHVhbmcgPGFu
c29uLmh1YW5nQG54cC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lk
QGtlcm5lbC5vcmc7IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBEYW5pZWwg
QmFsdXRhDQo+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjcgMS8y
XSBhcm02NDogZHRzOiBmcmVlc2NhbGU6IGlteDhxeHA6IGFkZCBjcHUgb3BwDQo+IHRhYmxlDQo+
IA0KPiBPbiBUdWUsIEZlYiAyNiwgMjAxOSBhdCAwNToxNzozMUFNICswMDAwLCBBbnNvbiBIdWFu
ZyB3cm90ZToNCj4gPiBBZGQgaS5NWDhRWFAgQ1BVIG9wcCB0YWJsZSB0byBzdXBwb3J0IGNwdWZy
ZXEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCj4gPiBBY2tlZC1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9y
Zz4NCj4gDQo+IFByZWZpeCAnYXJtNjQ6IGR0czogaW14OHF4cDogJyB3b3VsZCBhbHJlYWR5IGJl
IGNsZWFyIGVub3VnaC4gIEkgZHJvcHBlZA0KPiAnZnJlZXNjYWxlJyBmcm9tIHRoZXJlIGFuZCBh
cHBsaWVkIHBhdGNoLg0KPiANCj4gPiAtLS0NCj4gPiBObyBjaGFuZ2VzIHNpbmNlIFY2Lg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgfCAz
MA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+ID4gaW5kZXggNGMzZGQ5NS4uNDFiZjBjZSAxMDA2NDQN
Cj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4g
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gPiBA
QCAtMzQsNiArMzQsOSBAQA0KPiA+ICAJCQlyZWcgPSA8MHgwIDB4MD47DQo+ID4gIAkJCWVuYWJs
ZS1tZXRob2QgPSAicHNjaSI7DQo+ID4gIAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JkEzNV9MMj47
DQo+ID4gKwkJCWNsb2NrcyA9IDwmY2xrIElNWF9BMzVfQ0xLPjsNCj4gPiArCQkJb3BlcmF0aW5n
LXBvaW50cy12MiA9IDwmYTM1XzBfb3BwX3RhYmxlPjsNCj4gPiArCQkJI2Nvb2xpbmctY2VsbHMg
PSA8Mj47DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICAJCUEzNV8xOiBjcHVAMSB7DQo+ID4gQEAgLTQy
LDYgKzQ1LDkgQEANCj4gPiAgCQkJcmVnID0gPDB4MCAweDE+Ow0KPiA+ICAJCQllbmFibGUtbWV0
aG9kID0gInBzY2kiOw0KPiA+ICAJCQluZXh0LWxldmVsLWNhY2hlID0gPCZBMzVfTDI+Ow0KPiA+
ICsJCQljbG9ja3MgPSA8JmNsayBJTVhfQTM1X0NMSz47DQo+ID4gKwkJCW9wZXJhdGluZy1wb2lu
dHMtdjIgPSA8JmEzNV8wX29wcF90YWJsZT47DQo+ID4gKwkJCSNjb29saW5nLWNlbGxzID0gPDI+
Ow0KPiA+ICAJCX07DQo+ID4NCj4gPiAgCQlBMzVfMjogY3B1QDIgew0KPiA+IEBAIC01MCw2ICs1
Niw5IEBADQo+ID4gIAkJCXJlZyA9IDwweDAgMHgyPjsNCj4gPiAgCQkJZW5hYmxlLW1ldGhvZCA9
ICJwc2NpIjsNCj4gPiAgCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmQTM1X0wyPjsNCj4gPiArCQkJ
Y2xvY2tzID0gPCZjbGsgSU1YX0EzNV9DTEs+Ow0KPiA+ICsJCQlvcGVyYXRpbmctcG9pbnRzLXYy
ID0gPCZhMzVfMF9vcHBfdGFibGU+Ow0KPiA+ICsJCQkjY29vbGluZy1jZWxscyA9IDwyPjsNCj4g
PiAgCQl9Ow0KPiA+DQo+ID4gIAkJQTM1XzM6IGNwdUAzIHsNCj4gPiBAQCAtNTgsNiArNjcsOSBA
QA0KPiA+ICAJCQlyZWcgPSA8MHgwIDB4Mz47DQo+ID4gIAkJCWVuYWJsZS1tZXRob2QgPSAicHNj
aSI7DQo+ID4gIAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JkEzNV9MMj47DQo+ID4gKwkJCWNsb2Nr
cyA9IDwmY2xrIElNWF9BMzVfQ0xLPjsNCj4gPiArCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwm
YTM1XzBfb3BwX3RhYmxlPjsNCj4gPiArCQkJI2Nvb2xpbmctY2VsbHMgPSA8Mj47DQo+ID4gIAkJ
fTsNCj4gPg0KPiA+ICAJCUEzNV9MMjogbDItY2FjaGUwIHsNCj4gPiBAQCAtNjUsNiArNzcsMjQg
QEANCj4gPiAgCQl9Ow0KPiA+ICAJfTsNCj4gPg0KPiA+ICsJYTM1XzBfb3BwX3RhYmxlOiBvcHAt
dGFibGUgew0KPiANCj4gV2hhdCBkb2VzIHRoZSAnMCcgaW4gdGhlIGxhYmVsIG1lYW4/DQoNCkxv
b2tzIGxpa2UgdGhlICcwJyBpbiB0aGUgbGFiZWwgaXMgTk9UIG5lY2Vzc2FyeSwgd2UgY2FuIGp1
c3QgdXNlICdhMzVfb3BwX3RhYmxlJywNCmRvIHlvdSB3YW50IG1lIHJlc2VuZCB0aGUgcGF0Y2gg
dG8gcmVtb3ZlICcwJz8NCg0KQW5zb24uDQoNCj4gDQo+IFNoYXduDQo+IA0KPiA+ICsJCWNvbXBh
dGlibGUgPSAib3BlcmF0aW5nLXBvaW50cy12MiI7DQo+ID4gKwkJb3BwLXNoYXJlZDsNCj4gPiAr
DQo+ID4gKwkJb3BwLTkwMDAwMDAwMCB7DQo+ID4gKwkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8OTAw
MDAwMDAwPjsNCj4gPiArCQkJb3BwLW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsNCj4gPiArCQkJY2xv
Y2stbGF0ZW5jeS1ucyA9IDwxNTAwMDA+Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCW9wcC0x
MjAwMDAwMDAwIHsNCj4gPiArCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDwxMjAwMDAwMDAwPjsNCj4g
PiArCQkJb3BwLW1pY3Jvdm9sdCA9IDwxMTAwMDAwPjsNCj4gPiArCQkJY2xvY2stbGF0ZW5jeS1u
cyA9IDwxNTAwMDA+Ow0KPiA+ICsJCQlvcHAtc3VzcGVuZDsNCj4gPiArCQl9Ow0KPiA+ICsJfTsN
Cj4gPiArDQo+ID4gIAlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQDUxYTAwMDAwIHsNCj4gPiAg
CQljb21wYXRpYmxlID0gImFybSxnaWMtdjMiOw0KPiA+ICAJCXJlZyA9IDwweDAgMHg1MWEwMDAw
MCAwIDB4MTAwMDA+LCAvKiBHSUMgRGlzdCAqLw0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0KPiA+
DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g
PiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmxpc3QNCj4gPiBzLmluZnJhZGVhZC5vcmcl
MkZtYWlsbWFuJTJGbGlzdGluZm8lMkZsaW51eC1hcm0tDQo+IGtlcm5lbCZhbXA7ZGF0YT0wMiU3
Qw0KPiA+DQo+IDAxJTdDYW5zb24uaHVhbmclNDBueHAuY29tJTdDZmU0ZmY5MmE2MzllNDczOWMy
YTEwOGQ2OWQyYjhlMTIlNw0KPiBDNjg2ZWExDQo+ID4NCj4gZDNiYzJiNGM2ZmE5MmNkOTljNWMz
MDE2MzUlN0MwJTdDMCU3QzYzNjg2OTIwNzcyODM5ODgwOCZhbXA7c2QNCj4gYXRhPW96JTINCj4g
PiBGUHlBa2k2ZmtmUVpxYVNZa2pXZm8zbThTNDhzQ3pwRGYybHhESWpLcyUzRCZhbXA7cmVzZXJ2
ZWQ9MA0K
