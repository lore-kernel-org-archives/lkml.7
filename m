Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12214C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B0C21721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="F7qU8W2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGAVNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:13:42 -0400
Received: from mail-eopbgr820045.outbound.protection.outlook.com ([40.107.82.45]:3536
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfGAVNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMFR3i3THOPzgS89RB5Oh3siHHrKgG8DK9ESuPmhX6Q=;
 b=F7qU8W2GnSN8ZbdxmVj+9mJRrqObiYR29ZCjI/tSjTxJKPFGIThxxesjncg94plZ4vbz4imeg6HZqHzzuRBH2dbM5C9PyaQblRm+vE/G6rLPN2jJIVOk5VOTkjcK1MN26ncey5tfzdh0LWynehZB1qSBw7St/VJjpqJLfj9Cfbg=
Received: from BY5PR05MB6883.namprd05.prod.outlook.com (52.132.255.33) by
 BY5PR05MB6803.namprd05.prod.outlook.com (52.133.252.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.14; Mon, 1 Jul 2019 21:13:30 +0000
Received: from BY5PR05MB6883.namprd05.prod.outlook.com
 ([fe80::584a:a3a6:b340:a43a]) by BY5PR05MB6883.namprd05.prod.outlook.com
 ([fe80::584a:a3a6:b340:a43a%2]) with mapi id 15.20.2052.010; Mon, 1 Jul 2019
 21:13:30 +0000
From:   Deepak Singh Rawat <drawat@vmware.com>
To:     Colin King <colin.king@canonical.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] drm/vmwgfx: remove redundant assignment to sub_res
Thread-Topic: [PATCH][next] drm/vmwgfx: remove redundant assignment to sub_res
Thread-Index: AQHVKt5wIJVpf9QUkUa3BxdGaPrsIKa2Ti8A
Date:   Mon, 1 Jul 2019 21:13:30 +0000
Message-ID: <4fbbedfdb26eee7f21d8d681ce9d56a881f41c92.camel@vmware.com>
References: <20190624224444.14099-1-colin.king@canonical.com>
In-Reply-To: <20190624224444.14099-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To BY5PR05MB6883.namprd05.prod.outlook.com
 (2603:10b6:a03:1c9::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2daaadb9-97c4-4f8f-102a-08d6fe68f760
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR05MB6803;
x-ms-traffictypediagnostic: BY5PR05MB6803:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BY5PR05MB68031443285AD6D4194C713BBAF90@BY5PR05MB6803.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:336;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(6246003)(68736007)(52116002)(26005)(99286004)(6436002)(14454004)(102836004)(3846002)(6116002)(186003)(25786009)(6486002)(76176011)(36756003)(53936002)(110136005)(4326008)(14444005)(256004)(66066001)(386003)(6512007)(6506007)(5660300002)(73956011)(446003)(2501003)(66946007)(8936002)(11346002)(50226002)(66476007)(316002)(66556008)(54906003)(71190400001)(486006)(71200400001)(478600001)(8676002)(64756008)(66446008)(81166006)(2616005)(2906002)(476003)(229853002)(81156014)(86362001)(118296001)(305945005)(7736002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR05MB6803;H:BY5PR05MB6883.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hoRIwVbzUNepfF8Us9S8U7/07t2Bwzxtou7a/zrgZ/HC3oVFrIf/Bd3I+RExqGMhZB+tBqc3zjh/CZcfoMW64uHKYMBVVzXOGGGgbu45HjYJoG+LGu5CxGeEpwnaPVdw1mInKN3sFNzr+SsEy8yNr+q2k3j/wasgsNMLdjFQuxHxgPXkHPWLdhfH32ko/wjz3FNzNPStRP5aHlaBDkzG7JZVBog9iRzvj3B6CsBT1wzMMK+WMdGSlCxz6EIZ1EIOAT4ZuIW412FeiQ2FveNL/rpT+uK0dGNQRYkTK4Fze60gLENITh/ButS/11/e/dBosqb68lak9rGmRnW+HBnsINOh0nl+emGY7sDBcC1WbW4ven0QoZgIgPJ09bpBlb6qHWvSd/2qTRXnEvhb+m0Uzmp5gfJm4iNdo7hiTyfqtcA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE59BA881CCFC5499B6C35AB41867D72@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daaadb9-97c4-4f8f-102a-08d6fe68f760
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 21:13:30.3688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drawat@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB6803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNClJldmlld2VkLWJ5OiBEZWVwYWsgUmF3YXQgPGRyYXdhdEB2bXdhcmUuY29t
Pg0KDQpUaGFua3MsDQpEZWVwYWsNCg0KDQpPbiBNb24sIDIwMTktMDYtMjQgYXQgMjM6NDQgKzAx
MDAsIENvbGluIEtpbmcgd3JvdGU6DQo+IEZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5n
QGNhbm9uaWNhbC5jb20+DQo+IA0KPiBWYXJpYWJsZSBzdWJfcmVzIGlzIGluaXRpYWxpemVkIHRv
IGEgdmFsdWUgdGhhdCBpcyBuZXZlciByZWFkIGFuZCBpdA0KPiBpcyByZS1hc3NpZ25lZCBsYXRl
ciBpbiBhIGZvci1sb29wLiAgVGhlIGluaXRpYWxpemF0aW9uIGlzIHJlZHVuZGFudA0KPiBhbmQg
Y2FuIGJlIHJlbW92ZWQuDQo+IA0KPiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgiVW51c2VkIHZhbHVl
IikNCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2Fs
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9zdXJmYWNlLmMg
fCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9zdXJmYWNl
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9zdXJmYWNlLmMNCj4gaW5kZXgg
ODYyY2E0NDY4MGNhLi4zMjU3YmE2ODlkOTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS92bXdnZngvdm13Z2Z4X3N1cmZhY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4
L3Ztd2dmeF9zdXJmYWNlLmMNCj4gQEAgLTE5MTQsNyArMTkxNCw3IEBAIHN0YXRpYyB2b2lkDQo+
IHZtd19zdXJmYWNlX3RleF9kaXJ0eV9yYW5nZV9hZGQoc3RydWN0IHZtd19yZXNvdXJjZSAqcmVz
LA0KPiAgCX0gZWxzZSB7DQo+ICAJCS8qIERpcnR5IHJhbmdlIGNvdmVycyBtdWx0aXBsZSBzdWIt
cmVzb3VyY2VzICovDQo+ICAJCXN0cnVjdCBzdmdhM2RzdXJmYWNlX2xvYyBsb2NfbWluLCBsb2Nf
bWF4Ow0KPiAtCQl1MzIgc3ViX3JlcyA9IGxvYzEuc3ViX3Jlc291cmNlOw0KPiArCQl1MzIgc3Vi
X3JlczsNCj4gIA0KPiAgCQlzdmdhM2RzdXJmYWNlX21heF9sb2MoY2FjaGUsIGxvYzEuc3ViX3Jl
c291cmNlLA0KPiAmbG9jX21heCk7DQo+ICAJCXZtd19zdWJyZXNfZGlydHlfYWRkKGRpcnR5LCAm
bG9jMSwgJmxvY19tYXgpOw0KDQo=
