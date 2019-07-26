Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5AFC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE32C229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfGZKHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:07:06 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:55904 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfGZKHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:07:05 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id E9BC367A931;
        Fri, 26 Jul 2019 12:07:02 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jul
 2019 12:07:02 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Fri, 26 Jul 2019 12:07:02 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Admatec AG
Thread-Topic: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Admatec AG
Thread-Index: AQHVQ3nM8O6SL9DjWUGGlVFpIsOB6KbchhcAgAAD4YCAAAFJgA==
Date:   Fri, 26 Jul 2019 10:07:02 +0000
Message-ID: <5a61b9f1-86d5-438e-204b-0db3ef0796e3@kontron.de>
References: <20190726061705.14764-1-krzk@kernel.org>
 <963ba555-dde0-9c3c-1e15-740ca200853f@kontron.de>
 <CAJKOXPdbBXEy0zzjZ1ytts0y5STQ5x9xQVBmU1vn46tmu8uCGg@mail.gmail.com>
In-Reply-To: <CAJKOXPdbBXEy0zzjZ1ytts0y5STQ5x9xQVBmU1vn46tmu8uCGg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <F58E547739A13444B5B7088FBEE0A607@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: E9BC367A931.AFBCE
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDcuMTkgMTI6MDIsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIEZyaSwg
MjYgSnVsIDIwMTkgYXQgMTE6NDgsIFNjaHJlbXBmIEZyaWVkZXINCj4gPGZyaWVkZXIuc2NocmVt
cGZAa29udHJvbi5kZT4gd3JvdGU6DQo+Pg0KPj4gT24gMjYuMDcuMTkgMDg6MTcsIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4gQWRkIHZlbmRvciBwcmVmaXggZm9yIEFkbWF0ZWMgQUcu
DQo+Pg0KPj4gV2UgZ2V0IHRoZSBkaXNwbGF5cyB1c2VkIHdpdGggdGhlIEtvbnRyb24gZXZhbCBr
aXRzIGZyb20gImFkbWF0ZWMgR21iSCINCj4+IGluIEhhbWJ1cmcsIG5vdCAiQWRtYXRlYyBBRyIg
aW4gU3dpdHplcmxhbmQuIEkgdGhpbmsgd2UgaGF2ZSB0bw0KPj4gZGlmZmVyZW50aWF0ZSBoZXJl
Lg0KPj4NCj4+IEkgd2lsbCByZXZpZXcgcGF0Y2ggMi8yIHNvb24uLi4NCj4gDQo+IFdoYXQgYSBj
b2luY2lkZW5jZS4uLiB0aGV5IGhhdmUgc28gc2ltaWxhciBwb3J0Zm9saW8uIEFmdGVyIGxvb2tp
bmcgYXQNCj4gdmVuZG9yIHByZWZpeGVzIHRoYXQgd291bGQgYmUgdGhlIGZpcnN0IGR1cGxpY2F0
aW9uIG9mIG5hbWUuDQoNCkkgaGF2ZSBubyBpZGVhLCB3aGV0aGVyIHRoZXkgYXJlIHJlbGF0ZWQg
c29tZWhvdyBvciBoYXZlIGEgY29tbW9uIGhpc3RvcnkuLi4NCg0KPiANCj4gVG8gYXZvaWQgY29u
ZmxpY3QsIGhvdyBhYm91dDogImFkbWF0ZWNkZSI/DQoNCldvdWxkIGJlIG9rLCBJIGd1ZXNzLg0K
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiA=
