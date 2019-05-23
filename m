Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF39C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7433D21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s8iIeKRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfEWFvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:51:05 -0400
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:7844
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfEWFvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtKNTwaKLzob0itOvH8iWjYzWGHKZZWtULJ1yn3w2II=;
 b=s8iIeKRx+MBs86dEV1LMbKaBYiwOwHFQcyfjhstPHEJ5j0DNqf+YfqE/lDEqiQPoB0fQgVtoG9TYUTfIDyhyEtFVfbiBIKOhhJdqBZbOJkpIDXZnXhCM/F4F7SaZMb6kAsfAiIUhZzLtZKTzAdXaA3cA9j6fgRr2Qs+sbyqMLAU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3956.eurprd04.prod.outlook.com (52.134.93.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Thu, 23 May 2019 05:50:58 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 05:50:58 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] DT: mailbox: add binding doc for the ARM SMC mailbox
Thread-Topic: [PATCH 1/2] DT: mailbox: add binding doc for the ARM SMC mailbox
Thread-Index: AQHVESt+5fp+4ZxwMEmNHJCtGp/VNQ==
Date:   Thu, 23 May 2019 05:50:58 +0000
Message-ID: <20190523060437.11059-2-peng.fan@nxp.com>
References: <20190523060437.11059-1-peng.fan@nxp.com>
In-Reply-To: <20190523060437.11059-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0P153CA0040.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecf51b94-0f2d-4601-2daf-08d6df42a0e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB3956;
x-ms-traffictypediagnostic: AM0PR04MB3956:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB395615967ED4EC99223559F088010@AM0PR04MB3956.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(2201001)(86362001)(6512007)(7110500001)(256004)(6436002)(6306002)(44832011)(486006)(2501003)(2906002)(2616005)(476003)(6116002)(3846002)(81166006)(8676002)(25786009)(6486002)(305945005)(81156014)(8936002)(50226002)(2420400007)(4326008)(53936002)(11346002)(15650500001)(7736002)(316002)(446003)(186003)(26005)(14454004)(66066001)(68736007)(1076003)(36756003)(71200400001)(71190400001)(102836004)(5660300002)(347745004)(386003)(54906003)(110136005)(76176011)(6506007)(99286004)(66556008)(66446008)(66476007)(7416002)(66946007)(478600001)(73956011)(52116002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3956;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JXL3dIoOZdZqNPGrNhAq5vYhmav5WqYMdZ73VFtEXIb+gs1vjXXBmQh4H1LDjWSp1hSCiT4IvIegnoKGYQ7CTmbOrHkIalsRGV5O+fGJZTBr2QjCmsibR8SYut4f5Jb8IA66radeYBcGMv15DKVmDBgqEm/lRHZQ7aN64CGA+cA+RnaO8kMq5cAV5zQWqoUOPUWkK6KoflFPlLZs2U6rHEEUFIryup3QX2GZj2TLkDTZaQDDjhVwrQl0ZTDA2nZcnGrbravQs7NOgP7uCK8ZUTiO3z3bho93/iLPbvVmsP8GzLD05lehLe9r1btRIye7IGpuJyeZqmLTbavcFwRYddPQt2KOz/6EVP5CBCIptqb/deORpcmui+WT1VE+QQtvTDOatxww+ZCcIlUOg8NAGVyBEvAKU6OL1MtRIdxAkyY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf51b94-0f2d-4601-2daf-08d6df42a0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 05:50:58.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIEFSTSBTTUMgbWFpbGJveCBiaW5kaW5nIGRlc2NyaWJlcyBhIGZpcm13YXJlIGludGVyZmFj
ZSB0byB0cmlnZ2VyCmFjdGlvbnMgaW4gc29mdHdhcmUgbGF5ZXJzIHJ1bm5pbmcgaW4gdGhlIEVM
MiBvciBFTDMgZXhjZXB0aW9uIGxldmVscy4KVGhlIHRlcm0gIkFSTSIgaGVyZSByZWxhdGVzIHRv
IHRoZSBTTUMgaW5zdHJ1Y3Rpb24gYXMgcGFydCBvZiB0aGUgQVJNCmluc3RydWN0aW9uIHNldCwg
bm90IGFzIGEgc3RhbmRhcmQgZW5kb3JzZWQgYnkgQVJNIEx0ZC4KClNpZ25lZC1vZmYtYnk6IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPgotLS0KClYxOgphcm0sZnVuYy1pZHMgaXMgc3RpbGwg
a2VwdCBhcyBhbiBvcHRpb25hbCBwcm9wZXJ0eSwgYmVjYXVzZSB0aGVyZSBpcyBubwpkZWZpbmVk
IFNNQyBmdW5jaXRvbiBpZCBwYXNzZWQgZnJvbSBTQ01JLiBTbyBpbiBteSB0ZXN0LCBJIHN0aWxs
IHVzZQphcm0sZnVuYy1pZHMgZm9yIEFSTSBTSVAgc2VydmljZS4KCiAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9tYWlsYm94L2FybS1zbWMudHh0ICAgICAgICB8IDk2ICsrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXJtLXNtYy50eHQK
CmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9h
cm0tc21jLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2Fy
bS1zbWMudHh0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uMTJmYzU5
OTc5MzNkCi0tLSAvZGV2L251bGwKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21haWxib3gvYXJtLXNtYy50eHQKQEAgLTAsMCArMSw5NiBAQAorQVJNIFNNQyBNYWlsYm94
IEludGVyZmFjZQorPT09PT09PT09PT09PT09PT09PT09PT09PQorCitUaGlzIG1haWxib3ggdXNl
cyB0aGUgQVJNIHNtYyAoc2VjdXJlIG1vbml0b3IgY2FsbCkgaW5zdHJ1Y3Rpb24gdG8KK3RyaWdn
ZXIgYSBtYWlsYm94LWNvbm5lY3RlZCBhY3Rpdml0eSBpbiBmaXJtd2FyZSwgZXhlY3V0aW5nIG9u
IHRoZSB2ZXJ5IHNhbWUKK2NvcmUgYXMgdGhlIGNhbGxlci4gQnkgbmF0dXJlIHRoaXMgb3BlcmF0
aW9uIGlzIHN5bmNocm9ub3VzIGFuZCB0aGlzCittYWlsYm94IHByb3ZpZGVzIG5vIHdheSBmb3Ig
YXN5bmNocm9ub3VzIG1lc3NhZ2VzIHRvIGJlIGRlbGl2ZXJlZCB0aGUgb3RoZXIKK3dheSByb3Vu
ZCwgZnJvbSBmaXJtd2FyZSB0byB0aGUgT1MuIEhvd2V2ZXIgdGhlIHZhbHVlIG9mIHIwL3cwL3gw
IHRoZSBmaXJtd2FyZQorcmV0dXJucyBhZnRlciB0aGUgc21jIGNhbGwgaXMgZGVsaXZlcmVkIGFz
IGEgcmVjZWl2ZWQgbWVzc2FnZSB0byB0aGUKK21haWxib3ggZnJhbWV3b3JrLCBzbyBhIHN5bmNo
cm9ub3VzIGNvbW11bmljYXRpb24gY2FuIGJlIGVzdGFibGlzaGVkLgorVGhlIGV4YWN0IG1lYW5p
bmcgb2YgYm90aCB0aGUgYWN0aW9uIHRoZSBtYWlsYm94IHRyaWdnZXJzIGFzIHdlbGwgYXMgdGhl
CityZXR1cm4gdmFsdWUgaXMgZGVmaW5lZCBieSB0aGVpciB1c2VycyBhbmQgaXMgbm90IHN1Ympl
Y3QgdG8gdGhpcyBiaW5kaW5nLgorCitPbmUgdXNlIGNhc2Ugb2YgdGhpcyBtYWlsYm94IGlzIHRo
ZSBTQ01JIGludGVyZmFjZSwgd2hpY2ggdXNlcyBzaGFyZWQgbWVtb3J5Cit0byB0cmFuc2ZlciBj
b21tYW5kcyBhbmQgcGFyYW1ldGVycywgYW5kIGEgbWFpbGJveCB0byB0cmlnZ2VyIGEgZnVuY3Rp
b24KK2NhbGwuIFRoaXMgYWxsb3dzIFNvQ3Mgd2l0aG91dCBhIHNlcGFyYXRlIG1hbmFnZW1lbnQg
cHJvY2Vzc29yIChvcgord2hlbiBzdWNoIGEgcHJvY2Vzc29yIGlzIG5vdCBhdmFpbGFibGUgb3Ig
dXNlZCkgdG8gdXNlIHRoaXMgc3RhbmRhcmRpemVkCitpbnRlcmZhY2UgYW55d2F5LgorCitUaGlz
IGJpbmRpbmcgZGVzY3JpYmVzIG5vIGhhcmR3YXJlLCBidXQgZXN0YWJsaXNoZXMgYSBmaXJtd2Fy
ZSBpbnRlcmZhY2UuCitVcG9uIHJlY2VpdmluZyBhbiBTTUMgdXNpbmcgb25lIG9mIHRoZSBkZXNj
cmliZWQgU01DIGZ1bmN0aW9uIGlkZW50aWZpZXJzLAordGhlIGZpcm13YXJlIGlzIGV4cGVjdGVk
IHRvIHRyaWdnZXIgc29tZSBtYWlsYm94IGNvbm5lY3RlZCBmdW5jdGlvbmFsaXR5LgorVGhlIGNv
bW11bmljYXRpb24gZm9sbG93cyB0aGUgQVJNIFNNQyBjYWxsaW5nIGNvbnZlbnRpb25bMV0uCitG
aXJtd2FyZSBleHBlY3RzIGFuIFNNQyBmdW5jdGlvbiBpZGVudGlmaWVyIGluIHIwIG9yIHcwLiBU
aGUgc3VwcG9ydGVkCitpZGVudGlmaWVycyBhcmUgcGFzc2VkIGZyb20gY29uc3VtZXJzLCBvciBs
aXN0ZWQgaW4gdGhlIHRoZSBhcm0sZnVuYy1pZHMKK3Byb3BlcnRpZXMgYXMgZGVzY3JpYmVkIGJl
bG93LiBUaGUgZmlybXdhcmUgY2FuIHJldHVybiBvbmUgdmFsdWUgaW4KK3RoZSBmaXJzdCBTTUMg
cmVzdWx0IHJlZ2lzdGVyLCBpdCBpcyBleHBlY3RlZCB0byBiZSBhbiBlcnJvciB2YWx1ZSwKK3do
aWNoIHNoYWxsIGJlIHByb3BhZ2F0ZWQgdG8gdGhlIG1haWxib3ggY2xpZW50LgorCitBbnkgY29y
ZSB3aGljaCBzdXBwb3J0cyB0aGUgU01DIG9yIEhWQyBpbnN0cnVjdGlvbiBjYW4gYmUgdXNlZCwg
YXMgbG9uZyBhcworYSBmaXJtd2FyZSBjb21wb25lbnQgcnVubmluZyBpbiBFTDMgb3IgRUwyIGlz
IGhhbmRsaW5nIHRoZXNlIGNhbGxzLgorCitNYWlsYm94IERldmljZSBOb2RlOgorPT09PT09PT09
PT09PT09PT09PT0KKworVGhpcyBub2RlIGlzIGV4cGVjdGVkIHRvIGJlIGEgY2hpbGQgb2YgdGhl
IC9maXJtd2FyZSBub2RlLgorCitSZXF1aXJlZCBwcm9wZXJ0aWVzOgorLS0tLS0tLS0tLS0tLS0t
LS0tLS0KKy0gY29tcGF0aWJsZToJCVNoYWxsIGJlICJhcm0sc21jLW1ib3giCistICNtYm94LWNl
bGxzCQlTaGFsbCBiZSAxIC0gdGhlIGluZGV4IG9mIHRoZSBjaGFubmVsIG5lZWRlZC4KKy0gYXJt
LG51bS1jaGFucwkJVGhlIG51bWJlciBvZiBjaGFubmVscyBzdXBwb3J0ZWQuCistIG1ldGhvZDoJ
CUEgc3RyaW5nLCBlaXRoZXI6CisJCQkiaHZjIjogaWYgdGhlIGRyaXZlciBzaGFsbCB1c2UgYW4g
SFZDIGNhbGwsIG9yCisJCQkic21jIjogaWYgdGhlIGRyaXZlciBzaGFsbCB1c2UgYW4gU01DIGNh
bGwuCisKK09wdGlvbmFsIHByb3BlcnRpZXM6CistIGFybSxmdW5jLWlkcwkJQW4gYXJyYXkgb2Yg
MzItYml0IHZhbHVlcyBzcGVjaWZ5aW5nIHRoZSBmdW5jdGlvbgorCQkJSURzIHVzZWQgYnkgZWFj
aCBtYWlsYm94IGNoYW5uZWwuIFRob3NlIGZ1bmN0aW9uIElEcworCQkJZm9sbG93IHRoZSBBUk0g
U01DIGNhbGxpbmcgY29udmVudGlvbiBzdGFuZGFyZCBbMV0uCisJCQlUaGVyZSBpcyBvbmUgaWRl
bnRpZmllciBwZXIgY2hhbm5lbCBhbmQgdGhlIG51bWJlcgorCQkJb2Ygc3VwcG9ydGVkIGNoYW5u
ZWxzIGlzIGRldGVybWluZWQgYnkgdGhlIGxlbmd0aAorCQkJb2YgdGhpcyBhcnJheS4KKworRXhh
bXBsZToKKy0tLS0tLS0tCisKKwlzcmFtQDkxMDAwMCB7CisJCWNvbXBhdGlibGUgPSAibW1pby1z
cmFtIjsKKwkJcmVnID0gPDB4MCAweDkzZjAwMCAweDAgMHgxMDAwPjsKKwkJI2FkZHJlc3MtY2Vs
bHMgPSA8MT47CisJCSNzaXplLWNlbGxzID0gPDE+OworCQlyYW5nZXMgPSA8MCAweDAgMHg5M2Yw
MDAgMHgxMDAwPjsKKworCQljcHVfc2NwX2xwcmk6IHNjcC1zaG1lbUAwIHsKKwkJCWNvbXBhdGli
bGUgPSAiYXJtLHNjbWktc2htZW0iOworCQkJcmVnID0gPDB4MCAweDIwMD47CisJCX07CisKKwkJ
Y3B1X3NjcF9ocHJpOiBzY3Atc2htZW1AMjAwIHsKKwkJCWNvbXBhdGlibGUgPSAiYXJtLHNjbWkt
c2htZW0iOworCQkJcmVnID0gPDB4MjAwIDB4MjAwPjsKKwkJfTsKKwl9OworCisJc21jX21ib3g6
IG1haWxib3ggeworCQkjbWJveC1jZWxscyA9IDwxPjsKKwkJY29tcGF0aWJsZSA9ICJhcm0sc21j
LW1ib3giOworCQltZXRob2QgPSAic21jIjsKKwkJYXJtLG51bS1jaGFucyA9IDwweDI+OworCQkv
KiBPcHRpb25hbCAqLworCQlhcm0sZnVuYy1pZHMgPSA8MHhjMjAwMDBmZT4sIDwweGMyMDAwMGZm
PjsKKwl9OworCisJZmlybXdhcmUgeworCQlzY21pIHsKKwkJCWNvbXBhdGlibGUgPSAiYXJtLHNj
bWkiOworCQkJbWJveGVzID0gPCZtYWlsYm94IDAgJm1haWxib3ggMT47CisJCQltYm94LW5hbWVz
ID0gInR4IiwgInJ4IjsKKwkJCXNobWVtID0gPCZjcHVfc2NwX2xwcmkgJmNwdV9zY3BfaHByaT47
CisJCX07CisJfTsKKworCitbMV0KK2h0dHA6Ly9pbmZvY2VudGVyLmFybS5jb20vaGVscC9pbmRl
eC5qc3A/dG9waWM9L2NvbS5hcm0uZG9jLmRlbjAwMjhhL2luZGV4Lmh0bWwKLS0gCjIuMTYuNAoK
