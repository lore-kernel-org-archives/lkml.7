Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F47CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49170206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UN6Sl/a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfECREX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:04:23 -0400
Received: from mail-eopbgr820084.outbound.protection.outlook.com ([40.107.82.84]:33330
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfECREW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI4SwQR5RQkVqW+Q0jY+s+NyNw8aiN9otNV5LN2xGz8=;
 b=UN6Sl/a7WcUYGZNXU4PHAHHBv7XMuJ83fkXbNMg0eUS4x31amOeD4CmWUcHE1OKhrAI3SJfugTJD76YryPzmfPghsiulV0DkHEQbaaorL09jSWBH4O2KzpaQb37cddjhlpWjY5vHFeKUM364viGUMMVnfw7Gpn0KNAHOtMAUn8E=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB4289.namprd02.prod.outlook.com (10.167.172.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Fri, 3 May 2019 17:04:17 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d%5]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 17:04:17 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH V3 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
Thread-Topic: [PATCH V3 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
Thread-Index: AQHU/UVMESM8TKHZf0mZ8yysxzDRXaZWsusAgAD9BPCAAJ0dgIABWLzg
Date:   Fri, 3 May 2019 17:04:17 +0000
Message-ID: <BL0PR02MB5681ECF087DF6672F1611A1BCB350@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-2-git-send-email-dragan.cvetic@xilinx.com>
 <20190501194738.GA1441@bogus>
 <BL0PR02MB56815DFC139D65D46D5DFF50CB340@BL0PR02MB5681.namprd02.prod.outlook.com>
 <CAL_JsqLhmtqUdUd8OPdx-390imegzouAJ43JOhYr16w87afS-Q@mail.gmail.com>
In-Reply-To: <CAL_JsqLhmtqUdUd8OPdx-390imegzouAJ43JOhYr16w87afS-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20505d24-e144-425a-b980-08d6cfe960df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB4289;
x-ms-traffictypediagnostic: BL0PR02MB4289:
x-microsoft-antispam-prvs: <BL0PR02MB428974C526DCE3186FF100BECB350@BL0PR02MB4289.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(136003)(13464003)(189003)(199004)(6436002)(256004)(6506007)(316002)(53546011)(6116002)(52536014)(74316002)(54906003)(478600001)(25786009)(68736007)(64756008)(6916009)(102836004)(2906002)(99286004)(71200400001)(66446008)(66946007)(73956011)(71190400001)(8936002)(66556008)(8676002)(229853002)(81156014)(81166006)(3846002)(14454004)(76116006)(33656002)(305945005)(86362001)(9686003)(7736002)(66476007)(186003)(66066001)(107886003)(6246003)(53936002)(76176011)(476003)(11346002)(55016002)(5660300002)(4326008)(486006)(7696005)(26005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4289;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vwY8WFbufxbrIxH9DIyoxxTDqRmMw7RZD+B/wYaiBBtOpT6ungKOKiB6sanxA5qY5AUnhgbp04TJyR6uP9vx3K7NhmAPCfeBAULbJ/wmQXjTy+0hkhzyqx9zcjwruKCTsR4KgcMmRJ3UP4cXK/Ogd5w6HtRPZsySViSd9es0JV4elg2PHvSM0oA4BhZR0P48xSPLDg29K3r9wx6foxoDNof3RDtad9XxiUVlZtSgn5G2uOy+xNKAVZu/Ns6bBfwy2akZ0GST0s1skac7lZEGPOXAVlSw0EdCCqoBtI+by/na5g9yeTfpys7W8sONhDbneTJgNbeD0ZjHVpZAj14kLOiWsqmnV9DhjxjYEVzVwl2Hl9TMyABUtK8rKKchV6FP/JNtIXXLaTRQDc2q5DjKenJnqnvWXbuKH2IjnAfTQLo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20505d24-e144-425a-b980-08d6cfe960df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 17:04:17.7848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpQbGVhc2UgZmluZCBpbmxpbmUgY29tbWVudHMgYmVsb3cNCg0KUmVnYXJkcw0K
RHJhZ2FuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJp
bmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+IFNlbnQ6IFRodXJzZGF5IDIgTWF5IDIwMTkg
MjE6MTYNCj4gVG86IERyYWdhbiBDdmV0aWMgPGRyYWdhbmNAeGlsaW54LmNvbT4NCj4gQ2M6IGFy
bmRAYXJuZGIuZGU7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBNaWNoYWwgU2ltZWsgPG1p
Y2hhbHNAeGlsaW54LmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gbWFyay5ydXRsYW5kQGFybS5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEZXJlayBLaWVybmFuIDxka2llcm5hbkB4aWxpbngu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDAxLzEyXSBkdC1iaW5kaW5nczogeGlsaW54
LXNkZmVjOiBBZGQgU0RGRUMgYmluZGluZw0KPiANCj4gT24gVGh1LCBNYXkgMiwgMjAxOSBhdCA2
OjA0IEFNIERyYWdhbiBDdmV0aWMgPGRyYWdhbmNAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBIaSBSb2IsDQo+ID4NCj4gPiBQbGVhc2UgZmluZCBteSBpbmxpbmUgY29tbWVudHMgYmVsb3cN
Cj4gPg0KPiA+IFRoYW5rIHlvdQ0KPiA+IERyYWdhbg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtlcm5l
bC5vcmddDQo+ID4gPiBTZW50OiBXZWRuZXNkYXkgMSBNYXkgMjAxOSAyMDo0OA0KPiA+ID4gVG86
IERyYWdhbiBDdmV0aWMgPGRyYWdhbmNAeGlsaW54LmNvbT4NCj4gPiA+IENjOiBhcm5kQGFybmRi
LmRlOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhp
bGlueC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERlcmVrIEtpZXJuYW4gPGRraWVybmFuQHhpbGlueC5jb20+
DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDAxLzEyXSBkdC1iaW5kaW5nczogeGlsaW54
LXNkZmVjOiBBZGQgU0RGRUMgYmluZGluZw0KPiA+ID4NCj4gPiA+IE9uIFNhdCwgQXByIDI3LCAy
MDE5IGF0IDExOjA0OjU1UE0gKzAxMDAsIERyYWdhbiBDdmV0aWMgd3JvdGU6DQo+ID4gPiA+IEFk
ZCB0aGUgU29mdCBEZWNpc2lvbiBGb3J3YXJkIEVycm9yIENvcnJlY3Rpb24gKFNERkVDKSBFbmdp
bmUNCj4gPiA+ID4gYmluZGluZ3Mgd2hpY2ggaXMgYXZhaWxhYmxlIGZvciB0aGUgWnlucSBVbHRy
YVNjYWxlKyBSRlNvQw0KPiA+ID4gPiBGUEdBJ3MuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IERyYWdhbiBDdmV0aWMgPGRyYWdhbi5jdmV0aWNAeGlsaW54LmNvbT4NCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogRGVyZWsgS2llcm5hbiA8ZGVyZWsua2llcm5hbkB4aWxpbnguY29tPg0K
PiA+ID4gPiAtLS0NCj4gPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MveGxueCxz
ZC1mZWMudHh0ICAgICAgIHwgNTggKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy94bG54LHNkLWZlYy50eHQN
Cj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9taXNjL3hsbngsc2QtZmVjLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9taXNjL3hsbngsc2QtDQo+IGZlYy50eHQNCj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiA+ID4gaW5kZXggMDAwMDAwMC4uNDI1YjZhNg0KPiA+ID4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNj
L3hsbngsc2QtZmVjLnR4dA0KPiA+ID4gPiBAQCAtMCwwICsxLDU4IEBADQo+ID4gPiA+ICsqIFhp
bGlueCBTREZFQygxNm5tKSBJUCAqDQo+ID4gPiA+ICsNCj4gPiA+ID4gK1RoZSBTb2Z0IERlY2lz
aW9uIEZvcndhcmQgRXJyb3IgQ29ycmVjdGlvbiAoU0RGRUMpIEVuZ2luZSBpcyBhIEhhcmQgSVAg
YmxvY2sNCj4gPiA+ID4gK3doaWNoIHByb3ZpZGVzIGhpZ2gtdGhyb3VnaHB1dCBMRFBDIGFuZCBU
dXJibyBDb2RlIGltcGxlbWVudGF0aW9ucy4NCj4gPiA+ID4gK1RoZSBMRFBDIGRlY29kZSAmIGVu
Y29kZSBmdW5jdGlvbmFsaXR5IGlzIGNhcGFibGUgb2YgY292ZXJpbmcgYSByYW5nZSBvZg0KPiA+
ID4gPiArY3VzdG9tZXIgc3BlY2lmaWVkIFF1YXNpLWN5Y2xpYyAoUUMpIGNvZGVzLiBUaGUgVHVy
Ym8gZGVjb2RlIGZ1bmN0aW9uYWxpdHkNCj4gPiA+ID4gK3ByaW5jaXBhbGx5IGNvdmVycyBjb2Rl
cyB1c2VkIGJ5IExURS4gVGhlIEZFQyBFbmdpbmUgb2ZmZXJzIHNpZ25pZmljYW50DQo+ID4gPiA+
ICtwb3dlciBhbmQgYXJlYSBzYXZpbmdzIHZlcnN1cyBpbXBsZW1lbnRhdGlvbnMgZG9uZSBpbiB0
aGUgRlBHQSBmYWJyaWMuDQo+ID4gPiA+ICsNCj4gPiA+ID4gKw0KPiA+ID4gPiArUmVxdWlyZWQg
cHJvcGVydGllczoNCj4gPiA+ID4gKy0gY29tcGF0aWJsZTogTXVzdCBiZSAieGxueCxzZC1mZWMt
MS4xIg0KPiA+ID4gPiArLSBjbG9jay1uYW1lcyA6IExpc3Qgb2YgaW5wdXQgY2xvY2sgbmFtZXMg
ZnJvbSB0aGUgZm9sbG93aW5nOg0KPiA+ID4gPiArICAgIC0gImNvcmVfY2xrIiwgTWFpbiBwcm9j
ZXNzaW5nIGNsb2NrIGZvciBwcm9jZXNzaW5nIGNvcmUgKHJlcXVpcmVkKQ0KPiA+ID4gPiArICAg
IC0gInNfYXhpX2FjbGsiLCBBWEk0LUxpdGUgbWVtb3J5LW1hcHBlZCBzbGF2ZSBpbnRlcmZhY2Ug
Y2xvY2sgKHJlcXVpcmVkKQ0KPiA+ID4gPiArICAgIC0gInNfYXhpc19kaW5fYWNsayIsIERJTiBB
WEk0LVN0cmVhbSBTbGF2ZSBpbnRlcmZhY2UgY2xvY2sgKG9wdGlvbmFsKQ0KPiA+ID4gPiArICAg
IC0gInNfYXhpc19kaW5fd29yZHMtYWNsayIsIERJTl9XT1JEUyBBWEk0LVN0cmVhbSBTbGF2ZSBp
bnRlcmZhY2UgY2xvY2sgKG9wdGlvbmFsKQ0KPiA+ID4gPiArICAgIC0gInNfYXhpc19jdHJsX2Fj
bGsiLCAgQ29udHJvbCBpbnB1dCBBWEk0LVN0cmVhbSBTbGF2ZSBpbnRlcmZhY2UgY2xvY2sgKG9w
dGlvbmFsKQ0KPiA+ID4gPiArICAgIC0gIm1fYXhpc19kb3V0X2FjbGsiLCBET1VUIEFYSTQtU3Ry
ZWFtIE1hc3RlciBpbnRlcmZhY2UgY2xvY2sgKG9wdGlvbmFsKQ0KPiA+ID4gPiArICAgIC0gIm1f
YXhpc19kb3V0X3dvcmRzX2FjbGsiLCBET1VUX1dPUkRTIEFYSTQtU3RyZWFtIE1hc3RlciBpbnRl
cmZhY2UgY2xvY2sgKG9wdGlvbmFsKQ0KPiA+ID4gPiArICAgIC0gIm1fYXhpc19zdGF0dXNfYWNs
ayIsIFN0YXR1cyBvdXRwdXQgQVhJNC1TdHJlYW0gTWFzdGVyIGludGVyZmFjZSBjbG9jayAob3B0
aW9uYWwpDQo+ID4gPiA+ICstIGNsb2NrcyA6IENsb2NrIHBoYW5kbGVzIChzZWUgY2xvY2tfYmlu
ZGluZ3MudHh0IGZvciBkZXRhaWxzKS4NCj4gPiA+ID4gKy0gcmVnOiBTaG91bGQgY29udGFpbiBY
aWxpbnggU0RGRUMgMTZubSBIYXJkZW5lZCBJUCBibG9jayByZWdpc3RlcnMNCj4gPiA+ID4gKyAg
bG9jYXRpb24gYW5kIGxlbmd0aC4NCj4gPiA+ID4gKy0geGxueCxzZGZlYy1jb2RlIDogU2hvdWxk
IGNvbnRhaW4gImxkcGMiIG9yICJ0dXJibyIgdG8gZGVzY3JpYmUgdGhlIGNvZGVzDQo+ID4gPiA+
ICsgIGJlaW5nIHVzZWQuDQo+ID4gPiA+ICstIHhsbngsc2RmZWMtZGluLXdvcmRzIDogQSB2YWx1
ZSAwIGluZGljYXRlcyB0aGF0IHRoZSBESU5fV09SRFMgaW50ZXJmYWNlIGlzDQo+ID4gPiA+ICsg
IGRyaXZlbiB3aXRoIGEgZml4ZWQgdmFsdWUgYW5kIGlzIG5vdCBwcmVzZW50IG9uIHRoZSBkZXZp
Y2UsIGEgdmFsdWUgb2YgMQ0KPiA+ID4gPiArICBjb25maWd1cmVzIHRoZSBESU5fV09SRFMgdG8g
YmUgYmxvY2sgYmFzZWQsIHdoaWxlIGEgdmFsdWUgb2YgMiBjb25maWd1cmVzIHRoZQ0KPiA+ID4g
PiArICBESU5fV09SRFMgaW5wdXQgdG8gYmUgc3VwcGxpZWQgZm9yIGVhY2ggQVhJIHRyYW5zYWN0
aW9uLg0KPiA+ID4gPiArLSB4bG54LHNkZmVjLWRpbi13aWR0aCA6IENvbmZpZ3VyZXMgdGhlIERJ
TiBBWEkgc3RyZWFtIHdoZXJlIGEgdmFsdWUgb2YgMQ0KPiA+ID4gPiArICBjb25maWd1cmVzIGEg
d2lkdGggb2YgIjF4MTI4YiIsIDIgYSB3aWR0aCBvZiAiMngxMjhiIiBhbmQgNCBjb25maWd1cmVz
IGEgd2lkdGgNCj4gPiA+ID4gKyAgb2YgIjR4MTI4YiIuDQo+ID4gPg0KPiA+ID4gUGVyaGFwcyBh
cHBlbmQgd2l0aCAnLWJpdHMnIGFuZCBtYWtlIHRoZSB2YWx1ZXMgMCwgMTI4LCAyNTYsIDUxMi4N
Cj4gPiA+DQo+ID4NCj4gPg0KPiA+IFRoZSBzdWdnZXN0ZWQgd2lsbCByZXF1aXJlIHRoZSBleHRy
YSBjb2RlIGZvciBjb252ZXJ0aW5nIGZyb20gMTI4LDI1Niw1MTIgIHRvIDEsMiw0LCBhcyBIVyBp
cyBjb25maWd1cmVkIHdpdGggMSwgMiBhbmQgNC4NCj4gDQo+IEEgc2ltcGxlIGRpdmlkZSBieSAx
MjguDQo+IA0KPiBXZSBnZW5lcmFsbHkgcHJlZmVyIERUIHRvIHVzZSByZWFsIHVuaXRzIHJhdGhl
ciB0aGFuIHJlZ2lzdGVyIHZhbHVlcy4NCg0KVGhlIGRhdGEgZW50ZXJzL2V4aXRzIFNERkVDIGlu
IDEyOCBiaXRzIHdvcmQgdW5pdHMgKF9faW50MTI4KS4NCjEsMiw0IGFyZSBub3QgYSByZWdpc3Rl
ciB2YWx1ZXMgb25seSwgdGhleSByZXByZXNlbnQgYSBudW1iZXINCm9mIHVuaXRzIHdoaWNoIGFy
ZSB1c2VkIGluIFNERkVDIGNvbW11bmljYXRpb24uDQoNCj4gDQo+IFJvYg0K
