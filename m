Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88509C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5142186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KmKlQvnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfCAKJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:09:32 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:45520 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfCAKJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:09:31 -0500
X-IronPort-AV: E=Sophos;i="5.58,427,1544511600"; 
   d="scan'208";a="25445212"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 01 Mar 2019 03:09:31 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Mar 2019 03:09:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0NVVGRFKHsGo0L3Z8u+tHa58DefkjX4CRzgxHaLBag=;
 b=KmKlQvnD7XGJVkUxoKLdZCIMY44qlsB+an6wWz2xm89ojoS9HDT53sh1h5teS9yAn2pch7a6Bv3ogVQYmWgGRHvGa5DenR3BAE3w2GbA3J56h+SMmBNUTs4ZGdjt/4gMnXKosdSaSvVTNFa04oB/+v1IH8dsgI0XyYnUTdKYHps=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB0079.namprd11.prod.outlook.com (10.164.204.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Fri, 1 Mar 2019 10:09:26 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 10:09:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sam@ravnborg.org>, <alexandre.belloni@bootlin.com>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <thierry.reding@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/7] add LCD support for SAM9X60
Thread-Topic: [PATCH 0/7] add LCD support for SAM9X60
Thread-Index: AQHUzrje9T8RC8FLgkilJXdcaQrjR6X1h1qAgAAqKwCAAAXrgIAA2MMA
Date:   Fri, 1 Mar 2019 10:09:26 +0000
Message-ID: <9ca1bee4-a2b8-6a0f-2d75-857b9096eabe@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <20190228182119.GA28318@ravnborg.org> <20190228205214.GD23094@piout.net>
 <20190228211325.GA30188@ravnborg.org>
