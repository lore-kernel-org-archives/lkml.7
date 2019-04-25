Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1394FC282E7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938852168B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vp1Tbq0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbfDYMgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:36:35 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49478 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:36:35 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="31033445"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Apr 2019 05:36:28 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:36:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9h/MMmFj42db5+5+C/Tcm3AI4/TTM1N7XpbaMOTN1M=;
 b=vp1Tbq0BUpY3998j9ejhTClxm7/pwHReXr+uABcjy/PEoCxB3tezLssDbXtTZUfyzGh+76grCXWoIMfJ1SsSuwVldBM6tBH7BQlDZmoWorUQ4k+IVZnzSdjXt1CKWiY7AudsQQl1KuwSdphYo8U4tBCSjfdsbVIECjBEmaJ81i8=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1726.namprd11.prod.outlook.com (10.169.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 12:36:26 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:36:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [RESEND][PATCH v3 3/6] pwm: atmel-hlcdc: add compatible for SAM9X60
 HLCDC's PWM
Thread-Topic: [RESEND][PATCH v3 3/6] pwm: atmel-hlcdc: add compatible for
 SAM9X60 HLCDC's PWM
Thread-Index: AQHU+2N/EO519ERcM0yHdVZu5vHx0A==
Date:   Thu, 25 Apr 2019 12:36:26 +0000
Message-ID: <1556195748-11106-4-git-send-email-claudiu.beznea@microchip.com>
References: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0024.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::34) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59ae919e-7885-477d-4c38-08d6c97aa1a6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1726;
x-ms-traffictypediagnostic: MWHPR11MB1726:
x-microsoft-antispam-prvs: <MWHPR11MB1726020EDF2543A4C1C7F0AC873D0@MWHPR11MB1726.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(346002)(376002)(199004)(189003)(81156014)(7416002)(81166006)(97736004)(2201001)(53936002)(5660300002)(8676002)(2501003)(2906002)(86362001)(50226002)(305945005)(6436002)(68736007)(6486002)(72206003)(107886003)(71190400001)(14454004)(6512007)(8936002)(478600001)(186003)(66066001)(76176011)(26005)(256004)(476003)(7736002)(71200400001)(486006)(110136005)(54906003)(6506007)(386003)(6116002)(102836004)(66476007)(66446008)(66946007)(66556008)(36756003)(73956011)(64756008)(11346002)(4326008)(4744005)(446003)(52116002)(316002)(99286004)(3846002)(2616005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1726;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6HXbwbZRw47gX7FFqrTJOZePJVvLHPTJy/xuFs3tep35QVAxW1Z+hH+S6CdW7FLNvdEFkFe424LMp9Oyjq5fi9YW4Z54Z7fcT/Sfmd/5QVx63EnXmQNRqpbVHRkTISHl/w+7RunPaaunwxRh5HGRzluaqI5mwG664Vs9mBDIKMztCAQagKor//lNy5Om6kVzg1unHz87w91JOkvxlO3ODgUn2uVQEwpZHmaypT3bblBc5L0xQYbPERWlad1+ux8v+PRpGKsr1vTePPuLf1tNBbhpu6hIuT09zHSE3Rdhg+N0WRIcswyCPcnl41LpnuuZwIS0b9/MtmYabZn/lkLmeJcoM/YxDMxCQTLms1RNzBGHJzPrXsszjJCv50r2S7suba6inbSPKb8Q9k3MjDmTrSGEBdJNIMupjp3mRWJPRjg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ae919e-7885-477d-4c38-08d6c97aa1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:36:26.2385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1726
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFk
ZCBjb21wYXRpYmxlIHN0cmluZyBmb3IgU0FNOVg2MCBITENEQydzIFBXTS4NCg0KU2lnbmVkLW9m
Zi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpBY2tl
ZC1ieTogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYyBi
L2RyaXZlcnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jDQppbmRleCA1NGM2NjMzZDliNWQuLjZiZmJl
MWE5MDJmYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jDQorKysg
Yi9kcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYw0KQEAgLTI0Niw2ICsyNDYsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhdG1lbF9obGNkY19kdF9pZHNbXSA9IHsNCiAJ
CS5jb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDQtaGxjZGMiLA0KIAkJLmRhdGEgPSAmYXRtZWxf
aGxjZGNfcHdtX3NhbWE1ZDNfZXJyYXRhLA0KIAl9LA0KKwl7IAkuY29tcGF0aWJsZSA9ICJtaWNy
b2NoaXAsc2FtOXg2MC1obGNkYyIsIH0sDQogCXsgLyogc2VudGluZWwgKi8gfSwNCiB9Ow0KIE1P
RFVMRV9ERVZJQ0VfVEFCTEUob2YsIGF0bWVsX2hsY2RjX2R0X2lkcyk7DQotLSANCjIuNy40DQoN
Cg==
