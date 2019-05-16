Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B697C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D04E2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NS2pIUb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfEPLnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:43:19 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:12085
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728305AbfEPLlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnwYhVnYj8re0iH13rP+gtQeT+7/YKppgyWrUxadBFI=;
 b=NS2pIUb2ja+4QotS8uRzY6nCHBLodxt6nHMBVQ2qMNRcnlDpBFZ8yBrU8gJFwdTVNWYVC9hWnMlFPU9XMNeGyEo3JYGcZ9UHJ1kHmdh5swIvMJFfkzi+F5jOwoeg/8ST3wKgvErnIXgzw/gyrcO+3eB8FW6OAklZnzftFYL1Qw4=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6623.eurprd04.prod.outlook.com (20.179.235.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 11:41:46 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:41:46 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH V4] ASoC: cs42xx8: add reset-gpios in binding
 document
Thread-Topic: [alsa-devel] [PATCH V4] ASoC: cs42xx8: add reset-gpios in
 binding document
Thread-Index: AdUL3ELukXtmb23cTHK77vJAfmhcNw==
Date:   Thu, 16 May 2019 11:41:46 +0000
Message-ID: <VE1PR04MB647937130B57B9C3F818F3DEE30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b45d59d6-3bcf-4e3f-133b-08d6d9f379e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6623;
x-ms-traffictypediagnostic: VE1PR04MB6623:
x-microsoft-antispam-prvs: <VE1PR04MB6623D37932CD57E02FA794BBE30A0@VE1PR04MB6623.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(68736007)(66556008)(316002)(64756008)(74316002)(6916009)(486006)(186003)(3846002)(6116002)(53936002)(66446008)(71200400001)(71190400001)(76116006)(66946007)(26005)(73956011)(54906003)(86362001)(66476007)(478600001)(2906002)(33656002)(5660300002)(25786009)(9686003)(256004)(55016002)(6246003)(99286004)(1411001)(14454004)(229853002)(6436002)(4326008)(7696005)(81166006)(53546011)(6506007)(66066001)(476003)(8936002)(52536014)(102836004)(81156014)(305945005)(8676002)(7736002)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6623;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vQznmZMwgJN60XSsqJ1k0I2e/QwSa4eJzCR7IEE3ZOlFj+Ot5EUg4IFUzdeM1GMeou/nlHpDUoBE0L2LJcRi3KlGjdpy7ilHD94HT626G4wbfex+81uTlEo7O1iWp8O/OnyRNBHm9rfG+8UR6uFrlthbC8NBa8uK8636Wg5ZRKvUlLehGXZnHd7PIViVXwJXSZjTf0P9R491iTwll5u5sRKYcWX/WeTN9liEYMRMh2xCKWit6nU+yz8C0iGe77hiD6y03+SZenTcac92PMdeFamCqVDnzkdZwkPdMTtxkzT8G0QilUMtdTQYa4cFxOxXQc6rdmw12hYKvXEabRLZ/4Nw/i/uvntfWjD3euri+EqnKUye3sTshDpe2kAhSbX9q5Z3X5dloD7phWgj+OaIiAIMU1MprSFgLPOoVZ/PgaE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45d59d6-3bcf-4e3f-133b-08d6d9f379e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:41:46.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KPiBPbiBUaHUsIE1heSAxNiwgMjAxOSBhdCA4OjM2IEFNIFMuai4gV2FuZyA8c2hlbmdq
aXUud2FuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gIGNzNDI4ODg6IGNvZGVjQDQ4IHsN
Cj4gPiBAQCAtMjUsNCArMzAsNSBAQCBjczQyODg4OiBjb2RlY0A0OCB7DQo+ID4gICAgICAgICBW
RC1zdXBwbHkgPSA8JnJlZ19hdWRpbz47DQo+ID4gICAgICAgICBWTFMtc3VwcGx5ID0gPCZyZWdf
YXVkaW8+Ow0KPiA+ICAgICAgICAgVkxDLXN1cHBseSA9IDwmcmVnX2F1ZGlvPjsNCj4gPiArICAg
ICAgIHJlc2V0LWdwaW9zID0gPCZwY2E5NTU3X2IgMSAxPjsNCj4gDQo+ICByZXNldC1ncGlvcyA9
IDwmcGNhOTU1N19iIDEgR1BJT19BQ1RJVkVfTE9XPjsgIHBsZWFzZQ0KT2ssIHNlbnQgdjUuDQoN
CkJlc3QgcmVnYXJkcw0KV2FuZyBzaGVuZ2ppdQ0K
