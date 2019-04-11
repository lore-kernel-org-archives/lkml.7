Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290E82133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v0hoCYCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDKF1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:27:49 -0400
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:36744
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfDKF1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6oq+z6+5UMf0UiI0JPzkl8E+sTA6bsuPNsVe8TcpMA=;
 b=v0hoCYCKOoIUhOAgnVD7zyFR5OS88bnQTAqio/1Cde3z9pmSbSZyB7aXS8zfPej+h7ddf/cSRvmY9/ByMC97qpYLJ3cGpDDegGCvY+HnaesZRwFZwAHVd3XNlu0Im1oP3WX+ahPjxnUtGMzcMDk8hhEK7NLXKlwLspW/2svG+hw=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2881.eurprd04.prod.outlook.com (10.175.42.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Thu, 11 Apr 2019 05:27:45 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d017:34d9:4a70:bb8]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d017:34d9:4a70:bb8%11]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 05:27:45 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: Add USB dt nodes
Thread-Topic: [PATCH] arm64: dts: ls1028a: Add USB dt nodes
Thread-Index: AQHU8CdKzjxdRL+/Q0qJ+ZTi6U1Ilg==
Date:   Thu, 11 Apr 2019 05:27:44 +0000
Message-ID: <20190411052924.8730-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92e53080-4d45-43c8-b1b7-08d6be3e6ca9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2881;
x-ms-traffictypediagnostic: AM5PR0402MB2881:
x-microsoft-antispam-prvs: <AM5PR0402MB288179AD51F64D479DBA8D56F12F0@AM5PR0402MB2881.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(199004)(189003)(81166006)(6916009)(6486002)(3846002)(54906003)(71200400001)(81156014)(316002)(2616005)(105586002)(8676002)(476003)(4326008)(14454004)(386003)(486006)(6506007)(102836004)(8936002)(66066001)(6116002)(36756003)(5660300002)(86362001)(97736004)(508600001)(50226002)(6436002)(2906002)(25786009)(186003)(6512007)(53936002)(1076003)(7736002)(68736007)(26005)(305945005)(52116002)(99286004)(71190400001)(256004)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2881;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U5dyDNn0XiyE5K/wquQEJuMCDhAcal9Q6P6ywueQAGlC6/nEFKRS9+DL9UnZUGMQXZjVsyMN7+jCSd8G1gOzyrnXjUlr4gsWGq7Xg7hF41yrRMrewlgaj2wADzDbnYgyqjPQ7qQcm0QgmTFljX/1GA+QjB2bX5N/o1+vY8U+D1aQO1TUlCKQOQUAte/qv4jl+JukqquzyrxcgBN1M3WmTOsjldxzg9EtUvvcHOji0njixxaw1z3H2yJsg9t5zlPE9UVzzN/1ndV7IQNkyOTPCZrm7zIbMsKoHlw2HbVfjHH1OohPS5/7qcA2Fflheqrs52q5xq8HIQQudIO9DxAIe5HyN3GjckpkM7TKcLeqlfSw6ogyXCRe9OHHnD8wsPNGCrJh2nWAwALvmuBWNjMCp1E64M53DoS3dXpnogquyPA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e53080-4d45-43c8-b1b7-08d6be3e6ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 05:27:45.0432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIFVTQiBkdCBub2RlcyBmb3IgTFMxMDI4QS4NCg0KU2lnbmVkLW9mZi1i
eTogUmFuIFdhbmcgPHJhbi53YW5nXzFAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgfCAgIDIwICsrKysrKysrKysrKysrKysrKysr
DQogMSBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRz
aSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCmluZGV4
IDhkZDM1MDEuLmQ0YmMzMTQgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHMxMDI4YS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9mc2wtbHMxMDI4YS5kdHNpDQpAQCAtMTQ0LDYgKzE0NCwyNiBAQA0KIAkJCWNsb2NrcyA9IDwm
c3lzY2xrPjsNCiAJCX07DQogDQorCQl1c2IwOnVzYjNAMzEwMDAwMCB7DQorCQkJY29tcGF0aWJs
ZT0gInNucHMsZHdjMyI7DQorCQkJcmVnPSA8MHgwIDB4MzEwMDAwMCAweDAgMHgxMDAwMD47DQor
CQkJaW50ZXJydXB0cz0gPDAgODAgMHg0PjsNCisJCQlkcl9tb2RlPSAiaG9zdCI7DQorCQkJc25w
cyxkaXNfcnhkZXRfaW5wM19xdWlyazsNCisJCQlzbnBzLHF1aXJrLWZyYW1lLWxlbmd0aC1hZGp1
c3RtZW50ID0gPDB4MjA+Ow0KKwkJCXNucHMsaW5jci1idXJzdC10eXBlLWFkanVzdG1lbnQgPSA8
MT4sIDw0PiwgPDg+LCA8MTY+Ow0KKwkJfTsNCisNCisJCXVzYjE6dXNiM0AzMTEwMDAwIHsNCisJ
CQljb21wYXRpYmxlPSAic25wcyxkd2MzIjsNCisJCQlyZWc9IDwweDAgMHgzMTEwMDAwIDB4MCAw
eDEwMDAwPjsNCisJCQlpbnRlcnJ1cHRzPSA8MCA4MSAweDQ+Ow0KKwkJCWRyX21vZGU9ICJob3N0
IjsNCisJCQlzbnBzLGRpc19yeGRldF9pbnAzX3F1aXJrOw0KKwkJCXNucHMscXVpcmstZnJhbWUt
bGVuZ3RoLWFkanVzdG1lbnQgPSA8MHgyMD47DQorCQkJc25wcyxpbmNyLWJ1cnN0LXR5cGUtYWRq
dXN0bWVudCA9IDwxPiwgPDQ+LCA8OD4sIDwxNj47DQorCQl9Ow0KKw0KIAkJaTJjMDogaTJjQDIw
MDAwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAiZnNsLHZmNjEwLWkyYyI7DQogCQkJI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47DQotLSANCjEuNy4xDQoNCg==
