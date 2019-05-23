Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A56EC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013E320862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j7ULGu3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfEWIGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:06:55 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:61106
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729700AbfEWIGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWaTk8MbZpmIop2guW09qvoF8guSPYmjA49+FhJk8C0=;
 b=j7ULGu3vY4YvufQl7EUVFjTzC1y14pIo6DVEcH0qwc5eIZPrqLMKq7WFzeZTeYyES7+q4w/GIKjuzPdKxMxuyWA/r9R9zDAcyy3L2QSJt9lTcPRJALTDfzDog6iQr99Lx8G9EGHnQrwf1feKh4/V7E9smyt+voRVAOvw+ZwSV1Y=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3185.eurprd04.prod.outlook.com (10.173.255.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 23 May 2019 08:06:43 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::15e3:bb28:7e33:1adb]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::15e3:bb28:7e33:1adb%7]) with mapi id 15.20.1922.017; Thu, 23 May 2019
 08:06:42 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCHv2] arm64: dts: ls1028a: add flexspi nodes
Thread-Topic: [EXT] Re: [PATCHv2] arm64: dts: ls1028a: add flexspi nodes
Thread-Index: AQHVCw6ogMFRF8ssNEKztKIHvtwUn6Z4ZSmAgAAAqwA=
Date:   Thu, 23 May 2019 08:06:42 +0000
Message-ID: <AM5PR04MB32997EA37551AFC88FCBE2C6F5010@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20190515110924.13726-1-xiaowei.bao@nxp.com>
 <20190523080049.GI9261@dragon>
