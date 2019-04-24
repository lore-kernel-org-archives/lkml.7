Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E0FC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE3A20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="URlAp4/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfDXAgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:36:24 -0400
Received: from mail-eopbgr750070.outbound.protection.outlook.com ([40.107.75.70]:19086
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727045AbfDXAgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sV7GpRuLDULp47H34k2pVVM9rtvNGzOEk20nGa3rUo=;
 b=URlAp4/39Iq6m1dwh/d1oBhXm4SgsPwjQipI+p4W4i3W1n9TjLAUUCZWL5fk6ibIrvia2+Yl8YDM/80tpwEU+JwMbNJ1fqVgTMiDhZ4qZstxm2kBu+m7W5q6AwaDEJ8Z39tWswFxNiXN1pG5BEjr6mjGtuJxJGfnUKMTLp+s60Y=
Received: from BYAPR05MB5240.namprd05.prod.outlook.com (20.177.231.90) by
 BYAPR05MB4039.namprd05.prod.outlook.com (52.135.199.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.7; Wed, 24 Apr 2019 00:36:20 +0000
Received: from BYAPR05MB5240.namprd05.prod.outlook.com
 ([fe80::51f7:404d:19ec:9e8f]) by BYAPR05MB5240.namprd05.prod.outlook.com
 ([fe80::51f7:404d:19ec:9e8f%6]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 00:36:20 +0000
From:   Deepak Singh Rawat <drawat@vmware.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the drm tree
Thread-Index: AQHU+jPNiTBkBQySEUm7D+nW9oMucaZKdw+A
Date:   Wed, 24 Apr 2019 00:36:19 +0000
Message-ID: <44707352378dcd414b476ec5420db23093fb9351.camel@vmware.com>
References: <20190424102219.48cfdfe2@canb.auug.org.au>
In-Reply-To: <20190424102219.48cfdfe2@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com; 
x-originating-ip: [2601:647:4b01:578f:d19d:7196:2645:8b7a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bafc367f-57fa-49d8-0755-08d6c84cdf1c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB4039;
x-ms-traffictypediagnostic: BYAPR05MB4039:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB4039872D731B8B714C8E6365BA3C0@BYAPR05MB4039.namprd05.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(53754006)(6306002)(6512007)(53936002)(86362001)(2906002)(6246003)(97736004)(81156014)(1730700003)(8676002)(478600001)(8936002)(81166006)(118296001)(966005)(36756003)(6116002)(5660300002)(6486002)(14454004)(68736007)(486006)(6436002)(5640700003)(186003)(476003)(6916009)(11346002)(2616005)(229853002)(46003)(2501003)(64756008)(66476007)(305945005)(76116006)(71200400001)(71190400001)(2351001)(4326008)(99286004)(256004)(316002)(25786009)(4744005)(66446008)(66556008)(6506007)(7736002)(446003)(102836004)(54906003)(66946007)(73956011)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4039;H:BYAPR05MB5240.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E9qUa8p+LQ6VfylBJBweQvi8IlEy81aPkbODE0N8SF0dyq0tk7fv8/o7qAz+PwbxJ8yEplh4LjltD8APiOY977jAWswco+GSIo6RzDtRbamIHnOsnqkfW8iMBzaQdgBmf8VfxGp/b9oQKtgO2UXfIfSCe9Asj37DfukzmWPga70OZC8c5FDCyYYsDQr6w/0T98FACKK6CBEV84sqwcuEV4eJ1aHlsFF34oEcbeX6z5P8tRfoOyGS41jCoyGN2mOjQt4O/kAKNQZeSJ96dC+hRpWJkWg0E0PMSQ9iJd07dEDFUlXvBsiDdxYR1UNh736BOdE15bJm9V1JxT7U1/ctbQM25ppJm41OZo8++BSDdI2ilvDeDfLJSr2bHHH+uD0YWy+ladOftMgHm5Ojs8XrjtiKUcerkJ7OOzFWCbeunLk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <469C9DF9AC2B7A4FA905509A1B3BBD95@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafc367f-57fa-49d8-0755-08d6c84cdf1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 00:36:20.0592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA0LTI0IGF0IDEwOjIyICsxMDAwLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3Rl
Og0KPiBIaSBhbGwsDQo+IA0KPiBDb21taXQNCj4gDQo+ICAgYTlmNThjNDU2ZTlkICgiZHJtL3Zt
d2dmeDogQmUgbW9yZSByZXN0cmljdGl2ZSB3aGVuIGRpcnR5aW5nDQo+IHJlc291cmNlcyIpDQoN
CkhpIFN0ZXBoZW4sDQoNCkFjdHVsbHkgdGhlIFNpZ25lZC1vZmYtYnk6IGlzIG5vdCBtaXNzaW5n
IHNlZSANCg0KaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9kcm0vZHJtL2NvbW1pdC9kcml2
ZXJzL2dwdS9kcm0vdm13Z2Z4P2lkPWE5ZjU4YzQ1NmU5ZGRlNmYyNzJlN2JlNGQ2YmVkNjA3ZmQ3
MDA4YWENCg0KQnkgdGhlIHdheSB0aGVyZSBpcyB0aGUgcGF0dGVyICItLS0iIGJlZm9yZSBTaWdu
ZWQtb2ZmLWJ5Oih3aGljaCBpcw0Kc2FtZSBhcyB1c2VkIGJ5IHBhdGNoIHRvIHNlcGFyYXRlIGRl
c2NyaXB0aW9uIGZyb20gY29kZSkgYW5kIEkgdGhpbmsNCnRoZSBzY3JpcHQgaXMgcmVhZGluZyBv
bmx5IHRpbGwgdGhhdCBwb2ludC4gSSB0aGluayAiLS0tIiBzaG91bGQgbm90IGJlDQp1c2VkIGlu
IHBhdGNoIGRlc2NyaXB0aW9uLg0KDQo+IA0KPiBpcyBtaXNzaW5nIGEgU2lnbmVkLW9mZi1ieSBm
cm9tIGl0cyBjb21taXR0ZXIuDQo+IA0K
