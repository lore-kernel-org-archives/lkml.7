Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62173C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237A62085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="x0UwsyIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCSNpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:45:23 -0400
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:50512
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfCSNpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLhuczW5MsOG3pSQSXkvKoarD6WDYutqvV/Eg++vFVY=;
 b=x0UwsyIvmDFTg8jwS89WTU8hPwsFYF73zvgPiUC1uwseHWZ3Pb1DgWOOfKWDfaQVdtme/IdugVNE/k0jYTmKmwBu9NBQlaioYzvKxNk43jni7B6zh71fP0fPQtQjJKw38DLHlt2af19EqmJ0WkLf8mFaqRKAjKS0lLDV4+Jn95U=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB4961.namprd02.prod.outlook.com (52.132.14.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Tue, 19 Mar 2019 13:44:26 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 13:44:25 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Michal Simek <michals@xilinx.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH 00/12] misc: xilinx sd-fec driver
Thread-Topic: [PATCH 00/12] misc: xilinx sd-fec driver
Thread-Index: AQHU3kvsu+uLIqR4m069yWggySo2BaYS3vGAgAAXsFA=
Date:   Tue, 19 Mar 2019 13:44:25 +0000
Message-ID: <BL0PR02MB56812FE00104090D02A1B1B5CB400@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
 <5f1d4915-27ad-0cdc-a174-98f88f36a762@xilinx.com>