In-Reply-To: <20190523080049.GI9261@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43aa6459-d660-4dbd-d523-08d6df5597b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR04MB3185;
x-ms-traffictypediagnostic: AM5PR04MB3185:
x-microsoft-antispam-prvs: <AM5PR04MB318553DD68302E88F4EEB310F5010@AM5PR04MB3185.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(366004)(396003)(13464003)(189003)(199004)(44832011)(4326008)(86362001)(7696005)(316002)(99286004)(54906003)(76176011)(2906002)(186003)(478600001)(53546011)(6506007)(55016002)(476003)(26005)(3846002)(6116002)(102836004)(8936002)(6436002)(66066001)(81166006)(81156014)(8676002)(486006)(11346002)(446003)(73956011)(76116006)(229853002)(52536014)(5660300002)(53936002)(68736007)(66556008)(64756008)(6246003)(66946007)(66476007)(66446008)(256004)(74316002)(7736002)(305945005)(9686003)(33656002)(6916009)(71200400001)(71190400001)(25786009)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3185;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wVM7EXpMrt8yPD59xt0F4FUO6zo1lXmGRO9nu3FVBehM+OkLyDGiPhLlmEK8F6yMK36OzOmlTWi0rIIQW3kHQHsvWDP83KlW8yHKvIJdI7vQvvnGdACPt1lf0AvSgS3TlPQrxGt1biF/yRQpKIey5aJp7dXM52j9NToZDXowjc+iSxqLUM4o9c2VxhqZZkHfQaIS5x8JvaIwQ/H6qUpppgpOlUL49oqp30IQZcr1lbax1eYlSMcfsdYoNrsKCXUDC1cplUYcEE5FsvqB6zRazAWKpoiy4LKdiBvjq6X5Z9MayKruuJEU14iclYxpNzXH2AByoll4t0lrADMv/i/kzm7Hq5wAaWUBSf0st8oxjPcEFg216jvzY7NTYn9Ixdr+e9bNc/ZQuD8dCSOiFBJxF0ZX3WVSHtwFCke5eoXH0Co=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43aa6459-d660-4dbd-d523-08d6df5597b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 08:06:42.8512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTaGF3biBHdW8g
PHNoYXduZ3VvQGtlcm5lbC5vcmc+IA0KU2VudDogMjAxOcTqNdTCMjPI1SAxNjowMQ0KVG86IFhp
YW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KQ2M6IExlbyBMaSA8bGVveWFuZy5saUBu
eHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogW0VYVF0gUmU6IFtQQVRD
SHYyXSBhcm02NDogZHRzOiBsczEwMjhhOiBhZGQgZmxleHNwaSBub2Rlcw0KDQpDYXV0aW9uOiBF
WFQgRW1haWwNCg0KT24gV2VkLCBNYXkgMTUsIDIwMTkgYXQgMTE6MDk6MjVBTSArMDAwMCwgWGlh
b3dlaSBCYW8gd3JvdGU6DQo+IEZyb206IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29t
Pg0KPg0KPiBBZGQgZnNwaSBub2RlIHByb3BlcnR5IGZvciBMUzEwMjhBIFNvQyBmb3IgRmxleFNQ
SSBkcml2ZXIuDQo+IFByb3BlcnR5IGFkZGVkIGZvciB0aGUgRmxleFNQSSBjb250cm9sbGVyIGFu
ZCBmb3IgdGhlIGNvbm5lY3RlZCBzbGF2ZSANCj4gZGV2aWNlIGZvciB0aGUgTFMxMDI4QVJEQiBh
bmQgTFMxMDI4QVFEUyB0YXJnZXQuDQo+IFRoaXMgaXMgaGF2aW5nIG9uZSBTUEktTk9SIGZsYXNo
IGRldmljZSwgbXQzNXh1MDJnIGNvbm5lY3RlZCBhdCBDUzAuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiAtLS0NCj4gdjI6DQo+ICAtIG1v
ZGlmeSB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIHRoZSBkdHMgZm9ybWF0Lg0KPg0KPiAgYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0cyB8ICAgMTUgKysrKysr
KysrKysrKysrDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1y
ZGIuZHRzIHwgICAxNSArKysrKysrKysrKysrKysNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgICAgfCAgIDEyICsrKysrKysrKysrKw0KPiAgMyBmaWxl
cyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0cyAN
Cj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQo+
IGluZGV4IDViY2Q0OTEuLjZlMTI4MDYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0cw0KPiBAQCAtMTU4LDYgKzE1OCwyMSBA
QA0KPiAgICAgICB9Ow0KPiAgfTsNCj4NCj4gKyZmc3BpIHsNCg0KS2VlcCB0aGUgbGFiZWxpbmcg
bm9kZSBzb3J0IGFscGhhYmV0aWNhbGx5LiAgVGhhdCBzYWlkLCAmZnNwaSBzaG91bGQgYmUgYWRk
ZWQgYmVmb3JlICZpMmMwLg0KDQo+ICsgICAgIHN0YXR1cyA9ICJva2F5IjsNCg0KUGxlYXNlIGhh
dmUgbmV3bGluZSBiZXR3ZWVuIHByb3BlcnR5IGFuZCBjaGlsZCBub2RlLg0KDQo+ICsgICAgIG10
MzV4dTAyZzogZmxhc2hAMCB7DQo+ICsgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ICsgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+ICsgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJzcGFuc2lvbixtMjVwODAiOw0KDQpQbGVhc2Ugc3RhcnQgcHJvcGVydGllcyB3
aXRoIGNvbXBhdGlibGUuDQpbWGlhb3dlaSBCYW9dIEkgaGF2ZSBzdWJtaXQgdGhlIHYzIHBhdGNo
IHRvIGZpeCB0aGlzIGlzc3VlLg0KDQo+ICsgICAgICAgICAgICAgbTI1cCxmYXN0LXJlYWQ7DQo+
ICsgICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MjAwMDAwMDA+Ow0KPiArICAgICAg
ICAgICAgIHJlZyA9IDwwPjsNCj4gKyAgICAgICAgICAgICAvKiBUaGUgZm9sbG93aW5nIHNldHRp
bmcgZW5hYmxlcyAxLTEtOCAoQ01ELUFERFItREFUQSkgbW9kZSAqLw0KPiArICAgICAgICAgICAg
IHNwaS1yeC1idXMtd2lkdGggPSA8OD47IC8qIDggU1BJIFJ4IGxpbmVzICovDQo+ICsgICAgICAg
ICAgICAgc3BpLXR4LWJ1cy13aWR0aCA9IDwxPjsgLyogMSBTUEkgVHggbGluZSAqLw0KPiArICAg
ICB9Ow0KPiArfTsNCj4gKw0KPiAgJnNhaTEgew0KPiAgICAgICBzdGF0dXMgPSAib2theSI7DQo+
ICB9Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxz
MTAyOGEtcmRiLmR0cyANCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMx
MDI4YS1yZGIuZHRzDQo+IGluZGV4IDI1ZDIzNzAuLjVkMzk2MTYgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMNCj4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cw0KPiBAQCAt
MTM2LDYgKzEzNiwyMSBAQA0KPiAgICAgICB9Ow0KPiAgfTsNCj4NCj4gKyZmc3BpIHsNCj4gKyAg
ICAgc3RhdHVzID0gIm9rYXkiOw0KPiArICAgICBtdDM1eHUwMmc6IGZsYXNoQDAgew0KPiArICAg
ICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAgICAgICAgICNzaXplLWNl
bGxzID0gPDE+Ow0KPiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic3BhbnNpb24sbTI1cDgw
IjsNCj4gKyAgICAgICAgICAgICBtMjVwLGZhc3QtcmVhZDsNCj4gKyAgICAgICAgICAgICBzcGkt
bWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47DQo+ICsgICAgICAgICAgICAgcmVnID0gPDA+Ow0K
PiArICAgICAgICAgICAgIC8qIFRoZSBmb2xsb3dpbmcgc2V0dGluZyBlbmFibGVzIDEtMS04IChD
TUQtQUREUi1EQVRBKSBtb2RlICovDQo+ICsgICAgICAgICAgICAgc3BpLXJ4LWJ1cy13aWR0aCA9
IDw4PjsgLyogOCBTUEkgUnggbGluZXMgKi8NCj4gKyAgICAgICAgICAgICBzcGktdHgtYnVzLXdp
ZHRoID0gPDE+OyAvKiAxIFNQSSBUeCBsaW5lICovDQo+ICsgICAgIH07DQo+ICt9Ow0KPiArDQo+
ICAmZHVhcnQwIHsNCj4gICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgDQo+IGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KPiBpbmRleCBi
YTcxYTMzLi5hMjdjZDYwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHMxMDI4YS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gQEAgLTEwOSw2ICsxMDksMTggQEANCj4gICAgICAgICAg
ICAgICB9Ow0KPiAgICAgICB9Ow0KPg0KPiArICAgICBmc3BpOiBzcGlAMjBjMDAwMCB7DQoNCkFy
ZSB5b3Ugc3VyZSB5b3Ugd2FudCB0byBhZGQgdGhpcyBkZXZpY2Ugbm9kZSBvdXRzaWRlIG9mICdz
b2MnIG5vZGU/DQoNCj4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxseDIxNjBhLWZz
cGkiLCAic2ltcGxlLWJ1cyI7DQo+ICsgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ICsgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ICsgICAgICAgICAgICAgcmVn
ID0gPDB4MCAweDIwYzAwMDAgMHgwIDB4MTAwMDA+LA0KPiArICAgICAgICAgICAgICAgICA8MHgw
IDB4MjAwMDAwMDAgMHgwIDB4MTAwMDAwMDA+Ow0KDQpGaXggdGhlIGluZGVudGF0aW9uIHRvIGdp
dCBpdCBhbGlnbmVkIHdpdGggYWJvdmUgJzwnLg0KW1hpYW93ZWkgQmFvXSB0aGlzIGlzIGFsaWdu
ZWQsIEkgZG9uJ3Qga25vdyB3aHkgaXQgaXMgbm90IGFsaWduZWQgaW4gZW1haWwuIFRoYW5rcy4N
Cg0KPiArICAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJGU1BJIiwgIkZTUEktbWVtb3J5IjsNCj4g
KyAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDAgMjUgMHg0PjsgLyogTGV2ZWwgaGlnaCB0eXBl
ICovDQoNCmludGVycnVwdHMgPSA8R0lDX1NQSSAyNSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCg0K
U2hhd24NCg0KPiArICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xvY2tnZW4gNCAzPiwgPCZjbG9j
a2dlbiA0IDM+Ow0KPiArICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImZzcGlfZW4iLCAiZnNw
aSI7DQo+ICsgICAgIH07DQo+ICsNCj4gICAgICAgc29jOiBzb2Mgew0KPiAgICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+ICAgICAgICAgICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8Mj47DQo+IC0tDQo+IDEuNy4xDQo+DQo=
