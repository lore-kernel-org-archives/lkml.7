Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA710C4646B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FEB2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qY9hFEcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfFTH6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:58:46 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:13819
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfFTH6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28/DfQmj69Z6uqjM6zHK8PM5DIkd4lBE8I4EpHt1g7Y=;
 b=qY9hFEccYnieVwSuj19aSo1eYZW9MDQXVKr6jr7Eosv7SfGMkrFx5SpZg3LexXMjXX02ebSz8G9SRuL4RCMg0xpP0Ynd3tBwZH/CcMEFa3KuR+4g9I5Lxi8mKNMNTUiyGk3g9WW1Vvp2EeRuS43omPt9PBimu8W7kphczayKG2w=
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com (20.178.123.141) by
 VI1PR04MB4767.eurprd04.prod.outlook.com (20.177.48.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 07:58:41 +0000
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7]) by VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 07:58:41 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [EXT] Re: [PATCH v2 1/2] dt-bindings: display: panel: Add support
 for Raydium RM67191 panel
Thread-Topic: [EXT] Re: [PATCH v2 1/2] dt-bindings: display: panel: Add
 support for Raydium RM67191 panel
Thread-Index: AQHVJdoKMCAlDTVrbEyiFObM0c8qr6ai+BqAgAE4IQA=
Date:   Thu, 20 Jun 2019 07:58:41 +0000
Message-ID: <1561017518.9328.57.camel@nxp.com>
References: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com>
         <1560864646-1468-2-git-send-email-robert.chiras@nxp.com>
         <CAOMZO5DwwL5+V4Eifskk=pKzpceRmk5bvdXNeCzZfU3jVwEhEA@mail.gmail.com>
