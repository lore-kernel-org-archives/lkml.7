Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D192C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28E5217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfEUM0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:26:09 -0400
Received: from mail-oln040092066078.outbound.protection.outlook.com ([40.92.66.78]:24996
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbfEUM0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:26:09 -0400
Received: from VE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (10.152.2.55) by VE1EUR01HT078.eop-EUR01.prod.protection.outlook.com
 (10.152.3.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16; Tue, 21 May
 2019 12:26:04 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.2.56) by
 VE1EUR01FT013.mail.protection.outlook.com (10.152.2.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16 via Frontend Transport; Tue, 21 May 2019 12:26:04 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 12:26:04 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" 
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clocksource/drivers/timer-ti-dm: Change to new style
 declaration
Thread-Topic: [PATCH] clocksource/drivers/timer-ti-dm: Change to new style
 declaration
Thread-Index: AQHVD9BbjxaGmY/02keaOGFYOZhwJA==
Date:   Tue, 21 May 2019 12:26:04 +0000
Message-ID: <VI1PR07MB44327103DA9EAE93D5417B3EFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0028.namprd22.prod.outlook.com
 (2603:10b6:300:69::14) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:9808AAC63BA166963BDD87CD507DFA11DA06C025E37DADD7C9308D5E474368FB;UpperCasedChecksum:7AEB4ED99CB534E17EC08EED7D34D1658E0638599C1B291F87519CEF2D64C695;SizeAsReceived:7502;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [Py+IiwWjtqi/MXhAQbjFKhojXs3+aYi2]
x-microsoft-original-message-id: <20190521122526.119995-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR01HT078;
x-ms-traffictypediagnostic: VE1EUR01HT078:
x-microsoft-antispam-message-info: adWlIfzJKB1hSKs9Dg6geacHBiYZLJ1UpqNbTEOeX2xcQptCvdqPJ1w3eqbuf69eKUi0EzY6+IORcFjTNhhQECr82oWRIAE3jHP3p/J3AIzvVfMPGindvBdCe3UfJd8Joi9UMXigdRka5tOgRWsuUg49RnXuueWdeocoNxz4pVO9e8AlRDhA+6WbF13OIGLR
Content-Type: text/plain; charset="utf-8"
Content-ID: <86680425BFA7AF47BF8A1110F9CBD5D3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f440e1-8e59-44e2-f44d-08d6dde77df1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 12:26:04.3754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT078
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VmFyaWFibGUgJ2RtdGltZXJfb3BzJyB3YXMgZGVjbGFyZWQgY29uc3Qgc3RhdGljIGluc3RlYWQg
b2Ygc3RhdGljIGNvbnN0Lg0KDQouLi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXRpLWRtLmM6
ODk5OjE6IHdhcm5pbmc6IOKAmHN0YXRpY+KAmSBpcyBub3QgYXQgYmVnaW5uaW5nIG9mIGRlY2xh
cmF0aW9uIFstV29sZC1zdHlsZS1kZWNsYXJhdGlvbl0NCiBjb25zdCBzdGF0aWMgc3RydWN0IG9t
YXBfZG1fdGltZXJfb3BzIGRtdGltZXJfb3BzID0gew0KIF5+fn5+DQoNClNpZ25lZC1vZmYtYnk6
IFBoaWxpcHBlIE1hemVuYXVlciA8cGhpbGlwcGUubWF6ZW5hdWVyQG91dGxvb2suZGU+DQotLS0N
CiBkcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXRpLWRtLmMgfCAyICstDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsb2Nrc291cmNlL3RpbWVyLXRpLWRtLmMgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXRp
LWRtLmMNCmluZGV4IGU0MGI1NWE3MDg2Zi4uNTM5NGQ5ZGJkZmJjIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9jbG9ja3NvdXJjZS90aW1lci10aS1kbS5jDQorKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNl
L3RpbWVyLXRpLWRtLmMNCkBAIC04OTYsNyArODk2LDcgQEAgc3RhdGljIGludCBvbWFwX2RtX3Rp
bWVyX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlyZXR1cm4gcmV0Ow0K
IH0NCiANCi1jb25zdCBzdGF0aWMgc3RydWN0IG9tYXBfZG1fdGltZXJfb3BzIGRtdGltZXJfb3Bz
ID0gew0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb21hcF9kbV90aW1lcl9vcHMgZG10aW1lcl9vcHMg
PSB7DQogCS5yZXF1ZXN0X2J5X25vZGUgPSBvbWFwX2RtX3RpbWVyX3JlcXVlc3RfYnlfbm9kZSwN
CiAJLnJlcXVlc3Rfc3BlY2lmaWMgPSBvbWFwX2RtX3RpbWVyX3JlcXVlc3Rfc3BlY2lmaWMsDQog
CS5yZXF1ZXN0ID0gb21hcF9kbV90aW1lcl9yZXF1ZXN0LA0KLS0gDQoyLjE3LjENCg0K