In-Reply-To: <20190228211325.GA30188@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0069.eurprd02.prod.outlook.com
 (2603:10a6:802:14::40) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190301120914881
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 355eeec9-64cb-4a5d-a034-08d69e2dfc48
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB0079;
x-ms-traffictypediagnostic: MWHPR11MB0079:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIwMDc5OzIzOi9SRnN5dXg3NFVNbnJlK21ZbDhmNms5WjBw?=
 =?utf-8?B?RUJ0TVpwTDBISXB5NldwVzRyMVJ6ZFVjeWhWODQrK3hIeUE2MFdSMGtBSTRJ?=
 =?utf-8?B?Q0JUNFdvVGN1UEp4N2szUnNzbkhnWnY2Z0d3QVNEOW5LYTVDY3pqbEtmbkdJ?=
 =?utf-8?B?L2did3IwMkNPMlROUlJTcXIwM0x6dHJ4R3NxZnMrVG9JT2tIMEswN21rYnpo?=
 =?utf-8?B?UFBDbDdqYlhFeHVNNkR0aW5saDZ4RVJGNDArSDRvdzVwdzFNcEZ3RHV0eG1G?=
 =?utf-8?B?MWtpUTJkTWpuWUExdzVtczV5SUFNL3ZQbGk4b2xoTU9qWDB2U3NFMHUxWXB5?=
 =?utf-8?B?WXhXREdzY2hBeFgrUW1TNTRDbmFWdi83R0lwOFhQZ0hwNWwvMjlTTTZBQm05?=
 =?utf-8?B?QWtDa1hXclFIOERZOE5zL1c2ZEJzNVBVOTR4dmdYSzlreTl1MVJuVU5JU0Jq?=
 =?utf-8?B?Z00rOFdCODBlbHJydWVreVhlMXZCU0poek1DYkNGK0VERlVJb2t0YXlWc2lm?=
 =?utf-8?B?ZlhyeUxjTTViVTJlS3JFTHFYNE83R3lZWkk5SUJqcnllNlFEZDJrd3BNWldF?=
 =?utf-8?B?WE5tZG8raE81cldwVXpTSUk4NXlHZkQ4TXdKM2FYNzBpS0RXNkNwZEtSS2VR?=
 =?utf-8?B?d1ltd0hZZzhNcmVmQkdNVnQ0Qi90cjFucmRkTFBIbTcxZzdYME1kMVE2MlNu?=
 =?utf-8?B?bUFHZmZoVStxYXZTMEl3NFRwaVVRR3c4RC9hR0RXR1ozY0UxNXc1bkRMazNq?=
 =?utf-8?B?Q3p0b3B5Ty9VUFJoc3R2RFRGNzlqQUdvUnVKL2kyMWZ2TjFNdnNqVHJxenQz?=
 =?utf-8?B?Q0tqVzFzWVlweGJzbVlxRDlDZktEY3JFNG9kTlpiUnRoNGpLK3AyUnQ3RjU3?=
 =?utf-8?B?ZnNNc0VrM3dMR1lLS0tHVzRyOXE4aTF2Y09Cbm8wZDlOTVU5OTZ2U0E1OWpK?=
 =?utf-8?B?enptVjloOHFLNHFrdXdmTW41UXJDS0ZFT1IrNkxzemsvQU1ZNHF3UUxBdG03?=
 =?utf-8?B?dHNFQ3RuTW15YUpncUI2WFA3SmVwcCtQTmw3TmQ4bTV2OUdlc3JlR3VtNWxv?=
 =?utf-8?B?TFE5VDVKYlJNazdqWE52blhoUERUQkN0YjR0bXc5ZkxLb05PYWQ5Rkt5VUhB?=
 =?utf-8?B?emFMQXg2b2wwSU9NU3dNVXo1WVZjeUt4Z1lnOGdTN1JXWUNsQnNCZ1F5WnVs?=
 =?utf-8?B?ZVJneXZlUlI5dzI5VUJyQytlRjhXeTdkbW45WnhjdFliNTh0NDAxOFRyNWFo?=
 =?utf-8?B?R2VBSEl2dm5wK1NiYnBuTmJCbyt0K3VEeFJuRWxheHAwNUs5Nk1CWkdWNXBQ?=
 =?utf-8?B?djVVTXlkalFWbzdmNWR6WmJtZ1JCdjJSNjZjcVNnbVk1S2NFOW1RUVdnQ1lE?=
 =?utf-8?B?N24vWGV3QThEY0x1c242MldVVFpXL1ZFeXgrN1V4L3ZqTkRrNGQrQUNZUTlB?=
 =?utf-8?B?bjNSUDBJQjExNlJWWU5PejN4Y0ZlZjJMQXE5VEVGQ0dkYXp0L2diL28xME04?=
 =?utf-8?B?UnZINUgraU1LRm9kaEx3SERJQmRGWG5PMmZRVGlPNGVqMDBsTDVXSFd3dG92?=
 =?utf-8?B?akFPZHNQLzNld0wvS05mbkJtNFltL0l1N1hCWVYyUVBtN3RlY1p4Vkk3ZUhm?=
 =?utf-8?B?a1Z0UEkvNU1Bd05VVUplU2paQXVBSDB0NmhBN1hLcTE0dkFja1Z1NmcvUjVI?=
 =?utf-8?B?UGVUbm5tTGM1RklCQUcycUFLeUJaNnlZa1dRUlp0bUNrMm45VFBYSGRtRmlU?=
 =?utf-8?B?RFBwa05GSHRvVkFSUW50enJBQ1VhZW9ZRnQ3RHFHY3dueGJtN00wYlppVEtu?=
 =?utf-8?B?eTVLYXZ4TW8xMHZxQkpua1dBWHdBSk1iUEtsOGVFdFp3V0FsU2JDbFYrQlRy?=
 =?utf-8?Q?Op67LvtJjxc=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB00794CC3AC4E7BFD4B700FDA87760@MWHPR11MB0079.namprd11.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(136003)(199004)(189003)(256004)(6512007)(72206003)(2906002)(476003)(4326008)(14454004)(11346002)(486006)(3846002)(6116002)(25786009)(478600001)(6486002)(6436002)(446003)(53936002)(2616005)(76176011)(6246003)(6346003)(52116002)(26005)(316002)(102836004)(6506007)(186003)(229853002)(386003)(86362001)(53546011)(110136005)(54906003)(31696002)(71190400001)(36756003)(71200400001)(31686004)(8676002)(81156014)(81166006)(4744005)(8936002)(68736007)(7736002)(305945005)(5660300002)(106356001)(93886005)(105586002)(97736004)(7416002)(66066001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB0079;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kFEf2YTrZiLZUkg5CJx8/UV+fT3DkmylFAKx8NMcL3wF9SoHoX/XjmO9Mh3bDHb1mpOSOgUN4+AN9QZK8yFFubje8kbGANAD8qiSwcDVteWAdAId81MKs621Go94hIjcbRSOL8K4xd62opNSy/Zx9dyLmS5AHTmUywEE744DVsEakiU2zMDsFmpmyDmt75m8vvrt3i1zZjnH62dz0wV7qZmJQ/zWpymZ0gazffyaY2KdyTto9dFUAWGvCIldszoOm5zNQB9QAbcgsdQvi8RnxNFMVqd+M9ISJRRxRtvO8bgw0PDPRinJ3h0iclyBHefzBgxZs4f2AP2PZM+URoE38K1QVOWpl+M0sSc7qtXg86WSe4evbxuLvlTJdE1Kl8GdYSJQYK9uuuwwinrEwYoLK3hVe6cfrmmVHadgjb/c+/M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA669EBF19CAF24BBEE2053E638DEB34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 355eeec9-64cb-4a5d-a034-08d69e2dfc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 10:09:21.5929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0079
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI4LjAyLjIwMTkgMjM6MTMsIFNhbSBSYXZuYm9yZyB3cm90ZToNCj4gSGkgQWxleGFu
ZHJlLg0KPiANCj4+Pj4NCj4+Pj4gVGhlc2UgcGF0Y2hlcyBhZGRzIHN1cHBvcnQgZm9yIFNBTTlY
NjAncyBMQ0QgY29udHJvbGxlci4NCj4+PiBDYW4geW91IGVsYWJvcmF0ZSBhIGxpdHRsZSBtb3Jl
IHdoaWNoIGNoaXBzIHRoYXQgYXJlIHJlbGV2YW50Lg0KPj4+IFRvIGJlIGFibGUgdG8gbG9vayBp
bnRvIHRoZSByaWdodCBkYXRhLXNoZWV0LCB3aGlsZSByZXZpZXdpbmcuDQo+Pj4gTGluayB0byBk
YXRhLXNoZWV0IHdvdWxkIGJlIG5pY2UgdG9vLg0KPj4+DQo+Pg0KPj4gc2FtOXg2MCBpcyB0aGUg
Y2hpcCBuYW1lIChpLmUuIHggaXMgbm90IGEgd2lsZGNhcmQpLiBJIGRvbid0IHRoaW5rIHRoZQ0K
Pj4gZGF0YXNoZWV0IGlzIGZpbmlzaGVkL3B1YmxpYyB5ZXQuDQo+IA0KPiBUaGFua3MuIEkgd2ls
bCB0YWtlIGEgbG9vayBhdCB0aGUgcGF0Y2hlcyBidXQgbm90IGtub3dpbmcNCj4gdGhlIHNwZWNp
ZmljcyBvZiB0aGUgaW1wbGVtZW50YXRpb24vSVAgd2lsbCBtYWtlcyB0aGlzIGxlc3MgdmFsdWVh
YmxlLg0KDQpBdCB0aGlzIG1vbWVudCwgYXMgQWxleGFuZHJlIHNwZWNpZmllZCwgdGhlIGRhdGFz
aGVldCBpcyBub3QgcHVibGlzaGVkLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+
IA0KPiAJU2FtDQo+IA0K
