Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFB4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BF8206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CHD/4DLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfEQIGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:06:07 -0400
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:59518
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727620AbfEQIGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIwjLwpx3QoDOPE+p8h9hJ4vgqTr3GQM8MHajBac8kk=;
 b=CHD/4DLyk5Hg0tjA9eWFdBN5AucIoPmj5NgDYm0IL1KfuQ4Stc0KLr7AwFHp9ym7j6oW49Bm7JIK54HWnirIHEpjWjjQqAAGHJaeJNFzZJ0vLR7Cuaf5xXpkE3l818miwim0IyiQoYU6V0Zo2PkLn3s4fUC+mkTxFq5CtC7uA6M=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB2973.eurprd04.prod.outlook.com (10.170.228.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 08:06:02 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 08:06:01 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, "arm@kernel.org" <arm@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] updates to soc/fsl drivers for v5.2
Thread-Topic: [GIT PULL] updates to soc/fsl drivers for v5.2
Thread-Index: AQHVAF5cAUKBiQa4mkaum88uqVKACaZvDf0A
Date:   Fri, 17 May 2019 08:06:01 +0000
Message-ID: <7eb0e7d0-6d28-5862-2ad5-889e57c8df5c@nxp.com>
References: <20190501203756.5443-1-leoyang.li@nxp.com>
In-Reply-To: <20190501203756.5443-1-leoyang.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: feb04c1b-2fa9-4ad0-baee-08d6da9e80b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB2973;
x-ms-traffictypediagnostic: VI1PR04MB2973:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB29737AC87FDBCC133E9A6F46EC0B0@VI1PR04MB2973.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(6116002)(6306002)(11346002)(54906003)(486006)(110136005)(446003)(476003)(2616005)(25786009)(66066001)(66556008)(66446008)(64756008)(71200400001)(15650500001)(2501003)(3846002)(76116006)(6512007)(45080400002)(8936002)(66946007)(73956011)(36756003)(66476007)(478600001)(6486002)(5660300002)(31686004)(6436002)(305945005)(4326008)(71190400001)(53936002)(68736007)(256004)(14454004)(102836004)(14444005)(26005)(53546011)(7736002)(316002)(6506007)(31696002)(99286004)(6246003)(229853002)(86362001)(76176011)(966005)(186003)(44832011)(81166006)(81156014)(2906002)(8676002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2973;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 78lTt5oott76MG4UDv01F7ZxseIwKLS3TrupVENvwTSCvymJzdENoJGxmiI9zGvhO+VdJFx6Ynivh7Qgttw9lNOmiOED5mqUlU/6kEBNoxD3QMtPYRT6e315NMMc945FI+v4fI2Chzb/t3sMHXFz8JR8jBWUV0RAeC4anhMikpVoceS0spQkPPuszytq2g7QwPpu1oIRSj0v/Euz3IdhlqFmqQQsWOhy4zeaZV66EtjPiRR7qdS2KS10lGsPbPNopp6dOzVBBaDMtJ0PpEoucmn5Ab7tllAy2yugBwcEgBj6f6gSP7dgVvRTFdr8jm56iaH0GGTrJLKHIT39AD6o5RcrL23dI075qrH2dmgKFj0EWaAsHM7p53JSRXue11IaZCd1LyJ2Lb09jZ1fUlcbCkg/pCzmUPJz5KOorR2xGJ4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A8B1DD27DAFFB409701F815D5218144@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb04c1b-2fa9-4ad0-baee-08d6da9e80b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 08:06:01.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkRpZCB0aGlzIHB1bGwgcmVxdWVzdCBzb21laG93IHNsaXBwZWQgdGhyb3VnaD8N
Cg0KLS0tDQpUaGFua3MgJiBCZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQ0KDQpPbiAwMS4wNS4yMDE5
IDIzOjM3LCBMaSBZYW5nIHdyb3RlOg0KPiBIaSBhcm0tc29jIG1haW50YWluZXJzLA0KPiANCj4g
UGxlYXNlIGhlbHAgdG8gbWVyZ2UgZm9yLW5leHQgcGF0Y2hlcyBmb3IgdGhlIHVwY29taW5nIG1l
cmdlIHdpbmRvdy4gIFRoYW5rcw0KPiANCj4gUmVnYXJkcywNCj4gTGVvDQo+IA0KPiANCj4gVGhl
IGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA5ZTk4YzY3OGMyZDZhZTNhMTdjYjJkZTU1
ZDE3ZjY5ZGRkYWEyMzFiOg0KPiANCj4gICAgTGludXggNS4xLXJjMSAoMjAxOS0wMy0xNyAxNDoy
MjoyNiAtMDcwMCkNCj4gDQo+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0
Og0KPiANCj4gICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L2xlby9saW51eC5naXQgdGFncy9zb2MtZnNsLW5leHQtdjUuMg0KPiANCj4gZm9yIHlvdSB0byBm
ZXRjaCBjaGFuZ2VzIHVwIHRvIDFjOGYzOTk0NmMwMzNkZTA4ZTM4MjAyNWQ3YWM3ZjU1ZmJjYTU3
ZWI6DQo+IA0KPiAgICBzb2M6IGZzbDogcWJtYW5fcG9ydGFsczogYWRkIEFQSXMgdG8gcmV0cmll
dmUgdGhlIHByb2Jpbmcgc3RhdHVzICgyMDE5LTA1LTAxIDE1OjA5OjU5IC0wNTAwKQ0KPiANCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBOWFAvRlNMIFNvQyBkcml2ZXIgdXBkYXRlcyBmb3IgdjUuMg0KPiANCj4gRFBB
QTIgQ29uc29sZSBkcml2ZXINCj4gLSBBZGQgZHJpdmVyIHRvIGV4cG9ydCB0d28gY2hhciBkZXZp
Y2VzIHRvIGR1bXAgbG9ncyBmb3IgTUMgYW5kDQo+ICAgIEFJT1ANCj4gDQo+IERQQUEyIERQSU8g
ZHJpdmVyDQo+IC0gQWRkIHN1cHBvcnQgZm9yIG1lbW9yeSBiYWNrZWQgUUJNYW4gcG9ydGFscw0K
PiAtIEluY3JlYXNlIHRoZSB0aW1lb3V0IHBlcmlvZCB0byBwcmV2ZW50IGZhbHNlIGVycm9yDQo+
IC0gQWRkIEFQSXMgdG8gcmV0cmlldmUgUUJNYW4gcG9ydGFsIHByb2Jpbmcgc3RhdHVzDQo+IA0K
PiBEUEFBIFFtYW4gZHJpdmVyDQo+IC0gT25seSBtYWtlIGxpb2RuIGZpeHVwIG9uIHBvd2VycGMg
U29DcyB3aXRoIFBBTVUgaW9tbXUNCj4gDQo+IEd1dHMgZHJpdmVyDQo+IC0gQWRkIGRlZmluaXRp
b24gZm9yIExYMjE2MGEgU29DDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IElvYW5hIENpb3JuZWkgKDIpOg0K
PiAgICAgICAgRG9jdW1lbnRhdGlvbjogRFQ6IEFkZCBlbnRyeSBmb3IgRFBBQTIgY29uc29sZQ0K
PiAgICAgICAgc29jOiBmc2w6IGFkZCBEUEFBMiBjb25zb2xlIHN1cHBvcnQNCj4gDQo+IExhdXJl
bnRpdSBUdWRvciAoMik6DQo+ICAgICAgICBzb2M6IGZzbDogcW1hbjogZml4dXAgbGlvZG5zIG9u
bHkgb24gcHBjIHRhcmdldHMNCj4gICAgICAgIHNvYzogZnNsOiBxYm1hbl9wb3J0YWxzOiBhZGQg
QVBJcyB0byByZXRyaWV2ZSB0aGUgcHJvYmluZyBzdGF0dXMNCj4gDQo+IFJveSBQbGVkZ2UgKDIp
Og0KPiAgICAgICAgYnVzOiBtYy1idXM6IEFkZCBzdXBwb3J0IGZvciBtYXBwaW5nIHNoYXJlYWJs
ZSBwb3J0YWxzDQo+ICAgICAgICBzb2M6IGZzbDogZHBpbzogQWRkIHN1cHBvcnQgZm9yIG1lbW9y
eSBiYWNrZWQgUUJNYW4gcG9ydGFscw0KPiANCj4gVmFiaGF2IFNoYXJtYSAoMSk6DQo+ICAgICAg
ICBzb2M6IGZzbDogZ3V0czogQWRkIGRlZmluaXRpb24gZm9yIExYMjE2MEENCj4gDQo+IFlvdXJp
IFF1ZXJyeSAoMSk6DQo+ICAgICAgICBzb2M6IGZzbDogZHBpbzogSW5jcmVhc2UgdGltZW91dCBm
b3IgUUJNYW4gTWFuYWdlbWVudCBDb21tYW5kcw0KPiANCj4gICAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9taXNjL2ZzbCxkcGFhMi1jb25zb2xlLnR4dCB8ICAxMSArDQo+ICAgTUFJTlRBSU5FUlMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRyaXZl
cnMvYnVzL2ZzbC1tYy9kcHJjLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMwICstDQo+
ICAgZHJpdmVycy9idXMvZnNsLW1jL2ZzbC1tYy1idXMuYyAgICAgICAgICAgICAgICAgICAgfCAg
MTUgKy0NCj4gICBkcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLXByaXZhdGUuaCAgICAgICAgICAg
ICAgICB8ICAxNyArLQ0KPiAgIGRyaXZlcnMvc29jL2ZzbC9LY29uZmlnICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDEwICsNCj4gICBkcml2ZXJzL3NvYy9mc2wvTWFrZWZpbGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgZHJpdmVycy9zb2MvZnNsL2RwYWEyLWNv
bnNvbGUuYyAgICAgICAgICAgICAgICAgICAgfCAzMjkgKysrKysrKysrKysrKysrKysrKysrDQo+
ICAgZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYyAgICAgICAgICAgICAgICAgfCAg
MjMgKy0NCj4gICBkcml2ZXJzL3NvYy9mc2wvZHBpby9xYm1hbi1wb3J0YWwuYyAgICAgICAgICAg
ICAgICB8IDE0OCArKysrKysrLS0NCj4gICBkcml2ZXJzL3NvYy9mc2wvZHBpby9xYm1hbi1wb3J0
YWwuaCAgICAgICAgICAgICAgICB8ICAgOSArLQ0KPiAgIGRyaXZlcnMvc29jL2ZzbC9ndXRzLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCj4gICBkcml2ZXJzL3NvYy9mc2wv
cWJtYW4vYm1hbl9wb3J0YWwuYyAgICAgICAgICAgICAgICB8ICAyMCArLQ0KPiAgIGRyaXZlcnMv
c29jL2ZzbC9xYm1hbi9xbWFuX2Njc3IuYyAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ICAg
ZHJpdmVycy9zb2MvZnNsL3FibWFuL3FtYW5fcG9ydGFsLmMgICAgICAgICAgICAgICAgfCAgMjEg
Ky0NCj4gICBkcml2ZXJzL3NvYy9mc2wvcWJtYW4vcW1hbl9wcml2LmggICAgICAgICAgICAgICAg
ICB8ICAgOSArLQ0KPiAgIGluY2x1ZGUvc29jL2ZzbC9ibWFuLmggICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA4ICsNCj4gICBpbmNsdWRlL3NvYy9mc2wvcW1hbi5oICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgOSArDQo+ICAgMTggZmlsZXMgY2hhbmdlZCwgNjE4IGluc2Vy
dGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy9mc2wsZHBhYTItY29uc29sZS50eHQNCj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvZnNsL2RwYWEyLWNvbnNvbGUuYw0KPiAN
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwJTNBJTJGJTJGbGlzdHMuaW5mcmFkZWFkLm9yZyUyRm1haWxtYW4lMkZsaXN0
aW5mbyUyRmxpbnV4LWFybS1rZXJuZWwmYW1wO2RhdGE9MDIlN0MwMSU3Q2xhdXJlbnRpdS50dWRv
ciU0MG54cC5jb20lN0NjZTNmZjFiZGMwOGI0NDU0NDdlNDA4ZDZjZTc1N2RjOSU3QzY4NmVhMWQz
YmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5MjM0MDEzNDY4MDY1MjgmYW1w
O3NkYXRhPURYaDVNZW43TXcxbHR0RmJKc2tPemRMZlNNcUNscE1yOWx1OXFKUVY1SDglM0QmYW1w
O3Jlc2VydmVkPTANCj4g
