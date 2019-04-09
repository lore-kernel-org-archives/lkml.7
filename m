Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2707C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749AD20818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jv0RTWKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfDIGoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:44:38 -0400
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:59278
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfDIGoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BTrXYhsaRJrDTDjMSQU3E8yfltAjQGUiz2wxFnED/0=;
 b=Jv0RTWKU/G1C9+0LGlwedyCpw9r/hwdpqLY8XGgaF/0p0/5steaHaOX0sqj4T6Xiw09RIRzcSYrffNt30qXSC+I0/AUKx3yybb3cVfvN2moHqsONabNUoXEJ+Fgom7VnoVTr1pHEqW43dK4WCrz/wvQ8RIAZK9dt3K4kS8Y+ui8=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1SPR01MB0371.eurprd04.prod.outlook.com (20.178.125.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 06:44:33 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::940a:dc67:926:e5df]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::940a:dc67:926:e5df%5]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 06:44:33 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andy Tang <andy.tang@nxp.com>,
        Jianchao Wang <jianchao.wang@nxp.com>
Subject: RE: [EXT] Re: [v7 3/3] ahci: qoriq: add lx2160 platforms support
Thread-Topic: [EXT] Re: [v7 3/3] ahci: qoriq: add lx2160 platforms support
Thread-Index: AQHU2HbclXKnAjThkU+5mzIwr26m+6YyLTYQgABfEACAAQGBYA==
Date:   Tue, 9 Apr 2019 06:44:33 +0000
Message-ID: <VI1PR04MB4431213C02A7DC614AB4E693ED2D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190312015019.30628-1-peng.ma@nxp.com>
 <20190312015019.30628-3-peng.ma@nxp.com>
 <VI1PR04MB44310DDDF2D981F0BC0D7381ED2C0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <5bbd312c-6443-ea23-2b3e-97fd46a98a38@kernel.dk>
