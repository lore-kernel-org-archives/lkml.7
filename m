Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE7C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49242082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r+JZxqWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfEPLad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:30:33 -0400
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:2564
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727272AbfEPLad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hub1zZE2GfW78Kz6Chiv3DyaboE3Yx5yn0x8pllICXE=;
 b=r+JZxqWVLfN9ZNKBn7QMSDVWwjWwYk4IRkSN/bmT5THexlox0AWbjMTsCxg18lYQQ+ue/QXukJXE1gur+5XpR9GY6RZ0IPaopJkIh5H4+mNQF1JjZXi2g56lncTJk6wpQd/stUFQfO31o2RJ9ekTO1sspntmY8fR2SQXV8Bj3as=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6477.eurprd04.prod.outlook.com (20.179.233.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 11:30:29 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:30:29 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH RESEND V3] ASoC: cs42xx8: add reset-gpio in
 binding document
Thread-Topic: [EXT] Re: [PATCH RESEND V3] ASoC: cs42xx8: add reset-gpio in
 binding document
Thread-Index: AQHVC9njdHFVpoMQJkaGKICvqNXQ+aZtnRMAgAAAPHA=
Date:   Thu, 16 May 2019 11:30:29 +0000
Message-ID: <VE1PR04MB6479D0799A49E0C6E685F6A7E30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <c2118efa4ee6c915473060405805e6c6c6db681f.1558005661.git.shengjiu.wang@nxp.com>
 <20190516112748.GF5598@sirena.org.uk>
In-Reply-To: <20190516112748.GF5598@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a102101-bb39-4b40-f354-08d6d9f1e66e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6477;
x-ms-traffictypediagnostic: VE1PR04MB6477:
x-microsoft-antispam-prvs: <VE1PR04MB6477CE054B16EF33846ACA89E30A0@VE1PR04MB6477.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(5660300002)(4744005)(71190400001)(86362001)(14444005)(478600001)(53936002)(4326008)(6246003)(52536014)(14454004)(71200400001)(256004)(486006)(316002)(55016002)(7736002)(8936002)(33656002)(3846002)(6116002)(26005)(7696005)(73956011)(476003)(446003)(66446008)(11346002)(64756008)(66946007)(9686003)(76116006)(66556008)(68736007)(66476007)(99286004)(6916009)(2906002)(74316002)(6506007)(186003)(25786009)(102836004)(66066001)(76176011)(6436002)(81166006)(81156014)(8676002)(305945005)(54906003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6477;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ausIBwZlOrrNyAIjekMnHhR7ZQJSzBXhYdta3l42bSumH8Tud+37uRxrHGkvrrII0Bn3qi2AXHn0QnenvniaWKUvG6VFfP8HePgwzAUM8vpcDK17gRxb7WoigYRX3g4vV3FoqtRHHevaiPI1ylt6+9g9bkPPZNLzLqX1WJkabAJJh0WFqAFJJePTw3acA5e2u+z+UXbALAuvVFOs9pCcKbgE1w2zyXZ/ACn77ulVIdyrxyy002uqIGZXmnmaAW1jKypLX1+75Hu2bqvJyZcyZKaNx0KQ/B6qlZOcPtspKs5OlzRJFb7MI1PRM2L2Tqm7LxN+/1xWg696TisZykTOvLlFICBDfhjJccOOR+Fe4gpfXdtWHZT9pcBY44+png9WlmBo0++GZHXD65zdmHBrHw9e2yo32+1OH7w4zPQeLFU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a102101-bb39-4b40-f354-08d6d9f1e66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:30:29.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaQ0KDQo+IA0KPiA+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICsNCj4gPiArICAtIHJl
c2V0LWdwaW8gOiBhIEdQSU8gc3BlYyB0byBkZWZpbmUgd2hpY2ggcGluIGlzIGNvbm5lY3RlZCB0
byB0aGUgY2hpcCdzDQo+ID4gKyAgICAhUkVTRVQgcGluDQo+IA0KPiBncGlvIHByb3BlcnRpZXMg
YXJlIHN1cHBvc2VkIHRvIGJlIGNhbGxlZCAtZ3Bpb3MgZXZlbiBpZiB0aGVyZSdzIGEgc2luZ2xl
DQo+IEdQSU8gcG9zc2libGUgZHVlIHRvIERUIHJ1bGVzLiAgVGhlIGNvZGUgd2lsbCBhY2NlcHQg
cGxhaW4gLWdwaW8gYnV0IHRoZQ0KPiBkb2N1bWVudGF0aW9uIHNob3VsZCBzYXkgZ3Bpb3MuDQpP
aywgd2lsbCB1cGRhdGUgaW4gdjQg8J+Yig0KDQpCZXN0IHJlZ2FyZHMNCldhbmcgc2hlbmdqaXUN
Cg==
