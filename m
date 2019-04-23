Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9D2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2B7217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yjGQzUpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfDWORw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:17:52 -0400
Received: from mail-eopbgr750088.outbound.protection.outlook.com ([40.107.75.88]:11927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbfDWORv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox6z4DkW9br0FKwyEj/CDh+N1MPJYWJ0C5FpQkqKoeg=;
 b=yjGQzUpt/U0vGjzzwj12H2vxSzPxfcKrjjhSmgmrL5FRZ1K4MQq/nFJeDASps5MfAkS4y7K/zhGD8nx/SG6XqiJJungjmtfOqbl3X5jIWirBJmnhTvGzLSVEcKdxEYUgJAkPUde5vkxJIfmY7yTkRKgYLc3cYFjGaNRniVCGnSc=
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1374.namprd12.prod.outlook.com (10.169.206.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Tue, 23 Apr 2019 14:17:47 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::4c32:d1c8:5d7b:61f4]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::4c32:d1c8:5d7b:61f4%10]) with mapi id 15.20.1813.017; Tue, 23 Apr
 2019 14:17:47 +0000
From:   "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To:     =?utf-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        Eric Anholt <eric@anholt.net>, Pixel Ding <Pixel.Ding@amd.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sched: Fix description of drm_sched_stop
Thread-Topic: [PATCH] drm/sched: Fix description of drm_sched_stop
Thread-Index: AQHU93fK909SI2G9Tk6zZZyM5U1AlKZJz7KA
Date:   Tue, 23 Apr 2019 14:17:47 +0000
Message-ID: <8c7c1779-2617-58be-83c5-5145b0edd7fa@amd.com>
References: <20190420125053.32150-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190420125053.32150-1-j.neuschaefer@gmx.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::16) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe1339bb-662d-417f-34de-08d6c7f675b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MWHPR12MB1374;
x-ms-traffictypediagnostic: MWHPR12MB1374:
x-microsoft-antispam-prvs: <MWHPR12MB13749BE24AA7EF87E9440CE3EA230@MWHPR12MB1374.namprd12.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(4326008)(66066001)(305945005)(52116002)(256004)(36756003)(25786009)(54906003)(6486002)(81166006)(8676002)(68736007)(81156014)(99286004)(6246003)(86362001)(31696002)(5660300002)(66556008)(6436002)(6506007)(73956011)(110136005)(66476007)(64756008)(386003)(66446008)(7736002)(76176011)(2501003)(66946007)(26005)(31686004)(53936002)(186003)(3846002)(102836004)(478600001)(8936002)(316002)(2616005)(6116002)(14454004)(6512007)(2906002)(72206003)(71190400001)(71200400001)(229853002)(11346002)(446003)(476003)(97736004)(486006)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1374;H:MWHPR12MB1453.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8nScMYoPN942T/cfV49HPMeA8txfZxf3u7hnpR726ebjfqmgxDQx0OSFmxZJvC7oIiDTwY5EyAx02hn29mVoZiy1qh0brACWsvORj5g6l2EQ2MEXynSpMhpJgoOJKEmQLVTcflhUY5uldnaNfNS6uzXvc9iqQgiCkqPEXGd25VeiYdTXj4sUrmh+0pIDmNcqDuWJX42q0WyM8HRdOG911pM7D/gQ9cBXcM52H3yFxkfWUHhu18LEbOiyXf6t3toDayuXeB5Xk+Scacb9sRyJgaXWQWMBgsk5imIhn+MybqyFMH36hHwtA/fAUa01C+qEz+ju/oeRMCdDvHW3EIvVxoHzqfrfnnySckeA15i4cHto/lTpcPCd0DW+RHpMm8rf492GYWMtuLRkNQtXf4+fnwfHdo+NDbfgbcV+RDSJleo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3F7E6E0327796438E569D17ECD58F7D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1339bb-662d-417f-34de-08d6c7f675b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 14:17:47.5326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
Pg0KDQpBbmRyZXkNCg0KT24gNC8yMC8xOSA4OjUwIEFNLCBKb25hdGhhbiBOZXVzY2jDpGZlciB3
cm90ZToNCj4gU2luY2UgY29tbWl0IDIyMmI1ZjA0NDE1OSAoImRybS9zY2hlZDogUmVmYWN0b3Ig
cmluZyBtaXJyb3IgbGlzdA0KPiBoYW5kbGluZy4iKSwgZHJtX3NjaGVkX2h3X2pvYl9yZXNldCBp
cyBubyBsb25nZXIgdGhlcmUsIHNvIGxldCdzIGFkanVzdA0KPiB0aGUgZG9jIGNvbW1lbnQgYWNj
b3JkaW5nbHkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIE5ldXNjaMOkZmVyIDxqLm5l
dXNjaGFlZmVyQGdteC5uZXQ+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIv
c2NoZWRfbWFpbi5jIHwgMyArLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX21haW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5j
DQo+IGluZGV4IDE5ZmM2MDFjOWVlYi4uYTFiZWMyNzc5ZTc2IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYw0KPiBAQCAtMzY2LDEwICszNjYsOSBAQCB2b2lkIGRy
bV9zY2hlZF9pbmNyZWFzZV9rYXJtYShzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKQ0KPiAgIEVY
UE9SVF9TWU1CT0woZHJtX3NjaGVkX2luY3JlYXNlX2thcm1hKTsNCj4NCj4gICAvKioNCj4gLSAq
IGRybV9zY2hlZF9od19qb2JfcmVzZXQgLSBzdG9wIHRoZSBzY2hlZHVsZXIgaWYgaXQgY29udGFp
bnMgdGhlIGJhZCBqb2INCj4gKyAqIGRybV9zY2hlZF9zdG9wIC0gc3RvcCB0aGUgc2NoZWR1bGVy
DQo+ICAgICoNCj4gICAgKiBAc2NoZWQ6IHNjaGVkdWxlciBpbnN0YW5jZQ0KPiAtICogQGJhZDog
YmFkIHNjaGVkdWxlciBqb2INCj4gICAgKg0KPiAgICAqLw0KPiAgIHZvaWQgZHJtX3NjaGVkX3N0
b3Aoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkNCj4gLS0NCj4gMi4yMC4xDQo+DQo=
