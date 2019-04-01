Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7949C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798EC20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="f4NaQd19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfDAImB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:42:01 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:42250 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfDAImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:42:00 -0400
X-IronPort-AV: E=Sophos;i="5.60,295,1549954800"; 
   d="scan'208";a="30561806"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Apr 2019 01:41:59 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 1 Apr 2019 01:41:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyUuvLvX+IN9qOv5WvUzjhXF+ZmeYQRabUnO447x1+M=;
 b=f4NaQd19IRQLbnRfCyheI2ZkVbzyv77D6+b6T337M9lHPxIN1CVEtFntFuGLxmo9xuj9FD02RzC+xKFI7oKl2CwV9nal11vskC9/0eCeImf0wRvN32GhnE/dcAF/oEW6fdQZlDqGGvifNT+VwRm5qFd7HZeB0JZZ9Kt8U3DejR4=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1615.namprd11.prod.outlook.com (10.172.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 08:41:57 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6%2]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 08:41:57 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] MAINTAINERS: add timer-microchip-pit64c.c
Thread-Topic: [PATCH 5/5] MAINTAINERS: add timer-microchip-pit64c.c
Thread-Index: AQHU6GbDZ0tN4hXmz0O/oJjCEua+ig==
Date:   Mon, 1 Apr 2019 08:41:57 +0000
Message-ID: <e069e024-1295-76d0-ba24-25937499e641@microchip.com>
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-6-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1552580772-8499-6-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0106.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::22) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f4ff1d4-ce44-48cd-41ec-08d6b67de625
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1615;
x-ms-traffictypediagnostic: MWHPR11MB1615:
x-microsoft-antispam-prvs: <MWHPR11MB1615319DE5B78164975BF4B7E0550@MWHPR11MB1615.namprd11.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(136003)(366004)(199004)(189003)(386003)(53936002)(6512007)(110136005)(52116002)(72206003)(106356001)(4744005)(54906003)(2616005)(81156014)(31696002)(2906002)(6486002)(478600001)(71200400001)(36756003)(31686004)(305945005)(76176011)(229853002)(25786009)(8676002)(6246003)(8936002)(7736002)(256004)(71190400001)(81166006)(99286004)(2201001)(476003)(446003)(2501003)(68736007)(11346002)(6436002)(5660300002)(4326008)(186003)(14454004)(6506007)(97736004)(26005)(6116002)(316002)(3846002)(486006)(53546011)(86362001)(102836004)(66066001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1615;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ECrArHMxWZSkQvgUgC0um3ekLtD+1K/LFvfjSk98eJOFmHjkCM5cEfjprFptaXIAL2yGM2vernTqHF1spYHGTrG0gKk6eEgB90wZVtHc1y3YP4y+roF6AWwlau8vGYaIKEDTMWYLj+clXYZEdTNsT9Q5k0fXiOqExGfLBtjCgUM0BAs6ZYOSDKd/oMzaxL7WwQh32KyN+VITFZHYKQFB4lSXOMElhTm3dUZpr0AA4XMZt+ymWOYOVqkqe8tnxgALws2lDFCkP7DVrjTh9s96GvVwjc9ApkUdO/drn5Qcpb14VhCWsKJCvDA/Mx3qe9OflvUuo2uIxPdbPQblJLC1GuQ2ln+ifT5zjLzEVE0/JRMV+9uyL7E6JZs5yq456YJfyKE4OZJushv+fyzlBBF5P9+jw/nSLKxXz57l/uXQi3w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53848906608B764D86069D656426F903@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4ff1d4-ce44-48cd-41ec-08d6b67de625
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 08:41:57.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1615
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDMvMjAxOSBhdCAxNzoyNiwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+
IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gQWRkIHRpbWVyLW1pY3JvY2hpcC1waXQ2NGIuYyBhcyBtYWludGFpbmVkIGZpbGUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCg0KQWNrZWQtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlw
LmNvbT4NCg0KPiAtLS0NCj4gICBNQUlOVEFJTkVSUyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRB
SU5FUlMNCj4gaW5kZXggODViYzgxOTg2N2RhLi41YWY5NDdjOWYzNTAgMTAwNjQ0DQo+IC0tLSBh
L01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0xMDAyMyw2ICsxMDAyMyw3
IEBAIEw6CWxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZyAobW9kZXJhdGVkIGZv
ciBub24tc3Vic2NyaWJlcnMpDQo+ICAgUzoJU3VwcG9ydGVkDQo+ICAgRjoJZHJpdmVycy9taXNj
L2F0bWVsX3RjbGliLmMNCj4gICBGOglkcml2ZXJzL2Nsb2Nrc291cmNlL3RjYl9jbGtzcmMuYw0K
PiArRjoJZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1taWNyb2NoaXAtcGl0NjRiLmMNCj4gICAN
Cj4gICBNSUNST0NISVAgVVNCQSBVREMgRFJJVkVSDQo+ICAgTToJQ3Jpc3RpYW4gQmlyc2FuIDxj
cmlzdGlhbi5iaXJzYW5AbWljcm9jaGlwLmNvbT4NCj4gDQoNCg0KLS0gDQpOaWNvbGFzIEZlcnJl
DQo=
