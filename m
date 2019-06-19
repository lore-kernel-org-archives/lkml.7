Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E0BC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4170020823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jVZh7i5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfFSIkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:40:41 -0400
Received: from mail-eopbgr700044.outbound.protection.outlook.com ([40.107.70.44]:30561
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730418AbfFSIkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7U/WCR6BCULOmh2jJCdOpnjjteIdVUj4zPU1ANIguI=;
 b=jVZh7i5NjX+XHpub3gy5uDEqk8U0RbIcXJJWgYBtoKJJ9NNkQdA8ncMS39IrgeM5o3jT/NYGPvqADDfkbLc6fnzxQz0sPjvNXCZfuPBxN42YSFI/s4r+9GLr+TNcOEKQzpjyExpILvDQ9Uu4bA7d2a0uXUFvKtW2D58DVeCB4rU=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (10.255.7.10) by
 MN2PR02MB6272.namprd02.prod.outlook.com (52.132.174.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 19 Jun 2019 08:40:37 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::e55a:e2d1:953f:ed3b]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::e55a:e2d1:953f:ed3b%4]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 08:40:37 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michals@xilinx.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Thread-Topic: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP
 Platform Tap Delays Setup
Thread-Index: AQHVIDwWKZKZdF95gUaFGq/oqBvspKafu1mAgAADioCAAA8FAIAC5Ktw
Date:   Wed, 19 Jun 2019 08:40:36 +0000
Message-ID: <MN2PR02MB6029DB87CEE32655B0F1E794C1E50@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com>
 <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
In-Reply-To: <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17b2548e-1602-416c-380e-08d6f491cd5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR02MB6272;
x-ms-traffictypediagnostic: MN2PR02MB6272:
x-microsoft-antispam-prvs: <MN2PR02MB6272111C0B1426BF54177471C1E50@MN2PR02MB6272.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(51444003)(13464003)(199004)(189003)(4326008)(256004)(66066001)(71190400001)(71200400001)(5660300002)(8936002)(52536014)(11346002)(7696005)(99286004)(102836004)(476003)(8676002)(4744005)(74316002)(486006)(14454004)(76176011)(81166006)(81156014)(6506007)(446003)(25786009)(478600001)(54906003)(110136005)(86362001)(6636002)(305945005)(55016002)(9686003)(229853002)(7736002)(2906002)(6436002)(53936002)(68736007)(72206003)(186003)(33656002)(3846002)(6116002)(76116006)(66446008)(64756008)(66556008)(66476007)(6246003)(73956011)(316002)(66946007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6272;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WJX/FACNmavOXlyP/KqvQ6DeHtyxcdUETgvD0uaVOMRDD4kCJuO5TzEXv7UADRxVLkUlviMdjn3ejmkDuzxZr+EjHCpe0KLu0ksDFiNLaXKZ4R+lGv5pEiBUHiiflx6VEjBxZuW/9AyVcT+FC2/odtZWRFmFKpmNkdbeHfbSv4M+gg3/muVb0G4yFHwQQxwpM2AOLldQK+HG6vr64K76svaikBy6SMo4/GYk5z8AsPiuOEmQdEJnZCQm108TIXZF4Hy4a7zHTq2BKi5C7VHlmAh0aUPNQXgpkD3h2PvXMXTDyBYZFpCnxAvL98KS42sPx2oRoKZLvkeHNj+IZMjsMxXKXnEGl7a7JBwg2re1xpArLIGiY1lol3cXD9ta6O8S1nNceFBsNxvH8EiVPxTpGjM8YCNuOSRLCodIL2aYPOE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b2548e-1602-416c-380e-08d6f491cd5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 08:40:37.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnarani@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBI
YW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMTcs
IDIwMTkgNTo1MSBQTQ0KWy4uLl0NCj4gDQo+IFRoZSAiY29uc3Qgc3RydWN0IHp5bnFtcF9lZW1p
X29wcyAqZWVtaV9vcHM7IHNob3VsZCB0aGVuIGJlIG1vdmVkIGludG8NCj4gYSBjbG9jayBwcm92
aWRlciBzcGVjaWZpYyBzdHJ1Y3QsIHdoaWNoIGlzIGFzc2lnbmVkIHdoZW4gY2FsbGluZw0KPiBz
ZGhjaV9hcmFzYW5fcmVnaXN0ZXJfc2RjbGsuIEkgdW5kZXJzdGFuZCB0aGF0IGFsbCB0aGUgY2xv
Y2sgZGF0YSBpcw0KPiBmb2xkZWQgaW50byBzdHJ1Y3Qgc2RoY2lfYXJhc2FuX2RhdGEgdG9kYXks
IGJ1dCBJIHRoaW5rIHRoYXQgc2hvdWxkIGJlDQo+IG1vdmVkIGludG8gYSAic3ViLXN0cnVjdCIg
Zm9yIHRoZSBjbG9jayBzcGVjaWZpY3MuDQo+IA0KPiBNb3Jlb3Zlciwgd2hlbiByZWdpc3Rlcmlu
ZyB0aGUgY2xvY2ssIHdlIHNob3VsZCBjb252ZXJ0IGZyb20gdXNpbmcNCj4gZGV2bV9jbGtfcmVn
aXN0ZXIoKSBpbnRvIGRldm1fY2xrX2h3X3JlZ2lzdGVyKCkgYXMgdGhlIGZpcnN0IG9uZSBpcw0K
PiBub3cgZGVwcmVjYXRlZC4NCg0KSnVzdCBhIHF1ZXJ5IGhlcmU6DQpXaGVuIHdlIHN3aXRjaCB0
byB1c2luZyBkZXZtX2Nsa19od19yZWdpc3RlcigpIGhlcmUsIGl0IHdpbGwgcmVnaXN0ZXIgdGhl
IGNsa19odyBhbmQgcmV0dXJuIGludC4NCklzIHRoZXJlIGEgd2F5IHdlIGNhbiBnZXQgdGhlIGNs
ayAocmVsYXRlZCB0byB0aGUgY2xrX2h3IHJlZ2lzdGVyZWQpIGZyb20gdGhlDQpjbG9jayBmcmFt
ZXdvcms/DQpJIGFtIGFza2luZyB0aGlzIGJlY2F1c2Ugd2Ugd2lsbCBuZWVkIHRoYXQgY2xrIHBv
aW50ZXIgd2hpbGUgY2FsbGluZyBjbGtfc2V0X3BoYXNlKCkgZnVuY3Rpb24uDQoNClRoYW5rcywN
Ck1hbmlzaA0K
