Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE6EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D26217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="R5LnO/YL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfDDS3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:29:17 -0400
Received: from mail-eopbgr780139.outbound.protection.outlook.com ([40.107.78.139]:43390
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbfDDS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kw4EefOJ0jVDbHA1+OPQKxiWqYF8Ckg0OhVBFevFPE=;
 b=R5LnO/YL6YKuS73Sov9u696bbjcEL4WcTkdR9+rPhF19c1q9yHJOa87ermLz7NxZAUXBXyvGpxBjclHB2u6pWLMoPlkEDqn580q4heDiYFt9/16dunvplFygEUa1JtHOLHA2TzhNtqnBlckNXA3oftrAvxPQryP81iaJalCCaHI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1504.namprd22.prod.outlook.com (10.174.170.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Thu, 4 Apr 2019 18:29:14 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%6]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 18:29:14 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: generic: Add switchdev,  pinctrl and fit to
 ocelot_defconfig
Thread-Topic: [PATCH v2] MIPS: generic: Add switchdev,  pinctrl and fit to
 ocelot_defconfig
Thread-Index: AQHU6xRNa9kLMHg3rk2oDsl2wnkHTA==
Date:   Thu, 4 Apr 2019 18:29:13 +0000
Message-ID: <MWHPR2201MB1277CF6185BA6140F61F08BEC1500@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1554366328-16459-1-git-send-email-horatiu.vultur@microchip.com>
In-Reply-To: <1554366328-16459-1-git-send-email-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe4eb09d-02de-49c2-7b72-08d6b92b7013
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1504;
x-ms-traffictypediagnostic: MWHPR2201MB1504:
x-microsoft-antispam-prvs: <MWHPR2201MB150467283CD1B55381684FA0C1500@MWHPR2201MB1504.namprd22.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(5660300002)(97736004)(53936002)(25786009)(229853002)(14454004)(478600001)(55016002)(6246003)(486006)(3846002)(71190400001)(71200400001)(6116002)(9686003)(446003)(44832011)(476003)(4326008)(11346002)(8936002)(186003)(7696005)(52116002)(7736002)(76176011)(8676002)(81156014)(26005)(305945005)(105586002)(102836004)(68736007)(386003)(256004)(6506007)(66066001)(33656002)(74316002)(106356001)(42882007)(316002)(54906003)(52536014)(99286004)(4744005)(6916009)(2906002)(6436002)(81166006)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1504;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r12zYX2aQKBUY/H5gAR/QnoeJdi5fkxbrAvFjAApTbDAe8xV+1YhowgH5BkPiaA723cyZZ+Lpls+Thc6nGf2g+reOkY1GyORaT5+8e/pNAZYW5VFxIp3kIfoIp/eAm2M24WhFW1mtfVLFOf99yKToQe/y33qVnVa5BVMlJxYO2WKBEYDk6Ps9gCUPJI9ywZCQ8abw/8MC9zJFwjdg9KYHGESibsNfXELKC1tuxhMtNlktbLC8re3wIe8OijR/X6uMdUNS17Wy1A8tnm8h5e+1TS/5m3pYjMDoXev6KH3IP+Fn5nmGeyXS7xXaWE7S2q6JiaakSr/3CPZBjsN7Fl1GcE9jTwGl3Q60Y7UqQTxmNeP6vGMRF+bZ9VOFGym/dNuwi+lgVJTPnsT4tvqmK7XqrqIrXltnLsCaZynN8kmSI8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4eb09d-02de-49c2-7b72-08d6b92b7013
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 18:29:13.9645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkhvcmF0aXUgVnVsdHVyIHdyb3RlOg0KPiBTb21lIG9mIHRoZSBjb25maWd1cmF0
aW9uIHdlcmUgbm90IHNlbGVjdGVkIGJ5IGRlZmF1bHQgYW55bW9yZSwgdGhlcmVmb3JlDQo+IGVu
YWJsZSB0aGVtIGFnYWluLiBBbHNvIHJlbW92ZSBzb21lIGNvbmZpZ3Mgd2hpY2ggYXJlIHVzZWQg
Zm9yIE1TQ0MgT2NlbG90Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSG9yYXRpdSBWdWx0dXIgPGhv
cmF0aXUudnVsdHVyQG1pY3JvY2hpcC5jb20+DQoNCkFwcGxpZWQgdG8gbWlwcy1maXhlcy4NCg0K
VGhhbmtzLA0KICAgIFBhdWwNCg0KWyBUaGlzIG1lc3NhZ2Ugd2FzIGF1dG8tZ2VuZXJhdGVkOyBp
ZiB5b3UgYmVsaWV2ZSBhbnl0aGluZyBpcyBpbmNvcnJlY3QNCiAgdGhlbiBwbGVhc2UgZW1haWwg
cGF1bC5idXJ0b25AbWlwcy5jb20gdG8gcmVwb3J0IGl0LiBdDQo=
