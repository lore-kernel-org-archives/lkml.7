Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3496CC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66D22171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Q3WhLu9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfDSXQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:16:37 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:51699
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfDSXQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCc1FCfttFI6lfSZg+wnobflej/6edaPTpyTxa/lBzo=;
 b=Q3WhLu9nRjaVb1TFpuX1cGeuidTKFqCA3wohoiKdWmJ5MNg6lTjPGU9EkQW3l0pgZKGXnzy6/km0YKScV482SbKPFN/mcQoiu6MJNvwDJybrU0Ac6bUqNfj8D3+k+Lc8at7kQgNdIvgVrpz27zdWSzMw8eCVGdM9vo/hueeFYeg=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB5961.eurprd05.prod.outlook.com (20.179.9.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 23:16:31 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::85d8:bf39:8cc9:16c3]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::85d8:bf39:8cc9:16c3%3]) with mapi id 15.20.1813.017; Fri, 19 Apr 2019
 23:16:31 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH] net/mlx5e: remove meaningless CFLAGS_tracepoint.o
Thread-Topic: [PATCH] net/mlx5e: remove meaningless CFLAGS_tracepoint.o
Thread-Index: AQHU9m9GLpbM1sMbuUmRaArHRkzJu6ZEHveA
Date:   Fri, 19 Apr 2019 23:16:31 +0000
Message-ID: <d938a56a3350fba18bd23f43efb582835c90c94d.camel@mellanox.com>
References: <20190419051731.15111-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190419051731.15111-1-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c6cf811-4375-48f6-5b16-08d6c51d0f04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR05MB5961;
x-ms-traffictypediagnostic: DB8PR05MB5961:
x-microsoft-antispam-prvs: <DB8PR05MB59619BDF120AB1E0B0810227BE270@DB8PR05MB5961.eurprd05.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(76176011)(6512007)(6506007)(5640700003)(102836004)(4744005)(256004)(305945005)(7736002)(6116002)(3846002)(11346002)(446003)(476003)(2616005)(486006)(186003)(5660300002)(6486002)(6436002)(26005)(68736007)(229853002)(71200400001)(71190400001)(99286004)(118296001)(2501003)(36756003)(8936002)(66066001)(14454004)(478600001)(97736004)(2351001)(4326008)(81166006)(81156014)(316002)(8676002)(2906002)(86362001)(58126008)(66946007)(66476007)(66556008)(73956011)(66446008)(6246003)(64756008)(53936002)(54906003)(91956017)(76116006)(25786009)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB5961;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9+XPlKNkOr1EUmcMFlXDylKc/j5vxn5FeONK3KJPd663TsamwXaC3peOZg/Vi+MLt1XY80qJ69YQTJ8/m1ABfCHHP6EyW55NDpXFTwyXFqCv83IHp1OirXarBg60LwmJINhEg2tvPUH+g4/Tga23pQAerfihs/tiUCApVOnG+tmaA08Fazn0/aQgQwUQT8tBloiUxj0LuHHdJsQqKNNKNZ1FASzRJRYzXF6s8xKv+j+WLc3UL2fFdl0rR+u/14y7yZnMl4ox7Pfvjneucx73+bLSQTU7qJp+G2ydMiLDfCktHqLZ+7P4145gFROktNOx5KBPeqJnjgsnC8Ik3IeT2QL7wKNpGa/MqRDVu3x3WDqeAS9qgh39ayWwoed0cNSRfSfKPQGagv7hGQjsUXJG/UT34lYLv+1hJ07L4YodFrU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <493D3B4CCE26FB4EA6A41ACDFCF00A0C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6cf811-4375-48f6-5b16-08d6c51d0f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 23:16:31.4890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA0LTE5IGF0IDE0OjE3ICswOTAwLCBNYXNhaGlybyBZYW1hZGEgd3JvdGU6
DQo+IENGTEFHU190cmFjZXBvaW50Lm8gc3BlY2lmaWVzIENGTEFHUyBmb3IgY29tcGlsaW5nIHRy
YWNlcG9pbnQuYyBidXQNCj4gaXQgZG9lcyBub3QgZXhpc3QgdW5kZXIgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlLy4NCj4gDQo+IENGTEFHU190cmFjZXBvaW50Lm8gaXMg
dW51c2VkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFz
YWhpcm9Ac29jaW9uZXh0LmNvbT4NCj4gLS0tDQo+IA0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL01ha2VmaWxlIHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVs
bGFub3gvbWx4NS9jb3JlL01ha2VmaWxlDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL01ha2VmaWxlDQo+IGluZGV4IDFhMTZmNmQ3M2NiYy4uZmExMmMyY2E5ZmM1
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUv
TWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3Jl
L01ha2VmaWxlDQo+IEBAIC01Nyw1ICs1NywzIEBAIG1seDVfY29yZS0kKENPTkZJR19NTFg1X0VO
X0lQU0VDKSArPQ0KPiBlbl9hY2NlbC9pcHNlYy5vIGVuX2FjY2VsL2lwc2VjX3J4dHgubyBcDQo+
ICAJCQkJICAgICBlbl9hY2NlbC9pcHNlY19zdGF0cy5vDQo+ICANCj4gIG1seDVfY29yZS0kKENP
TkZJR19NTFg1X0VOX1RMUykgKz0gZW5fYWNjZWwvdGxzLm8NCj4gZW5fYWNjZWwvdGxzX3J4dHgu
byBlbl9hY2NlbC90bHNfc3RhdHMubw0KPiAtDQo+IC1DRkxBR1NfdHJhY2Vwb2ludC5vIDo9IC1J
JChzcmMpDQoNCkxHVE0sIGFwcGxpZWQgdG8gbWx4NSBicmFuY2gsIHdpbGwgYmUgc2VudCB1cHN0
cmVhbSBzaG9ydGx5Lg0KDQpUaGFua3MsDQpTYWVlZC4NCg==
