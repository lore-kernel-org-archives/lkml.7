Return-Path: <SRS0=hPQ7=TZ=propetroservices.com=javier.guerrero@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_REPLYTO,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9987BC04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:27:37 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-eopbgr760117.outbound.protection.outlook.com [40.107.76.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0D6206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ProPetroServices869.onmicrosoft.com header.i=@ProPetroServices869.onmicrosoft.com header.b="pzaKl7F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0D6206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=propetroservices.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=javier.guerrero@propetroservices.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ProPetroServices869.onmicrosoft.com;
 s=selector2-ProPetroServices869-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NsCCiLB8tFy4HzpaC86ki/Zo55VrYRRb/r4x5veR9o=;
 b=pzaKl7F6op5wsCmuFloUjBvzx5ePjuJxQOMkfTwsCc2MgDRvpuzQA5kU3HVrndYkA9wk/8hRv7PJekzQwSh3BG4tlvCl8v9fYUYdPYHMsBReSdyW07eNnKUm3ZbMYSuZHNsM9tPv+yiRw9575SwI4R9G+E1rXIGNtZ2nJZ+reGQ=
Received: from DM5PR03MB2794.namprd03.prod.outlook.com (10.168.193.135) by
 DM5PR03MB2747.namprd03.prod.outlook.com (10.168.199.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Sat, 25 May 2019 08:27:35 +0000
Received: from DM5PR03MB2794.namprd03.prod.outlook.com
 ([fe80::bc53:fd40:4c08:9560]) by DM5PR03MB2794.namprd03.prod.outlook.com
 ([fe80::bc53:fd40:4c08:9560%2]) with mapi id 15.20.1922.019; Sat, 25 May 2019
 08:27:35 +0000
From: Javier Guerrero <javier.guerrero@propetroservices.com>
To: Linux-Kernel <linux-kernel@archiver.kernel.org>
Subject: Re:Re
Thread-Topic: Re:Re
Thread-Index: AQHVEs6XzeKLiTLB40CVGn92JIpUtA==
Date: Sat, 25 May 2019 07:50:59 +0000
Message-ID: <20NNWSZF-REP6-UREW-8YUE-JBPOH8R2FFOB@propetroservices.com>
Reply-To: "cnm-imports@outlook.com" <cnm-imports@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: MR2P264CA0116.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::32) To DM5PR03MB2794.namprd03.prod.outlook.com
 (2603:10b6:3:3c::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier.guerrero@propetroservices.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [102.141.212.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30e70489-7919-483c-ff05-08d6e0e5b981
x-microsoft-antispam:
 BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR03MB2747;
x-ms-traffictypediagnostic: DM5PR03MB2747:
x-microsoft-antispam-prvs:
 <DM5PR03MB2747F3715F327B6FEE6460FE88030@DM5PR03MB2747.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0048BCF4DA
x-forefront-antispam-report:
 SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(39850400004)(376002)(189003)(199004)(54896002)(64756008)(66446008)(3480700005)(478600001)(6512007)(6666004)(3846002)(33656002)(36756003)(66066001)(14454004)(6116002)(6486002)(4744005)(44832011)(71190400001)(71200400001)(53936002)(43066004)(73956011)(26005)(104396003)(6436002)(25786009)(2860700004)(33100200003)(486006)(66946007)(476003)(6916009)(14444005)(99286004)(2906002)(66476007)(102836004)(66556008)(386003)(6506007)(2616005)(68736007)(5024004)(52116002)(8936002)(8676002)(8796002)(7116003)(66806009)(86362001)(5660300002)(89046005)(81156014)(81166006)(256004)(316002)(186003)(7736002)(146613001)(53540200001)(19580200005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR03MB2747;H:DM5PR03MB2794.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: propetroservices.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info:
 YhQIiW5gU/QOqZdfI28mSOCCmaOc9kZrYLHOGzwk9taKLfb8Cl7YCPIXCgGjuaXoDReTwBe317r7VL7Yx5uUrjxrQYJS26QT77vkjCETaqPLYGUN1CM8RfAlXLkwFNdDbPxirN+/wOwIiCwNP+SgPk8M5a+T7EBW/Af/EJnxJ00RCtvDT/j/jpjKTDJMv0M/6jdDeAs4mpttWnnAnbMSj7SN157L3NcDpngvpXHyGK0v5qt6lZgXNzxxAvJ2OaPEIZoBaWK54hSfj0+BMVnSDRAA6KWKE+0ddeY07ZHEpEiJoY0cOIGZykgHrPSIpuCeMrsWNAmF4ELm+n3N1/H0IXnv1GWO+Ox4AavkfTkfzaE6s2/lnYFPgVwwgFvAZpwYwK0FT3XwYaqcTFKjrf6bOv+wWSWD4KvdYCNsbcjlJmU=
Content-Type: multipart/alternative;
	boundary="_000_20NNWSZFREP6UREW8YUEJBPOH8R2FFOBpropetroservicescom_"
MIME-Version: 1.0
X-OriginatorOrg: propetroservices.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e70489-7919-483c-ff05-08d6e0e5b981
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2019 07:50:59.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03899b5e-fc45-4ce6-8d67-7c2decf9f6be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: javier.guerrero@propetroservices.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2747
List-Id: <linux-kernel.vger.kernel.org>

--_000_20NNWSZFREP6UREW8YUEJBPOH8R2FFOBpropetroservicescom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

R29vZCBtb3JuaW5nLA0KDQpXZSBhcmUgaW50ZXJlc3RlZCBpbiB5b3VyIHByb2R1Y3QgYW5kIGhv
cGUgdG8gaGF2ZSBjb29wZXJhdGlvbiB3aXRoIHlvdS4gUGxlYXNlIHNlbmQgbWUgdGhlIGRldGFp
bHMgb2YgeW91ciBxdW90YXRpb24gYW5kIHNwZWNpZmljYXRpb25zLCB0aGVuIHdlIHdpbGwgZGV0
ZXJtaW5lIHRoZSBwdXJjaGFzZSBxdWFudGl0eS4NCg0KVGhhbmsgWW91Lg0KDQpKYXZpZXIgR3Vl
cnJlcm8NCmltcG9ydCBhbmQgcHVyY2hhc2UNClRlbCAoNjM0KSA3MzQtNzQ3DQpGYXggKDQyNCkg
NDI0LTk4OTINCkNPTkZJREVOVElBTElUWSBOT1RJQ0U6IFRoZSBpbmZvcm1hdGlvbiBpbiB0aGlz
IGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGJlIGNvbmZpZGVudGlhbCBhbmQvb3IgcHJp
dmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvciBhbiBhdXRo
b3JpemVkIHJlcHJlc2VudGF0aXZlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUg
aGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55IHJldmlldywgZGlzc2VtaW5hdGlvbiBvciBjb3B5aW5n
IG9mIHRoaXMgZW1haWwgYW5kIGl0cyBhdHRhY2htZW50cywgb3IgdGhlIGluZm9ybWF0aW9uIGNv
bnRhaW5lZCBoZXJlaW4sIGlzIHByb2hpYml0ZWQgYW5kIHN1Y2ggYWN0aW9ucyBtYXkgYmUgdW5s
YXdmdWwuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBp
bW1lZGlhdGVseSBub3RpZnkgdGhlIHNlbmRlciBieSByZXR1cm4gZW1haWwgYW5kIGRlbGV0ZSB0
aGlzIGVtYWlsIGZyb20geW91ciBzeXN0ZW0uIFRoYW5rIHlvdS4NCg==

--_000_20NNWSZFREP6UREW8YUEJBPOH8R2FFOBpropetroservicescom_
Content-Type: text/html; charset="utf-8"
Content-ID: <9BB91DD4F944C04DA4D6A1925C07A895@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjx0aXRsZT5IVE1MIE1lc3NhZ2U8L3RpdGxlPg0K
PG1ldGEgbmFtZT0iZ2VuZXJhdG9yIiBjb250ZW50PSJBZHZhbmNlZCIgaHRtbD0iIiBwYXJzZXJ2
ND0iIj4NCjwvaGVhZD4NCjxib2R5Pg0KPHRhYmxlIHN0eWxlPSJib3JkZXI6IDBweDsgd2lkdGg6
IDEwMCU7IGJvcmRlci1zcGFjaW5nOiAwcHg7Ij4NCjx0Ym9keT4NCjx0cj4NCjx0ZCBzdHlsZT0i
cGFkZGluZzogMHB4OyI+DQo8ZGl2IHN0eWxlPSJ0ZXh0LWFsaWduOiBsZWZ0Ij48c3BhbiBzdHls
ZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBIZWx2ZXRpY2EsIFZlcmRhbmE7IGZvbnQtc2l6ZTogMTJw
eDsgY29sb3I6ICMxOTE5MTk7Ij5Hb29kIG1vcm5pbmcsPC9zcGFuPjwvZGl2Pg0KPGJyPg0KPGRp
diBzdHlsZT0idGV4dC1hbGlnbjogbGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlh
bCwgSGVsdmV0aWNhLCBWZXJkYW5hOyBmb250LXNpemU6IDEycHg7IGNvbG9yOiAjMTkxOTE5OyI+
V2UgYXJlIGludGVyZXN0ZWQgaW4geW91ciBwcm9kdWN0IGFuZCBob3BlIHRvIGhhdmUgY29vcGVy
YXRpb24gd2l0aCB5b3UuIFBsZWFzZSBzZW5kIG1lIHRoZSBkZXRhaWxzIG9mIHlvdXIgcXVvdGF0
aW9uIGFuZCBzcGVjaWZpY2F0aW9ucywgdGhlbg0KIHdlIHdpbGwgZGV0ZXJtaW5lIHRoZSBwdXJj
aGFzZSBxdWFudGl0eS48L3NwYW4+PC9kaXY+DQo8YnI+DQo8ZGl2IHN0eWxlPSJ0ZXh0LWFsaWdu
OiBsZWZ0Ij48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBIZWx2ZXRpY2EsIFZlcmRh
bmE7IGZvbnQtc2l6ZTogMTJweDsgY29sb3I6ICMxOTE5MTk7Ij5UaGFuayBZb3UuPC9zcGFuPjwv
ZGl2Pg0KPGJyPg0KPGRpdiBzdHlsZT0idGV4dC1hbGlnbjogbGVmdCI+PHNwYW4gc3R5bGU9ImZv
bnQtZmFtaWx5OiBBcmlhbCwgSGVsdmV0aWNhLCBWZXJkYW5hOyBmb250LXNpemU6IDEycHg7IGNv
bG9yOiAjMTkxOTE5OyI+SmF2aWVyIEd1ZXJyZXJvPC9zcGFuPjwvZGl2Pg0KPGRpdiBzdHlsZT0i
dGV4dC1hbGlnbjogbGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgSGVsdmV0
aWNhLCBWZXJkYW5hOyBmb250LXNpemU6IDEycHg7IGNvbG9yOiAjMTkxOTE5OyI+aW1wb3J0IGFu
ZCBwdXJjaGFzZTwvc3Bhbj48L2Rpdj4NCjxkaXYgc3R5bGU9InRleHQtYWxpZ246IGxlZnQiPjxz
cGFuIHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIEhlbHZldGljYSwgVmVyZGFuYTsgZm9udC1z
aXplOiAxMnB4OyBjb2xvcjogIzE5MTkxOTsiPlRlbCAoNjM0KSA3MzQtNzQ3PC9zcGFuPjwvZGl2
Pg0KPGRpdiBzdHlsZT0idGV4dC1hbGlnbjogbGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5
OiBBcmlhbCwgSGVsdmV0aWNhLCBWZXJkYW5hOyBmb250LXNpemU6IDEycHg7IGNvbG9yOiAjMTkx
OTE5OyI+RmF4ICg0MjQpIDQyNC05ODkyPC9zcGFuPjwvZGl2Pg0KPC90ZD4NCjwvdHI+DQo8L3Ri
b2R5Pg0KPC90YWJsZT4NCkNPTkZJREVOVElBTElUWSBOT1RJQ0U6IFRoZSBpbmZvcm1hdGlvbiBp
biB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGJlIGNvbmZpZGVudGlhbCBhbmQv
b3IgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvciBh
biBhdXRob3JpemVkIHJlcHJlc2VudGF0aXZlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlv
dSBhcmUgaGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55IHJldmlldywgZGlzc2VtaW5hdGlvbg0KIG9y
IGNvcHlpbmcgb2YgdGhpcyBlbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzLCBvciB0aGUgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGhlcmVpbiwgaXMgcHJvaGliaXRlZCBhbmQgc3VjaCBhY3Rpb25zIG1h
eSBiZSB1bmxhd2Z1bC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwg
cGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJldHVybiBlbWFpbCBhbmQg
ZGVsZXRlIHRoaXMgZW1haWwgZnJvbSB5b3VyDQogc3lzdGVtLiBUaGFuayB5b3UuDQo8L2JvZHk+
DQo8L2h0bWw+DQo=

--_000_20NNWSZFREP6UREW8YUEJBPOH8R2FFOBpropetroservicescom_--
