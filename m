Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B9BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5D42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iSPqysmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfCSNzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:55:38 -0400
Received: from mail-eopbgr800080.outbound.protection.outlook.com ([40.107.80.80]:24704
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfCSNzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJaHzcIsVr12YcH9Odvn5EbzKtQFtzB9y2kprPWvoFM=;
 b=iSPqysmuiH0WJoHji0+mIdvg7gXPDMRiI34Wud4FGASw44Pw/JIYRiPWEH8/NNPJGoxbD1gO1ZG2aRbSgIEKT8KxzVpwq+S8uQZ1/SM2uRJcJLlMBStlo0b/g5NacGAq5gUKDovrPQiYMcDyOzoJ6l/9n6z1SJH0NL6Sg/s5VKc=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB4947.namprd02.prod.outlook.com (52.132.14.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 13:55:32 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::dc07:4b0:4a82:392a%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 13:55:32 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Michal Simek <michals@xilinx.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH 00/12] misc: xilinx sd-fec driver
Thread-Topic: [PATCH 00/12] misc: xilinx sd-fec driver
Thread-Index: AQHU3kvsu+uLIqR4m069yWggySo2BaYS3vGAgAAXsFCAAAJ0gIAAAMBg
Date:   Tue, 19 Mar 2019 13:55:32 +0000
Message-ID: <BL0PR02MB5681EAE893965806808A442CCB400@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
 <5f1d4915-27ad-0cdc-a174-98f88f36a762@xilinx.com>
 <BL0PR02MB56812FE00104090D02A1B1B5CB400@BL0PR02MB5681.namprd02.prod.outlook.com>
 <fadca342-1ef6-97e7-1399-929dbf5b69f2@xilinx.com>
In-Reply-To: <fadca342-1ef6-97e7-1399-929dbf5b69f2@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26f7892b-264e-466d-90c0-08d6ac728de6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4947;
x-ms-traffictypediagnostic: BL0PR02MB4947:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR02MB49479E485C0924D800327F1FCB400@BL0PR02MB4947.namprd02.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(13464003)(199004)(189003)(2201001)(6116002)(3846002)(45080400002)(102836004)(26005)(186003)(52536014)(4326008)(81166006)(2501003)(6246003)(8676002)(8936002)(25786009)(66066001)(107886003)(86362001)(81156014)(14454004)(93886005)(74316002)(54906003)(305945005)(99286004)(7696005)(7736002)(68736007)(71200400001)(229853002)(5660300002)(446003)(966005)(11346002)(476003)(76176011)(53936002)(6436002)(486006)(106356001)(2906002)(6506007)(478600001)(105586002)(33656002)(55016002)(6306002)(53546011)(9686003)(71190400001)(97736004)(256004)(14444005)(316002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4947;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XoOz4ETkk5hQdLltNQPn0jVo2O1/WdXfu5ve9MyT8cBFKiB79TtsJ1xsypDe/DfJEE3vayoLUSkCkIBUG2C9s4XdQ1qZP9dwycPQEUtspIs+FKVLNIHHXHM8KB+uIo4rnAj3qc3LU/Z5kh+aZiFmVk/KEBmM9deHzp/pLqxRbeAUM+qmB8rKcCYdVRKm7uOLnhdarU9jWAX22i0c6KhRxuVN3jHWP9BHvqEiohjeWWZk/+RRC3QGKayhNNcYgY+n/hY4wxKh6OlnVmi7FeRrkDCVbq0gFjdYW4+yY5+CBN4ud/B0ug4WM5ti1XOug+hSfEIfmNn3NRm9SPkZvl3nMRtOcEfWmehK+tlJBb5t2KJS1ThEv6TBi9QJbbvkUeYGxGlysM0kjGa8mCPdmu1o/t9Gzg7iA1F+UGuyMVM1hXE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f7892b-264e-466d-90c0-08d6ac728de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 13:55:32.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIFNpbWVrIFtt
YWlsdG86bWljaGFsLnNpbWVrQHhpbGlueC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXkgMTkgTWFyY2gg
MjAxOSAxMzo1MQ0KPiBUbzogRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuY0B4aWxpbnguY29tPjsgYXJu
ZEBhcm5kYi5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
RGVyZWsgS2llcm5hbiA8ZGtpZXJuYW5AeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAwMC8xMl0gbWlzYzogeGlsaW54IHNkLWZlYyBkcml2ZXINCj4gDQo+IE9uIDE5LiAwMy4gMTkg
MTQ6NDQsIERyYWdhbiBDdmV0aWMgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNaWNoYWwgU2ltZWsgW21haWx0bzptaWNoYWwuc2lt
ZWtAeGlsaW54LmNvbV0NCj4gPj4gU2VudDogVHVlc2RheSAxOSBNYXJjaCAyMDE5IDEyOjE4DQo+
ID4+IFRvOiBEcmFnYW4gQ3ZldGljIDxkcmFnYW5jQHhpbGlueC5jb20+OyBhcm5kQGFybmRiLmRl
OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlu
eC5jb20+Ow0KPiBsaW51eC0NCj4gPj4gYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
ID4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEZXJlayBLaWVybmFuIDxka2ll
cm5hbkB4aWxpbnguY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEyXSBtaXNjOiB4
aWxpbnggc2QtZmVjIGRyaXZlcg0KPiA+Pg0KPiA+PiBPbiAxOS4gMDMuIDE5IDEzOjA0LCBEcmFn
YW4gQ3ZldGljIHdyb3RlOg0KPiA+Pj4gVGhpcyBwYXRjaHNldCBpcyBhZGRpbmcgdGhlIGZ1bGwg
U29mdCBEZWNpc2lvbiBGb3J3YXJkIEVycm9yDQo+ID4+PiBDb3JyZWN0aW9uIChTRC1GRUMpIGRy
aXZlciBpbXBsZW1lbnRhdGlvbiwgZHJpdmVyIERUIGJpbmRpbmcgYW5kDQo+ID4+PiBkcml2ZXIg
ZG9jdW1lbnRhdGlvbi4NCj4gPj4+DQo+ID4+PiBGb3J3YXJkIEVycm9yIENvcnJlY3Rpb24gKEZF
QykgY29kZXMgc3VjaCBhcyBMb3cgRGVuc2l0eSBQYXJpdHkNCj4gPj4+IENoZWNrIChMRFBDKSBh
bmQgdHVyYm8gY29kZXMgcHJvdmlkZSBhIG1lYW5zIHRvIGNvbnRyb2wgZXJyb3JzIGluDQo+ID4+
PiBkYXRhIHRyYW5zbWlzc2lvbnMgb3ZlciB1bnJlbGlhYmxlIG9yIG5vaXN5IGNvbW11bmljYXRp
b24NCj4gPj4+IGNoYW5uZWxzLiBUaGUgU0QtRkVDIEludGVncmF0ZWQgQmxvY2sgaXMgYW4gb3B0
aW1pemVkIGJsb2NrIGZvcg0KPiA+Pj4gc29mdC1kZWNpc2lvbiBkZWNvZGluZyBvZiB0aGVzZSBj
b2Rlcy4gRml4ZWQgdHVyYm8gY29kZXMgYXJlDQo+ID4+PiBzdXBwb3J0ZWQgZGlyZWN0bHksIHdo
ZXJlYXMgY3VzdG9tIGFuZCBzdGFuZGFyZGl6ZWQgTERQQyBjb2Rlcw0KPiA+Pj4gYXJlIHN1cHBv
cnRlZCB0aHJvdWdoIHRoZSBhYmlsaXR5IHRvIHNwZWNpZnkgdGhlIHBhcml0eSBjaGVjaw0KPiA+
Pj4gbWF0cml4IHRocm91Z2ggYW4gQVhJNC1MaXRlIGJ1cyBvciB1c2luZyB0aGUgb3B0aW9uYWwg
cHJvZ3JhbW1hYmxlDQo+ID4+PiAoUEwpLWJhc2VkIHN1cHBvcnQgbG9naWMuIEZvciB0aGUgZnVy
dGhlciBpbmZvcm1hdGlvbiBzZWUNCj4gPj4+IGh0dHBzOi8vd3d3LnhpbGlueC5jb20vc3VwcG9y
dC9kb2N1bWVudGF0aW9uL2lwX2RvY3VtZW50YXRpb24vDQo+ID4+PiBzZF9mZWMvdjFfMS9wZzI1
Ni1zZGZlYy1pbnRlZ3JhdGVkLWJsb2NrLnBkZg0KPiA+Pj4NCj4gPj4+IFRoaXMgZHJpdmVyIGlz
IGEgcGxhdGZvcm0gZGV2aWNlIGRyaXZlciB3aGljaCBzdXBwb3J0cyBTREZFQzE2DQo+ID4+PiAo
MTZubSkgSVAuIFNELUZFQyBkcml2ZXIgc3VwcG9ydHMgTERQQyBkZWNvZGluZyBhbmQgZW5jb2Rp
bmcgYW5kDQo+ID4+PiBUdXJibyBjb2RlIGRlY29kaW5nLiBMRFBDIGNvZGVzIGNhbiBiZSBzcGVj
aWZpZWQgb24NCj4gPj4+IGEgY29kZXdvcmQtYnktY29kZXdvcmQgYmFzaXMsIGFsc28gYSBjdXN0
b20gTERQQyBjb2RlIGNhbiBiZSB1c2VkLg0KPiA+Pj4NCj4gPj4+IFRoZSBTRC1GRUMgZHJpdmVy
IGV4cG9zZXMgYSBjaGFyIGRldmljZSBpbnRlcmZhY2UgYW5kIHN1cHBvcnRzDQo+ID4+PiBmaWxl
IG9wZXJhdGlvbnM6IG9wZW4oKSwgY2xvc2UoKSwgcG9sbCgpIGFuZCBpb2N0bCgpLiBUaGUgZHJp
dmVyDQo+ID4+PiBhbGxvd3Mgb25seSBvbmUgdXNhZ2Ugb2YgdGhlIGRldmljZSwgb3BlbigpIGxp
bWl0cyB0aGUgbnVtYmVyIG9mDQo+ID4+PiBkcml2ZXIgaW5zdGFuY2VzLiBUaGUgZHJpdmVyIGFs
c28gdXRpbGl6ZSBDb21tb24gQ2xvY2sgRnJhbWV3b3JrDQo+ID4+PiAoQ0NGKS4NCj4gPj4+DQo+
ID4+PiBUaGUgY29udHJvbCBhbmQgbW9uaXRvcmluZyBpcyBzdXBwb3J0ZWQgb3ZlciBpb2N0bCBz
eXN0ZW0gY2FsbC4NCj4gPj4+IFRoZSBmZWF0dXJlcyBzdXBwb3J0ZWQgYnkgaW9jdGwoKToNCj4g
Pj4+IC0gZW5hYmxlIG9yIGRpc2FibGUgZGF0YSBwaXBlcyB0by9mcm9tIGRldmljZQ0KPiA+Pj4g
LSBjb25maWd1cmUgdGhlIEZFQyBhbGdvcml0aG0gcGFyYW1ldGVycw0KPiA+Pj4gLSBzZXQgdGhl
IG9yZGVyIG9mIGRhdGENCj4gPj4+IC0gcHJvdmlkZSBhIGNvbnRyb2wgb2YgYSBTREZFQyBieXBh
c3Mgb3B0aW9uDQo+ID4+PiAtIGFjdGl2YXRlcy9kZWFjdGl2YXRlcyBTRC1GRUMNCj4gPj4+IC0g
Y29sbGVjdCBhbmQgcHJvdmlkZSBzdGF0aXN0aWNhbCBkYXRhDQo+ID4+PiAtIGVuYWJsZS9kaXNh
YmxlIGludGVycnVwdCBtb2RlDQo+ID4+Pg0KPiA+Pj4gUG9sbCBjYW4gYmUgdXRpbGl6ZWQgdG8g
ZGV0ZWN0IGVycm9ycyBvbiBJUlEgdHJpZ2dlciByYXRoZXIgdGhhbg0KPiA+Pj4gdXNpbmcgbG9v
cGluZyBzdGF0dXMgYW5kIHN0YXRzIGlvY3RsJ3MuDQo+ID4+Pg0KPiA+Pj4gUmV2aWV3ZWQtYnk6
IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+ID4+DQo+ID4+IEkgYW0g
bm90IHVzaW5nIHRoaXMgdGFnIGEgbG90IHRoYXQncyB3aHkgSSBhbSBjdXJpb3VzIHdoZXJlIHlv
dSBnb3QgaXQNCj4gPj4gZnJvbT8gSSBjYW4ndCBzZWUgaXQgaW4gWGlsaW54IHRyZWUgdG9vLg0K
PiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IE1pY2hhbA0KPiA+DQo+ID4gSXQgaXMgY29waWVkIGZy
b20gdGhlIGVtYWlsIGFkZHJlc3MgaW4gT3V0bG9vay4gSSdsbCBjb3JyZWN0IHRoaXMgdG8gbWlj
aGFsc0B4aWxpbnguY29tLg0KPiANCj4gSXQgaXMgbm90IGFib3V0IGVtYWlsIGFkZHJlc3MuIEl0
IGlzIGFib3V0IG1lYW5pbmcgb2YgdGhhdCBsaW5lLg0KPiBJIGhhdmUgbmV2ZXIgZG9uZSBkZWVw
IHJldmlldyBvZiB0aGlzIGRyaXZlciB0aGF0IHlvdSBjYW4gcHV0IGhlcmUgbXkNCj4gdGFnIHRo
YXQgSSBoYXZlIHJldmlld2VkIHRoYXQuDQo+IEl0IG1lYW5zIHlvdSBzaG91bGQgcmVtb3ZlIGFs
bCB0aGVzZSBsaW5lcyBmcm9tIGFsbCBwYXRjaGVzIHdlcmUgeW91IHB1dA0KPiBpdCBiZWNhdXNl
IEkgaGF2ZSBuZXZlciBnYXZlIHlvdSB0aGlzIHRhZy4NCj4gDQo+IFRoYW5rcywNCj4gTWljaGFs
DQoNCkknbGwgcmVtb3ZlIHlvdXIgbmFtZS4NCg0K
