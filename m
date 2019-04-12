Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D481C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF94C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WYe27KJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDLJor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:44:47 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:28182
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726706AbfDLJoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmQG6w9k2bfvLS2tpLiU5DQwt2W/QwwKqyNvqReYG3g=;
 b=WYe27KJJ8XmMmr/B1klAFJqO39031fjzr7yHCxzhTnRjGkD9y/23go7TZG866RgC5Yv29V1v/R3cz9hU4GiPFFJupVzEXdYUHMRrPsYRRBpHz275wPirAsG9YxiX1XJAF1BUOCoa3+533SsdCtGmb611Z8f6LeRd9kvrg/N7CoU=
Received: from DB7PR04MB4425.eurprd04.prod.outlook.com (52.135.137.151) by
 DB7PR04MB4666.eurprd04.prod.outlook.com (52.135.139.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Fri, 12 Apr 2019 09:44:43 +0000
Received: from DB7PR04MB4425.eurprd04.prod.outlook.com
 ([fe80::fcdc:3a1d:1054:1694]) by DB7PR04MB4425.eurprd04.prod.outlook.com
 ([fe80::fcdc:3a1d:1054:1694%2]) with mapi id 15.20.1771.019; Fri, 12 Apr 2019
 09:44:43 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andy Tang <andy.tang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 1/3] dt-bindings: ahci-fsl-qoriq: add ls1028a
 chip name to the list
Thread-Topic: [EXT] Re: [PATCH 1/3] dt-bindings: ahci-fsl-qoriq: add ls1028a
 chip name to the list
Thread-Index: AQHU19vHTy04BhEPRE2kCJGyjPOmVqY2XlcAgAIaaYA=
Date:   Fri, 12 Apr 2019 09:44:43 +0000
Message-ID: <DB7PR04MB4425D4DD8DABA6C07E230EF9ED280@DB7PR04MB4425.eurprd04.prod.outlook.com>
References: <20190311072014.36565-1-peng.ma@nxp.com>
 <20190411013647.GE26817@dragon>
In-Reply-To: <20190411013647.GE26817@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62df4aa7-be4a-42f1-ba02-08d6bf2b7dbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4666;
x-ms-traffictypediagnostic: DB7PR04MB4666:
x-microsoft-antispam-prvs: <DB7PR04MB4666B29692E0DA43B366C2F4ED280@DB7PR04MB4666.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(376002)(136003)(13464003)(189003)(199004)(81156014)(66066001)(105586002)(55016002)(476003)(8936002)(97736004)(54906003)(11346002)(44832011)(478600001)(4326008)(305945005)(26005)(14454004)(102836004)(6506007)(76176011)(106356001)(186003)(74316002)(33656002)(7696005)(25786009)(8676002)(6916009)(229853002)(6116002)(486006)(99286004)(6246003)(2906002)(446003)(6436002)(86362001)(5660300002)(9686003)(4744005)(316002)(52536014)(256004)(81166006)(53936002)(14444005)(71200400001)(68736007)(71190400001)(5024004)(3846002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4666;H:DB7PR04MB4425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HnvLEzoFPv+BNui4Jcgs5D7+Q9zMj4wTY/vXaN6zEcMofKviA6OKCI7WPM7jmEvx3MKY/yAZUMKY/argsZb65zQYOiQc/03kxehw8y8f8dkDGX5HfHHnJ5FgKbps7sBQHof82LqMqtH9JCNB2Tjbxm5ulsEknQnm/iuRxypumtmRvUfAiHp324MgLF0wH1jk6jmpO4ujR9fBRuYaUFGiGYhOZAE1JNQwbK6yIs0dUO2PivXQEkkXqIX0d+MyKtWuueg70xTVw+YdEsRQbvDCYFECr+Yef95mRCVlOkvJGO0M1Y2PTZIirLwioBELcg3xI1uSkCpeMSIZN73/KUmTz+T7vRMmUrd5yAi4Sgz7QSRHMjy/2/j6fpAUSuxqJIIgOAex1NvYOAiVzRPvmrJjdu63vwljf1d9zQcDjTxG+3E=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62df4aa7-be4a-42f1-ba02-08d6bf2b7dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 09:44:43.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4666
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNCk9LLCB0aGFua3MuDQoNCkJlc3QgUmVnYXJkcywNClBlbmcNCg0KPi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPg0KPlNlbnQ6IDIwMTnE6jTUwjExyNUgOTozNw0KPlRvOiBQZW5nIE1hIDxwZW5nLm1hQG54
cC5jb20+DQo+Q2M6IGF4Ym9lQGtlcm5lbC5kazsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsgTGVvIExpDQo+PGxlb3lhbmcubGlAbnhwLmNvbT47IGxpbnV4LWlkZUB2
Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPkFuZHkgVGFuZyA8
YW5keS50YW5nQG54cC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFtFWFRdIFJlOiBbUEFU
Q0ggMS8zXSBkdC1iaW5kaW5nczogYWhjaS1mc2wtcW9yaXE6IGFkZCBsczEwMjhhIGNoaXANCj5u
YW1lIHRvIHRoZSBsaXN0DQo+DQo+V0FSTklORzogVGhpcyBlbWFpbCB3YXMgY3JlYXRlZCBvdXRz
aWRlIG9mIE5YUC4gRE8gTk9UIENMSUNLIGxpbmtzIG9yDQo+YXR0YWNobWVudHMgdW5sZXNzIHlv
dSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0K
Pg0KPg0KPk9uIE1vbiwgTWFyIDExLCAyMDE5IGF0IDAzOjIwOjEyUE0gKzA4MDAsIFBlbmcgTWEg
d3JvdGU6DQo+PiBBZGQgbHMxMDI4YSBjb21wYXRpYmxlIHRvIGJpbmRpbmdzIGRvY3VtZW50YXRp
b24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPg0K
PkkgYXNzdW1lIHRoYXQgdGhlIGJpbmRpbmdzIHdpbGwgYmUgcGlja2VkIHVwIGJ5IEF4Ym9lLiAg
T3RoZXJ3aXNlLCBwbGVhc2UgbGV0DQo+bWUga25vdy4NCj4NCj5TaGF3bg0K
