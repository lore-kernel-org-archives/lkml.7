Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD21C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D07420857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AoGJLYEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfCSHBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:01:16 -0400
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:49886
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfCSHBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+jceISxVvo59cSfoeUUsw2oa+EOjTjSTzrvLkf21hE=;
 b=AoGJLYEO3HS3W0yfsVqYhdOR4cUWOevwgwIRCeHS9mwjL4Y00/zkts9/QAzEJF1jporO4h49nxUVQOyvLT3/ibqpl9DKK2m+W1Busqh8QOCJYlhrzi2zvxZJO+iFdMvtoLdWH5Z/4ys3h1usxQYiDMNLfjV4b3fplbA1q2M7z/M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3945.eurprd04.prod.outlook.com (52.134.65.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 07:01:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 07:01:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Topic: [PATCH V6 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Index: AQHU3iAIM+6v/EpQHU6qvziWi0cYL6YShPgAgAABfFA=
Date:   Tue, 19 Mar 2019 07:01:11 +0000
Message-ID: <DB3PR0402MB3916C788E11BB4C43B685AF5F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552977898-5590-1-git-send-email-Anson.Huang@nxp.com>
 <1552977898-5590-5-git-send-email-Anson.Huang@nxp.com>
 <20190319065434.mbadba7fi2hdncf4@pengutronix.de>
In-Reply-To: <20190319065434.mbadba7fi2hdncf4@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cad4129f-1ee5-4b7b-8f07-08d6ac38ab9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3945;
x-ms-traffictypediagnostic: DB3PR0402MB3945:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3945F9F3AF64E36708E929C4F5400@DB3PR0402MB3945.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(199004)(189003)(13464003)(99286004)(66574012)(5660300002)(3846002)(6116002)(97736004)(14454004)(2906002)(71190400001)(71200400001)(478600001)(66066001)(966005)(256004)(33656002)(106356001)(8936002)(86362001)(486006)(6506007)(44832011)(11346002)(7696005)(446003)(54906003)(53546011)(102836004)(476003)(105586002)(316002)(76176011)(186003)(26005)(229853002)(7736002)(53936002)(68736007)(52536014)(6916009)(25786009)(9686003)(6246003)(81166006)(81156014)(7416002)(55016002)(8676002)(74316002)(6306002)(4326008)(305945005)(6436002)(45080400002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3945;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2LWEOZm1T3YqcWi6/LRd7bTiY+4+wQS0HpeXpttMD03szoQHIpDzb0NSfH2Z6vsWK71kKGtpauJeLWrQt1B6x73lHSuty1xAjVKL6dfP64iVIx5RDMyyLaZwMEfH+msnwJM3cwfLdNlZQfjfImnGGt6dmb49CM7rLiGGkmMSXfEyuYq6qzrD3Cdur0D0THi9b0HksrdxLRw6eL5MvjC5SxrDkznYoDKhgtJs52UAz07hb4myhlkoxwmkJbZpop1fhF0FO7AsVIA0EB3p2wbPKqzW/pEINrKF5soH02okA3h59aBOu1yFMQdU7HHm3E6LMsf5ld+mBX5xSQNiaRUEpbgvbzAZ6iNTU6GYRZb/OQeN8Ohqfwiw+Asr3+cZAh1vKJvz98jYHkwMBCcgpKJTHgQ0MLNd27gy3SYbYtKiLKE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad4129f-1ee5-4b7b-8f07-08d6ac38ab9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 07:01:11.6418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgW21haWx0bzp1LmtsZWluZS1rb2VuaWdA
cGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IDIwMTnlubQz5pyIMTnml6UgMTQ6NTUNCj4gVG86IEFu
c29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogdGhpZXJyeS5yZWRpbmdAZ21h
aWwuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXhAYXJtbGludXgub3JnLnVrOyBzdGVm
YW5AYWduZXIuY2g7DQo+IG90YXZpb0Bvc3N5c3RlbXMuY29tLmJyOyBMZW9uYXJkIENyZXN0ZXog
PGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsNCj4gc2Nobml0emVsdG9ueUBnbWFpbC5jb207IGph
bi50dWVya0BlbXRyaW9uLmNvbTsgUm9iaW4gR29uZw0KPiA8eWliaW4uZ29uZ0BueHAuY29tPjsg
bGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjYgNC81XSBBUk06IGR0czogaW14N3VscDogQWRkIHB3bTAgc3VwcG9y
dA0KPiANCj4gT24gVHVlLCBNYXIgMTksIDIwMTkgYXQgMDY6NTA6MjZBTSArMDAwMCwgQW5zb24g
SHVhbmcgd3JvdGU6DQo+ID4gQWRkIGkuTVg3VUxQIEVWSyBib2FyZCBQV00wIHN1cHBvcnQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFY1Og0KPiA+IAktIGNoYW5nZSAjcHdtLWNlbGxz
IHRvIDMuDQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cyB8
IDEyICsrKysrKysrKysrKw0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kgICAg
fCAxMCArKysrKysrKysrDQo+IA0KPiBJTUhPIHRoZSBjaGFuZ2UgdG8gdGhlIGV2ay5kdHMgYmVs
b25ncyBpbnRvIHRoZSBsYXN0IHBhdGNoLg0KDQpBaCwgeWVzLCB0aGUgUFdNIHBpbiBzZXR0aW5n
cyBpbiBib2FyZCBkdHMgc2hvdWxkIGJlbG9uZ3MgaW50byB0aGUgYmFja2xpZ2h0IHBhdGNoLA0K
SSB3aWxsIHJlc2VuZCBWNiwgdGhhbmtzLg0KDQpBbnNvbi4NCg0KPiANCj4gQmVzdCByZWdhcmRz
DQo+IFV3ZQ0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgVXdlIEtsZWluZS1Lw7ZuaWcgICAgICAgICAgICB8DQo+IEluZHVzdHJpYWwgTGlu
dXggU29sdXRpb25zICAgICAgICAgICAgICAgICB8DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3LnANCj4gZW5ndXRy
b25peC5kZSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuY29tJTdDZTMN
Cj4gNjQ1YTZkNGQ2NjQzYTFmODBmMDhkNmFjMzdjNzI1JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNk
OTljNWMzMDE2MzUNCj4gJTdDMCU3QzAlN0M2MzY4ODU3NTI4OTcyMDg1NzImYW1wO3NkYXRhPU42
N3NtczlsWDZhc1hwWWFxJTJGdGYNCj4gVE5wTnolMkJlRElLTng4OSUyRjU3Q1lRQXdBJTNEJmFt
cDtyZXNlcnZlZD0wICB8DQo=
