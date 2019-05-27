Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95646C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6511D20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d92dV9tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfE0McO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:32:14 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:31973
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbfE0McN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2kJI0bnG9vYr0Dv9257snPjYQvX9ItSIa4yQA+mCIM=;
 b=d92dV9trSMT2+SZZPIkNJpScsjAckfJfG/kczhdZwMFCjYpQXW4UyrQ7c0775y+267QIuF+4NgJsduZszmPD8SZeICQykA7zjFTYSCcs1dPaP12ycO8jdZmHluz8QzKO/pjZ8g9g1z7Ccqo97C1rHzvbP1dlZCyL7fFcDAC4Uok=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB5094.eurprd04.prod.outlook.com (20.177.34.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Mon, 27 May 2019 12:32:10 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21%4]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 12:32:10 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: nxp: Add device tree binding for
 ls1046a-frwy board
Thread-Topic: [PATCH v3 1/3] dt-bindings: arm: nxp: Add device tree binding
 for ls1046a-frwy board
Thread-Index: AQHVFIg0u8rP+y8vIUS+R5uZRTBHUg==
Date:   Mon, 27 May 2019 12:32:09 +0000
Message-ID: <20190527123404.30858-2-pramod.kumar_1@nxp.com>
References: <20190527123404.30858-1-pramod.kumar_1@nxp.com>
In-Reply-To: <20190527123404.30858-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: PN1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::17) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: befd1599-33e1-40f4-7af5-08d6e29f5422
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5094;
x-ms-traffictypediagnostic: AM6PR04MB5094:
x-microsoft-antispam-prvs: <AM6PR04MB5094608403A6C181DF9BAA34F61D0@AM6PR04MB5094.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(189003)(99286004)(25786009)(1076003)(478600001)(256004)(7736002)(6116002)(316002)(6486002)(36756003)(71200400001)(81156014)(81166006)(71190400001)(50226002)(5660300002)(66066001)(6436002)(2501003)(305945005)(66476007)(3846002)(14454004)(4744005)(8676002)(6636002)(8936002)(486006)(102836004)(386003)(6506007)(6512007)(4326008)(2616005)(476003)(68736007)(2201001)(2906002)(86362001)(446003)(11346002)(73956011)(66946007)(53936002)(66556008)(64756008)(66446008)(110136005)(76176011)(52116002)(186003)(26005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5094;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LcFUiFF1+UNSb/Y0XEY5u/cptOoP+ygCHO0Wl8OCgkSnANEbTCIoqNuZCnwO5d7ApMgRh9hm+S2Wet2zNxjExFUA7b+L0cAl/5i0hTjrx1NugxJyrLAwSNMJ822Y1SIyyTb+wAb07do5byJZgE8k+vzfG31PGyF/eFF5J40JPfy8ogtFdiORvRsi8ZvRVqf2ZZhZX7AjlbhapxClmMXdcm+FUJ3mVdQIwT73wKub3hN2Y9ioal+9CAW/aQph072bFOlgExGHugw/NTT356YHa+WBI5/bQezjnU6Pq4PA2bPPE5F7366tbmM8QWOPWloOywe4hp/Mw1fn/uGDtALgfuhgPxsrBJ9oQyEcFmMeZY76mV2cp1FqHdnjWDAzp/irGnF+kbh9O68S/O+5o+XT+oU7GqZSgd92Jlz4uB8fTlA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befd1599-33e1-40f4-7af5-08d6e29f5422
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 12:32:09.9582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pramod.kumar_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICJmc2wsbHMxMDQ2YS1mcnd5IiBiaW5kaW5ncyBmb3IgbHMxMDQ2YWZyd3kgYm9hcmQgYmFz
ZWQgb24gbHMxMDQ2YSBTb0MNCg0KU2lnbmVkLW9mZi1ieTogVmFiaGF2IFNoYXJtYSA8dmFiaGF2
LnNoYXJtYUBueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogUHJhbW9kIEt1bWFyIDxwcmFtb2Qua3Vt
YXJfMUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sIHwg
MSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KaW5kZXggNDA3MTM4ZWJjMGQwLi4w
OWZmMTk5OWNlOTYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2ZzbC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZzbC55YW1sDQpAQCAtMjQxLDYgKzI0MSw3IEBAIHByb3BlcnRpZXM6DQogICAgICAgICAg
IC0gZW51bToNCiAgICAgICAgICAgICAgIC0gZnNsLGxzMTA0NmEtcWRzDQogICAgICAgICAgICAg
ICAtIGZzbCxsczEwNDZhLXJkYg0KKyAgICAgICAgICAgICAgLSBmc2wsbHMxMDQ2YS1mcnd5DQog
ICAgICAgICAgIC0gY29uc3Q6IGZzbCxsczEwNDZhDQogDQogICAgICAgLSBkZXNjcmlwdGlvbjog
TFMxMDg4QSBiYXNlZCBCb2FyZHMNCi0tIA0KMi4xNy4xDQoNCg==