In-Reply-To: <5bbd312c-6443-ea23-2b3e-97fd46a98a38@kernel.dk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44076b43-115d-42d2-d3eb-08d6bcb6d335
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1SPR01MB0371;
x-ms-traffictypediagnostic: VI1SPR01MB0371:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <VI1SPR01MB0371CE687C2F406B8F6820FCED2D0@VI1SPR01MB0371.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(13464003)(189003)(199004)(7696005)(54906003)(55016002)(76176011)(6246003)(316002)(110136005)(9686003)(6506007)(71200400001)(52536014)(74316002)(4326008)(71190400001)(5660300002)(105586002)(305945005)(7736002)(2501003)(966005)(99286004)(106356001)(6306002)(478600001)(81166006)(66066001)(81156014)(86362001)(45080400002)(6636002)(2906002)(476003)(68736007)(44832011)(25786009)(8676002)(8936002)(14454004)(6436002)(53936002)(446003)(11346002)(33656002)(14444005)(5024004)(102836004)(186003)(97736004)(229853002)(256004)(93886005)(26005)(3846002)(486006)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB0371;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gf6EHtqLobyKOZSX8yk7yHD4Yd5CnWg85VMkV4lCnro0f03fe2LeVv+RIdLThha/b7aMEUeMuadOteZS3HhV1HKqG2m0RAJYASbv+3laDayH9Zcyj3P5GdrNVZjsLNUqEue6MevaiyGbK8b9UgeBI9J/hG3kub0OiJ726qcczbqbfLjRZYhGODZR34jU4gRohn1dwNCR01fOx/9vmt263oH2V6+v5ueN/vHZMyBezZqU/TeMpdBWr8wMUs3ZiQgUm1QNlau4UGCiy2HonNRFiMonpYV9LVOoeghp1dF/2GVPbJ1/P6DX6Bn4IYVN6VhoCkymJsuEXjnkGFAxG47qBhbRj5ZHKjuamT2/LdzWgJ6Ymf/q944xx/hjPw8cJRrSadcTCMjsN6DrrwtenZtVMni6Zez86Mq587w+ogi+UTw=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44076b43-115d-42d2-d3eb-08d6bcb6d335
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 06:44:33.1272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB0371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXhib2UsDQoNClBhdGNoIGxpbms6DQoNCmh0dHA6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
YXRjaC8xMDU1MDI4Lw0KDQpodHRwOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMTA1NDE4
OS8NCg0KQmVzdCBSZWdhcmRzLA0KUGVuZw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj5Gcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+U2VudDogMjAxOcTqNNTCOMjV
IDIzOjIxDQo+VG86IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9y
ZzsNCj5tYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpIDxs
ZW95YW5nLmxpQG54cC5jb20+DQo+Q2M6IGxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgQW5keSBUYW5nDQo+PGFuZHkudGFu
Z0BueHAuY29tPg0KPlN1YmplY3Q6IFtFWFRdIFJlOiBbdjcgMy8zXSBhaGNpOiBxb3JpcTogYWRk
IGx4MjE2MCBwbGF0Zm9ybXMgc3VwcG9ydA0KPg0KPldBUk5JTkc6IFRoaXMgZW1haWwgd2FzIGNy
ZWF0ZWQgb3V0c2lkZSBvZiBOWFAuIERPIE5PVCBDTElDSyBsaW5rcyBvcg0KPmF0dGFjaG1lbnRz
IHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4NCj4NCj4NCj5PbiA0LzgvMTkgNDowNiBBTSwgUGVuZyBNYSB3cm90ZToNCj4+IEhp
IGF4Ym9lLA0KPj4NCj4+IElmIHlvdSBoYXZlIG5vIGNvbW1lbnRzIG9uIHRoZXNlIHBhdGhzLCBw
bGVhc2UgbWVyZ2UuDQo+PiBUaGFuayB5b3UgdmVyeSBtdWNoLg0KPj4gUGF0Y2ggbGluazoNCj4+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
JTNBJTJGJTJGcGF0Y2gNCj4+DQo+d29yay5vemxhYnMub3JnJTJGcGF0Y2glMkYxMDU1MDI4JTJG
JmFtcDtkYXRhPTAyJTdDMDElN0NwZW5nLm1hDQo+JTQwbnhwLg0KPj4NCj5jb20lN0M0MGU4NTk2
NzY2MDY0MzFjZTg0OTA4ZDZiYzM1YmYzZCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDkNCj45YzVj
MzAxDQo+Pg0KPjYzNSU3QzAlN0MxJTdDNjM2OTAzMzM2MzY0MTA5MzIyJmFtcDtzZGF0YT1ROHZF
bE1rYURtSHZwaGhWbw0KPjEyQnRGVXZxWHANCj4+IFQlMkJEQnJudmRqViUyRkZpemZzJTNEJmFt
cDtyZXNlcnZlZD0wDQo+PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnBhdGNoDQo+Pg0KPndvcmsub3psYWJzLm9yZyUyRnBh
dGNoJTJGMTA1NDE4OSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDcGVuZy5tYQ0KPiU0MG54cC4NCj4+
DQo+Y29tJTdDNDBlODU5Njc2NjA2NDMxY2U4NDkwOGQ2YmMzNWJmM2QlN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5DQo+OWM1YzMwMQ0KPj4NCj42MzUlN0MwJTdDMSU3QzYzNjkwMzMzNjM2NDEwOTMy
MiZhbXA7c2RhdGE9SE51aUd6JTJCaGZlZ2NnTlE3DQo+VCUyQlBxR1BJDQo+PiBiUzNjaCUyRlVx
dHhtSEJmTDZNb1JvJTNEJmFtcDtyZXNlcnZlZD0wDQo+DQo+Q2FuIHlvdSByZXNlbmQsIGl0J3Mg
bm90IGNsZWFyIHdoaWNoIGlzIHdoaWNoIGhlcmUsIGFuZCB3aGF0IHBhcnRzIG9mIHRoZSBzZXJp
ZXMNCj5nb2VzIHdoZXJlLg0KPg0KPi0tDQo+SmVucyBBeGJvZQ0KDQo=
