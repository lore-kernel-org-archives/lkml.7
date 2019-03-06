Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE66C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95645206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="nKad1hKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCFXQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:16:23 -0500
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:32096
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfCFXQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p//tVxMFQGuR2Ph88SW+yEwAvcpnaNHEyj9vdDTKGTw=;
 b=nKad1hKhYFmgfDeQEyukY5hYe3KAAJTYRa6NIGbNxsJazNy/XcsNJaWuHPp7gz+9shTUl/muF7NuuQOrJKoTEqp6ytpaaC+tA08l1m57zfOQ2xrM/7bDDi3BzC/EOUwfizyuOwN0k+aWD99kONAXqAjRYr3wrMqC0UymxbVXNmo=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4592.eurprd02.prod.outlook.com (20.178.12.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 23:15:51 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 23:15:51 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
Subject: [PATCH v2 4/5] dt-bindings: i2c: pca9541: extend with compatible for
 PCA9641
Thread-Topic: [PATCH v2 4/5] dt-bindings: i2c: pca9541: extend with compatible
 for PCA9641
Thread-Index: AQHU1HKKVkVlIpSgmk6zf8PZhXb1zw==
Date:   Wed, 6 Mar 2019 23:15:50 +0000
Message-ID: <20190306231521.29367-5-peda@axentia.se>
References: <20190306231521.29367-1-peda@axentia.se>
In-Reply-To: <20190306231521.29367-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8aa5df9-e3ac-4f94-e8bb-08d6a289ac7c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4592;
x-ms-traffictypediagnostic: VI1PR02MB4592:
x-microsoft-antispam-prvs: <VI1PR02MB459295ACC8E9526392018D0CBC730@VI1PR02MB4592.eurprd02.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(136003)(39840400004)(189003)(199004)(5640700003)(53936002)(6486002)(71200400001)(6436002)(2501003)(71190400001)(99286004)(4326008)(6916009)(476003)(102836004)(76176011)(256004)(446003)(486006)(52116002)(3846002)(86362001)(386003)(74482002)(6506007)(6512007)(26005)(6116002)(97736004)(66066001)(305945005)(7736002)(2351001)(186003)(2616005)(11346002)(25786009)(106356001)(36756003)(8936002)(8676002)(68736007)(81156014)(81166006)(5660300002)(508600001)(2906002)(54906003)(1076003)(4744005)(50226002)(316002)(14454004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4592;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR02MB4592;23:/7jmNrbJxRotkWj6yKWysOIAnyy+0Lig96r4bcJ?=
 =?iso-8859-1?Q?hgD30ZTUsd5PHdhMFe3RaMdIT9428IC19IgPd8+2SsKzUIJ0gd52SPlfIJ?=
 =?iso-8859-1?Q?dPgqKRvU1eWYoQXsdaLJPdzvTHbJl4Xm0BQWE/7LKL+ji8w8j4e8WF4JT1?=
 =?iso-8859-1?Q?o7WUutAeXjPEJWm9H0SfmHA8qG/N9Sipr6IVIf9vF3c0V+vNrL3EWJfPqV?=
 =?iso-8859-1?Q?tikSR6wWQTQkfhoPwJR5hwokuyq/KbKIfwm14WNSyMOihmBBU9lIjUAmW6?=
 =?iso-8859-1?Q?4W/zYa/xMi5NZPUNqccQjHsl9PAR89L9QiQJyJqBK8slDgsBUeOASTmVBl?=
 =?iso-8859-1?Q?SJCYWn33fRmV6XApC9ZbE7eEKKca2c6qnk0UhWKC0+tA829JTJOrq5DuBI?=
 =?iso-8859-1?Q?A3hwXjfWSoZsmwEuAfW7hdZzC0mf4Gzu/b7Z6bsq+eUNa7+HtkRwlQ5enn?=
 =?iso-8859-1?Q?XF9sU9KF1lZJgFtz5kjrBnu99Z+xowCZmtQOnl47sguvf0gByzeZTGRkto?=
 =?iso-8859-1?Q?TrFpU/kH8CD5af2kbaFCtyrtsRrQJgApP6eDjIo5tdxCcvebcsswtU5ObF?=
 =?iso-8859-1?Q?8VKzDO9bt0v9i7IQwE7xNOH8ip+soyxKvCY0yRIO9OmvLsYo7ruAs2Chu2?=
 =?iso-8859-1?Q?ZQdq1M9teePTP1V66QXqij0tbdNiJLof0bauKC3GOdAz16kPhNFkXFa5LS?=
 =?iso-8859-1?Q?8gtQKB4D0KaH6LHfGo3gglKqDDNQdIZYXOmJYCdBdqJtLjmUCReD5NwE1U?=
 =?iso-8859-1?Q?2jeRFaCJessLl+AiyCCC8tA6wyiuLlFgQjnPK3jjtYIzJ2+YIJiBPe6p/y?=
 =?iso-8859-1?Q?VIHFFFj+iVO2QNuMls4RAD+qZ9s02Zbg0ijBf9qRkK0OuMkezbjGLkzJvm?=
 =?iso-8859-1?Q?AFssoyYKVRlmQ5+9wubJFRGhgFhsPckGcrpxIvSs+LgVitHcJSJEEuqebK?=
 =?iso-8859-1?Q?F8P2fDSMSPXGEYGVA3y+TFX77su+KY7r56a9MGgaccYJ1JGoZB6FerWO6B?=
 =?iso-8859-1?Q?ouQedQGjIrSK4YCebknfMfhUcrWeYjbpiPJXQXCk52/ejl/axWJU3ABN1S?=
 =?iso-8859-1?Q?FbZvpxsi1nySr/xWGdXMKEyv4zIw7JctXY7brC4r0MiSHOQSrNN7bG+hvW?=
 =?iso-8859-1?Q?p8AkMtNUEh6lCyNei55/Xm8UfDTXxSEIyrKd9wCShxe1cPcr+erIhZCVBK?=
 =?iso-8859-1?Q?Ql3STYFbemsqYoYwmZzmrzkNacS9v1jDJE3uhbv5KXQoK51+uECjuME4kF?=
 =?iso-8859-1?Q?IOTGsMT8wKmSaSA277wkHAtpMhRvRSrrMoq0mNXjpOE8JWuXzh+g6nha00?=
 =?iso-8859-1?Q?jVqQx2EjwRb8dOff/e2iCqb16OEE2454kSAiLHhbDVi2qGwS72Nhl+UVQQ?=
 =?iso-8859-1?Q?KlRin1AM=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d8JFAe71BuYRXnGY0lC5af2yubcohMityEaoKnNhnsB6CTDiAj+DHxFvJtLZVRV8LTZxw0DJP4niBXsy3Lz2fLINuaWIhJi8EXQgJHBFHNlcfNfI60o6jEU7ROO5E2Bv29Evz17ur/+AdfMo7bxTUgqWq2Ups/alLfapXc1Cq+nfASquMkxHNuzbV2WQ02MwmkCCGi3l13NWkxQxuC2uMd9Q1BKou/hbnTc+PSPpaD6YNWnr1NMQzX8RPP7UG4HYOTENT9kjVlxMQKG8Csvdpf1Jrh6dmTNEF0Mzc+U4dlrq9pnG6y4lbxNIYkCUyaZTbS2KsFm30vrJmRKMZ6QWe7a43uTd5h0sE7jWaMAi5Q3eW54TkaQCZvltyvmtZ5FfZQPaTj92LEcHUGgBA2BDJ+zUTv3SHFFE7n3B1h/B8YA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aa5df9-e3ac-4f94-e8bb-08d6a289ac7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 23:15:51.0222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding is equivalent apart from the compatible.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt b/Docume=
ntation/devicetree/bindings/i2c/nxp,pca9541.txt
index 42bfc09c8918..17b4cb9d76da 100644
--- a/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
+++ b/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
@@ -1,8 +1,10 @@
-* NXP PCA9541 I2C bus master selector
+* NXP PCA9541/PCA9641 I2C bus master selectors
=20
 Required Properties:
=20
-  - compatible: Must be "nxp,pca9541"
+  - compatible: Must be either of
+		"nxp,pca9541"
+		"nxp,pca9641"
=20
   - reg: The I2C address of the device.
=20
--=20
2.11.0