In-Reply-To: <CAOMZO5DwwL5+V4Eifskk=pKzpceRmk5bvdXNeCzZfU3jVwEhEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 241a3369-c98d-4433-77f5-08d6f5551c5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4767;
x-ms-traffictypediagnostic: VI1PR04MB4767:
x-microsoft-antispam-prvs: <VI1PR04MB47676A062F238E5782C298F7E3E40@VI1PR04MB4767.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(189003)(7736002)(50226002)(7416002)(6486002)(11346002)(6506007)(53546011)(103116003)(2351001)(316002)(5660300002)(1411001)(54906003)(186003)(3846002)(8936002)(478600001)(76176011)(5640700003)(66066001)(66556008)(26005)(1361003)(68736007)(6116002)(66476007)(64756008)(256004)(102836004)(73956011)(25786009)(2906002)(14454004)(6436002)(81156014)(2616005)(76116006)(66446008)(486006)(476003)(4326008)(446003)(44832011)(1730700003)(6246003)(6916009)(81166006)(8676002)(6512007)(86362001)(99286004)(305945005)(71200400001)(36756003)(2501003)(53936002)(66946007)(71190400001)(229853002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4767;H:VI1PR04MB5967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A0+B+FK2ss+zontLuzdgxFulyiAUIDposlhM7kJ1WBL0elExcR06IAzVBDShGjt/l6ZT8Xw9MYABvpGQKHjIbWqylu0uMdnbg1ktDxzgpLHda+Ftj13vUGzmXD5ueyFfsETO7lWFKNBrH9NpfjrlzQjN9K2AwJuXXhHbOqsb7YHzVFtfo2GCMJiO4tyvWLz+DxfjmXT5SnzsoMe4A5Efb9rVyH8RsOPDR4+rXofHi14sKFQQ2YvN31Y1hjwXSxF6eEo9ifgMQdIlppH5/p/0w/fD7ehD0Pe3dowSEhSCdbbgKU1CrmvpQo8oMjSe7Ndr4YItltyUIkpLgTA9Ed4SIlJQRNci40Cgv0eVv6nmZaTdeuxFimwR2eWp3PnXRvtVSIr4PrQpSOkMhMtlIRozdisiH4hl5BLnDu2xlAnDu+g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <358518C615FDE548B9E2869FAA7DB547@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241a3369-c98d-4433-77f5-08d6f5551c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 07:58:41.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: robert.chiras@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWksIDIwMTktMDYtMTkgYXQgMTA6MjEgLTAzMDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+
IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gSGkgUm9iZXJ0LA0KPiANCj4gT24gVHVlLCBKdW4g
MTgsIDIwMTkgYXQgMTA6MzMgQU0gUm9iZXJ0IENoaXJhcyA8cm9iZXJ0LmNoaXJhc0BueHAuY29t
DQo+ID4gd3JvdGU6DQo+IA0KPiA+IA0KPiA+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICst
IHJlc2V0LWdwaW9zOsKgwqDCoMKgwqDCoMKgwqDCoGEgR1BJTyBzcGVjIGZvciB0aGUgUlNUX0Ig
R1BJTyBwaW4NCj4gPiArLSBwaW5jdHJsLTDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaGFuZGxl
IHRvIHRoZSBwaW4gc2V0dGluZ3MgZm9yIHRoZSByZXNldA0KPiA+IHBpbg0KPiA+ICstIHdpZHRo
LW1tOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBoeXNpY2FsIHBhbmVsIHdpZHRoIFttbV0NCj4g
PiArLSBoZWlnaHQtbW06wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBoeXNpY2FsIHBhbmVsIGhlaWdo
dCBbbW1dDQo+ID4gKy0gZGlzcGxheS10aW1pbmdzOsKgwqDCoMKgwqB0aW1pbmdzIGZvciB0aGUg
Y29ubmVjdGVkIHBhbmVsIGFjY29yZGluZw0KPiA+IHRvIFsxXQ0KPiBTdGlsbCBub3QgY29udmlu
Y2VkIHdlIG5lZWQgdGhlICdkaXNwbGF5LXRpbWluZ3MnIHByb3BlcnR5LCBldmVuIGFzDQo+IGFu
DQo+IG9wdGlvbmFsIHByb3BlcnR5LiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgcGFzc2luZyBk
aXNwbGF5IHRpbWluZ3MNCj4gaW4NCj4gdGhlIGRldmljZXRyZWUgaXMgbm90IGVuY291cmFnZWQu
DQo+IA0KPiBMYXN0IHRpbWUgeW91IHNhaWQgeW91IG5lZWQgdG8gcGFzcyAnJ2Rpc3BsYXktdGlt
aW5ncycgdG8gd29ya2Fyb3VuZA0KPiB0aGUgcHJvYmxlbSBvZiBjb25uZWN0aW5nIHRoaXMgcGFu
ZWwgdG8gbXg4bSBEQ1NTIG9yIGVMQ0RJRi4NCj4gDQo+IFRoZSBwYW5lbCB0aW1pbmdzIGNvbWUg
ZnJvbSB0aGUgTENEIG1hbnVmYWN0dXJlciBhbmQgaXQgaXMgYWdub3N0aWMNCj4gdG8NCj4gd2hh
dCBkaXNwbGF5IGNvbnRyb2xsZXIgaW50ZXJmYWNlIGl0IGlzIGNvbm5lY3RlZCB0by4NCj4gDQo+
IFNvIEkgc3VnZ2VzdCBtYWtpbmcgc3VyZSB0aGUgdGltaW5ncyBwYXNzZWQgaW4gdGhlIGRyaXZl
ciBhcmUgY29ycmVjdA0KPiBhcyBwZXIgdGhlIHZlbmRvciBkYXRhc2hlZXQuIElmIHRoZXkgYXJl
IGNvcnJlY3QgYW5kIG9uZSBzcGVjaWZpYw0KPiBpbnRlcmZhY2UgaXMgbm90IGFibGUgdG8gZHJp
dmUgaXQsIHRoZW4gcHJvYmFibHkgaXQgaXMgYSBidWcgaW4gdGhpcw0KPiBzcGVjaWZpYyBkaXNw
bGF5IGNvbnRyb2xsZXIgaW50ZXJmYWNlIG9yIGluIHRoZSBTb0MgY2xvY2sgZHJpdmVyLg0KDQpJ
IHVuZGVyc3RhbmQuIEkgd2lsbCByZW1vdmUgdGhlIGRpc3BsYXktdGltaW5ncyBmcm9tIGR0IGFu
ZCBhbHNvIGZyb20NCmRyaXZlci4gQ3VycmVudGx5LCB0aGlzIHBhbmVsIHdvcmtzIGluIHRoaXMg
Zm9ybSB3aXRoIGJvdGggTENESUYgYW5kDQpEQ1NTIG9uIG91ciA4TSBTb0Mgc28sIGFzIHlvdSBz
YWlkLCBwcm9iYWJseSB0aGUgaXNzdWUgd2Ugd2VyZSBzZWVpbmcNCmluIG91ciB0cmVlIHdhcyBj
b21pbmcgZnJvbSBlbHNld2hlcmUu