In-Reply-To: <5f1d4915-27ad-0cdc-a174-98f88f36a762@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0df4153-e0b3-4672-b429-08d6ac710089
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4961;
x-ms-traffictypediagnostic: BL0PR02MB4961:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR02MB4961F00663F9AE496168FC45CB400@BL0PR02MB4961.namprd02.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(346002)(396003)(13464003)(189003)(199004)(2501003)(106356001)(66066001)(105586002)(6506007)(8676002)(71190400001)(53546011)(71200400001)(2201001)(2906002)(52536014)(54906003)(6306002)(316002)(86362001)(229853002)(81166006)(68736007)(25786009)(6116002)(9686003)(110136005)(186003)(55016002)(5660300002)(81156014)(3846002)(478600001)(446003)(102836004)(7736002)(53936002)(7696005)(45080400002)(6436002)(966005)(97736004)(486006)(99286004)(14454004)(33656002)(74316002)(76176011)(476003)(26005)(107886003)(256004)(4326008)(11346002)(6346003)(6246003)(305945005)(14444005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4961;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YZ9wxjjk30TnlaG6Hd0FLujfYICKS0d+87Z0C8oFhlAwNfAgogKYEgRSRen6jVLLjcoBZPJzNNN1NJl95LFptTxICgudoai2R/ycZEtufZ2LtbwQbdwuSN4Td3ep59iZh6qjxHsPPrGo+P22EFKy2DrLFUx1I+YIiRCgOmKYQhRnqI0hEA+RPKwZDmcbHmDgJj/wqVHGShKTh9Rkd+2SuqpeTGAMTBwAvQADi7xQiwfYLyEtXYll8ukbNSB7SF6GEO556jIm81onnIS/p5DO5u/ONOIIN42qKboiTb/5PcdrlQ4b1s/KjCkvVw0Z0bn69FqI62mGQm3KouqEyKfYy35IoxUqqn/PjyCAp+3/pxVhMIg+p/PmHUGgF3YQN4XnmnUEkfliYVp6NTRrr1JNorZ52c3zO6Kkgx29trlbXpQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0df4153-e0b3-4672-b429-08d6ac710089
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 13:44:25.7908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIFNpbWVrIFtt
YWlsdG86bWljaGFsLnNpbWVrQHhpbGlueC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXkgMTkgTWFyY2gg
MjAxOSAxMjoxOA0KPiBUbzogRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuY0B4aWxpbnguY29tPjsgYXJu
ZEBhcm5kYi5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IE1pY2hhbCBTaW1layA8bWlj
aGFsc0B4aWxpbnguY29tPjsgbGludXgtDQo+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGVyZWsgS2llcm5hbiA8ZGtp
ZXJuYW5AeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xMl0gbWlzYzogeGls
aW54IHNkLWZlYyBkcml2ZXINCj4gDQo+IE9uIDE5LiAwMy4gMTkgMTM6MDQsIERyYWdhbiBDdmV0
aWMgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaHNldCBpcyBhZGRpbmcgdGhlIGZ1bGwgU29mdCBEZWNp
c2lvbiBGb3J3YXJkIEVycm9yDQo+ID4gQ29ycmVjdGlvbiAoU0QtRkVDKSBkcml2ZXIgaW1wbGVt
ZW50YXRpb24sIGRyaXZlciBEVCBiaW5kaW5nIGFuZA0KPiA+IGRyaXZlciBkb2N1bWVudGF0aW9u
Lg0KPiA+DQo+ID4gRm9yd2FyZCBFcnJvciBDb3JyZWN0aW9uIChGRUMpIGNvZGVzIHN1Y2ggYXMg
TG93IERlbnNpdHkgUGFyaXR5DQo+ID4gQ2hlY2sgKExEUEMpIGFuZCB0dXJibyBjb2RlcyBwcm92
aWRlIGEgbWVhbnMgdG8gY29udHJvbCBlcnJvcnMgaW4NCj4gPiBkYXRhIHRyYW5zbWlzc2lvbnMg
b3ZlciB1bnJlbGlhYmxlIG9yIG5vaXN5IGNvbW11bmljYXRpb24NCj4gPiBjaGFubmVscy4gVGhl
IFNELUZFQyBJbnRlZ3JhdGVkIEJsb2NrIGlzIGFuIG9wdGltaXplZCBibG9jayBmb3INCj4gPiBz
b2Z0LWRlY2lzaW9uIGRlY29kaW5nIG9mIHRoZXNlIGNvZGVzLiBGaXhlZCB0dXJibyBjb2RlcyBh
cmUNCj4gPiBzdXBwb3J0ZWQgZGlyZWN0bHksIHdoZXJlYXMgY3VzdG9tIGFuZCBzdGFuZGFyZGl6
ZWQgTERQQyBjb2Rlcw0KPiA+IGFyZSBzdXBwb3J0ZWQgdGhyb3VnaCB0aGUgYWJpbGl0eSB0byBz
cGVjaWZ5IHRoZSBwYXJpdHkgY2hlY2sNCj4gPiBtYXRyaXggdGhyb3VnaCBhbiBBWEk0LUxpdGUg
YnVzIG9yIHVzaW5nIHRoZSBvcHRpb25hbCBwcm9ncmFtbWFibGUNCj4gPiAoUEwpLWJhc2VkIHN1
cHBvcnQgbG9naWMuIEZvciB0aGUgZnVydGhlciBpbmZvcm1hdGlvbiBzZWUNCj4gPiBodHRwczov
L3d3dy54aWxpbnguY29tL3N1cHBvcnQvZG9jdW1lbnRhdGlvbi9pcF9kb2N1bWVudGF0aW9uLw0K
PiA+IHNkX2ZlYy92MV8xL3BnMjU2LXNkZmVjLWludGVncmF0ZWQtYmxvY2sucGRmDQo+ID4NCj4g
PiBUaGlzIGRyaXZlciBpcyBhIHBsYXRmb3JtIGRldmljZSBkcml2ZXIgd2hpY2ggc3VwcG9ydHMg
U0RGRUMxNg0KPiA+ICgxNm5tKSBJUC4gU0QtRkVDIGRyaXZlciBzdXBwb3J0cyBMRFBDIGRlY29k
aW5nIGFuZCBlbmNvZGluZyBhbmQNCj4gPiBUdXJibyBjb2RlIGRlY29kaW5nLiBMRFBDIGNvZGVz
IGNhbiBiZSBzcGVjaWZpZWQgb24NCj4gPiBhIGNvZGV3b3JkLWJ5LWNvZGV3b3JkIGJhc2lzLCBh
bHNvIGEgY3VzdG9tIExEUEMgY29kZSBjYW4gYmUgdXNlZC4NCj4gPg0KPiA+IFRoZSBTRC1GRUMg
ZHJpdmVyIGV4cG9zZXMgYSBjaGFyIGRldmljZSBpbnRlcmZhY2UgYW5kIHN1cHBvcnRzDQo+ID4g
ZmlsZSBvcGVyYXRpb25zOiBvcGVuKCksIGNsb3NlKCksIHBvbGwoKSBhbmQgaW9jdGwoKS4gVGhl
IGRyaXZlcg0KPiA+IGFsbG93cyBvbmx5IG9uZSB1c2FnZSBvZiB0aGUgZGV2aWNlLCBvcGVuKCkg
bGltaXRzIHRoZSBudW1iZXIgb2YNCj4gPiBkcml2ZXIgaW5zdGFuY2VzLiBUaGUgZHJpdmVyIGFs
c28gdXRpbGl6ZSBDb21tb24gQ2xvY2sgRnJhbWV3b3JrDQo+ID4gKENDRikuDQo+ID4NCj4gPiBU
aGUgY29udHJvbCBhbmQgbW9uaXRvcmluZyBpcyBzdXBwb3J0ZWQgb3ZlciBpb2N0bCBzeXN0ZW0g
Y2FsbC4NCj4gPiBUaGUgZmVhdHVyZXMgc3VwcG9ydGVkIGJ5IGlvY3RsKCk6DQo+ID4gLSBlbmFi
bGUgb3IgZGlzYWJsZSBkYXRhIHBpcGVzIHRvL2Zyb20gZGV2aWNlDQo+ID4gLSBjb25maWd1cmUg
dGhlIEZFQyBhbGdvcml0aG0gcGFyYW1ldGVycw0KPiA+IC0gc2V0IHRoZSBvcmRlciBvZiBkYXRh
DQo+ID4gLSBwcm92aWRlIGEgY29udHJvbCBvZiBhIFNERkVDIGJ5cGFzcyBvcHRpb24NCj4gPiAt
IGFjdGl2YXRlcy9kZWFjdGl2YXRlcyBTRC1GRUMNCj4gPiAtIGNvbGxlY3QgYW5kIHByb3ZpZGUg
c3RhdGlzdGljYWwgZGF0YQ0KPiA+IC0gZW5hYmxlL2Rpc2FibGUgaW50ZXJydXB0IG1vZGUNCj4g
Pg0KPiA+IFBvbGwgY2FuIGJlIHV0aWxpemVkIHRvIGRldGVjdCBlcnJvcnMgb24gSVJRIHRyaWdn
ZXIgcmF0aGVyIHRoYW4NCj4gPiB1c2luZyBsb29waW5nIHN0YXR1cyBhbmQgc3RhdHMgaW9jdGwn
cy4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxp
bnguY29tPg0KPiANCj4gSSBhbSBub3QgdXNpbmcgdGhpcyB0YWcgYSBsb3QgdGhhdCdzIHdoeSBJ
IGFtIGN1cmlvdXMgd2hlcmUgeW91IGdvdCBpdA0KPiBmcm9tPyBJIGNhbid0IHNlZSBpdCBpbiBY
aWxpbnggdHJlZSB0b28uDQo+IA0KPiBUaGFua3MsDQo+IE1pY2hhbA0KDQpJdCBpcyBjb3BpZWQg
ZnJvbSB0aGUgZW1haWwgYWRkcmVzcyBpbiBPdXRsb29rLiBJJ2xsIGNvcnJlY3QgdGhpcyB0byBt
aWNoYWxzQHhpbGlueC5jb20uDQoNClRoYW5rcw0KRHJhZ2FuDQo=
