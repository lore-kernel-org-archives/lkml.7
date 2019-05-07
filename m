Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0BDC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDB320B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hggdLplR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEGGeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:34:31 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:19686
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfEGGe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA90w/6uN7a5+J4+RmdtVnct8pd5HxVkND4MH67bW9U=;
 b=hggdLplRh4MHNXFSbJPZCADwE0TbDh2UCMJY6qkFbpCIFRKjlIYTBBywgbj6QGk7bFE3yS/bPQ/DpxObYDog1kt6I0xugsyALKpjCiFJv3Q6W2od9I06rIzoQVW+g2eGDXtooOvzbGF5I34azfsZpvu5UKGmO+VSpAranNjgeKE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 06:34:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 06:34:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/5] ARM: dts: imx7d-sdb: Assign corresponding power supply
 for LDOs
Thread-Topic: [PATCH 2/5] ARM: dts: imx7d-sdb: Assign corresponding power
 supply for LDOs
Thread-Index: AQHVBJ7peeLpD0EGKkSdoz3HCqEg/Q==
Date:   Tue, 7 May 2019 06:34:24 +0000
Message-ID: <1557210565-4457-2-git-send-email-Anson.Huang@nxp.com>
References: <1557210565-4457-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557210565-4457-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43319bfb-3615-4658-2ec8-08d6d2b60bcb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3771;
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-antispam-prvs: <DB3PR0402MB377103FDE1DB6BC35BEF11C3F5310@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(6486002)(66066001)(68736007)(26005)(386003)(6506007)(186003)(102836004)(86362001)(11346002)(2616005)(446003)(76176011)(110136005)(14454004)(316002)(2201001)(52116002)(2501003)(5660300002)(99286004)(6116002)(2906002)(3846002)(4326008)(6512007)(6436002)(476003)(486006)(25786009)(36756003)(256004)(53936002)(305945005)(66476007)(66556008)(64756008)(66446008)(50226002)(478600001)(81156014)(81166006)(8676002)(8936002)(4744005)(71190400001)(7736002)(73956011)(66946007)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZDw9oSll+D3ZO0fBJUeDpfnQwo3IBIZ6a6OzqIfaRyD5DjEBLo1QsfejKS3ALX2kF7+j+Cov1i7jGQqnr2NoC3nwhZa8nnvL0WA1uQl3QOd6C4lqCAui0cEITwVKofjQ7kaZYuAabuQgMZRegU2cB89EzgnIuWM8dcTSghsoWHiZ1d4E9c41rdCmPPrz04YlqCWp+aDNn/p60YgUV5kPiZIWtVWPUf/TMNn3qtOgHFXQMACTBt5rWaGjE0wTewrkpSoPKDjCu4XhX2Q2wVtcsbzAJtBXUITbyQ+4tjrgXlOtXB9BiQx1t0/4G2JlOGSYJ9ksGymZvMvaUX45VpI6USizr7FubPxkAdqPExrsjF/h59bnawtKUQ0d20C+g8qvJ8tiIt0LrFuoAyuooJ1KRGmQDGL2qWa38o9sem1DjfE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43319bfb-3615-4658-2ec8-08d6d2b60bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 06:34:24.9063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gaS5NWDdEIFNEQiBib2FyZCwgc3cyIHN1cHBsaWVzIDFwMGQvMXAyIExETywgdGhpcyBwYXRj
aCBhc3NpZ25zDQpjb3JyZXNwb25kaW5nIHBvd2VyIHN1cHBseSBmb3IgMXAwZC8xcDIgTERPIHRv
IGF2b2lkIGNvbmZ1c2lvbiBieQ0KYmVsb3cgbG9nOg0KDQp2ZGQxcDBkOiBzdXBwbGllZCBieSBy
ZWd1bGF0b3ItZHVtbXkNCnZkZDFwMjogc3VwcGxpZWQgYnkgcmVndWxhdG9yLWR1bW15DQoNCldp
dGggdGhpcyBwYXRjaCwgdGhlIHBvd2VyIHN1cHBseSBpcyBtb3JlIGFjY3VyYXRlOg0KDQp2ZGQx
cDBkOiBzdXBwbGllZCBieSBTVzINCnZkZDFwMjogc3VwcGxpZWQgYnkgU1cyDQoNClNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm0v
Ym9vdC9kdHMvaW14N2Qtc2RiLmR0cyB8IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg3ZC1zZGIu
ZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2Qtc2RiLmR0cw0KaW5kZXggMjAyOTIyZS4uZWZj
ODNiYyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDdkLXNkYi5kdHMNCisrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDdkLXNkYi5kdHMNCkBAIC0zNzksNiArMzc5LDE0IEBADQog
CXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KIA0KKyZyZWdfMXAwZCB7DQorCXZpbi1zdXBwbHkgPSA8
JnN3Ml9yZWc+Ow0KK307DQorDQorJnJlZ18xcDIgew0KKwl2aW4tc3VwcGx5ID0gPCZzdzJfcmVn
PjsNCit9Ow0KKw0KICZ1YXJ0MSB7DQogCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogCXBp
bmN0cmwtMCA9IDwmcGluY3RybF91YXJ0MT47DQotLSANCjIuNy40DQoNCg==
