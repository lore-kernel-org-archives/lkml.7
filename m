Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB9C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5452086A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfJDBhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:37:39 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:17168 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbfJDBhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:37:39 -0400
Received: from mail.aspeedtech.com (twmbx02.aspeed.com [192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id x941Ijae097543;
        Fri, 4 Oct 2019 09:18:45 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from TWMBX01.aspeed.com (192.168.0.23) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.620.29; Fri, 4 Oct
 2019 09:34:45 +0800
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.23) with Microsoft SMTP Server (TLS) id 15.0.620.29; Fri, 4 Oct
 2019 09:34:56 +0800
Received: from TWMBX02.aspeed.com ([fe80::997d:c0a7:f01f:e1a7]) by
 TWMBX02.aspeed.com ([fe80::997d:c0a7:f01f:e1a7%12]) with mapi id
 15.00.0620.020; Fri, 4 Oct 2019 09:34:43 +0800
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>
CC:     Jason M Biils <jason.m.bills@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "OpenBMC Maillist" <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: RE: [PATCH 0/2] peci: aspeed: Add AST2600 compatible
Thread-Topic: [PATCH 0/2] peci: aspeed: Add AST2600 compatible
Thread-Index: AQHVeOhVfyr8hf/PLEOlKG455HFAV6dHIbEAgABBZgCAABszgIAAsqtwgABj+ACAASCW0A==
Date:   Fri, 4 Oct 2019 01:34:43 +0000
Message-ID: <ad79c20427ea4aa28c826d32e96b82e8@TWMBX02.aspeed.com>
References: <20191002061200.29888-1-chiawei_wang@aspeedtech.com>
 <70044749-785b-6ff3-7a28-fb049dcfec54@linux.intel.com>
 <CACPK8XfBxC+4PHHCkMoXr+twjfWaovcJ5c=hfCmHRJ6LpGNeFg@mail.gmail.com>
 <03d21443-aa9a-a126-dc77-a21f14f708c9@linux.intel.com>
 <4af9eb8fa6fd41fc87708fc8afdcc83e@TWMBX02.aspeed.com>
 <b219c8e9-4f72-f91c-ba57-96ffab82ff2e@linux.intel.com>
In-Reply-To: <b219c8e9-4f72-f91c-ba57-96ffab82ff2e@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.0.133]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com x941Ijae097543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VyZS4gV2Ugd2lsbCByZS1zdWJtaXQgdGhlIHBhdGNoZXMgd2l0aCB0aGUgcmV2aXNpb24gc3Vn
Z2VzdGVkLg0KVGhhbmtzLg0KDQpSZWdhcmRzLA0KQ2hpYXdlaQ0KDQoqKioqKioqKioqKioqIEVt
YWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioNCkRJU0NMQUlN
RVI6DQpUaGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2Fs
bHkgcHJpdmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5
b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5
IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRo
YW5rIHlvdS4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFlIEh5dW4g
WW9vIFttYWlsdG86amFlLmh5dW4ueW9vQGxpbnV4LmludGVsLmNvbV0gDQpTZW50OiBGcmlkYXks
IE9jdG9iZXIgNCwgMjAxOSAxMjoyMCBBTQ0KVG86IENoaWFXZWkgV2FuZyA8Y2hpYXdlaV93YW5n
QGFzcGVlZHRlY2guY29tPjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCkNjOiBKYXNv
biBNIEJpaWxzIDxqYXNvbi5tLmJpbGxzQGxpbnV4LmludGVsLmNvbT47IFJvYiBIZXJyaW5nIDxy
b2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsg
QW5kcmV3IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT47IGxpbnV4LWFzcGVlZCA8bGludXgtYXNw
ZWVkQGxpc3RzLm96bGFicy5vcmc+OyBPcGVuQk1DIE1haWxsaXN0IDxvcGVuYm1jQGxpc3RzLm96
bGFicy5vcmc+OyBkZXZpY2V0cmVlIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IExpbnV4
IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTGludXggS2VybmVs
IE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFJ5YW4gQ2hlbiA8
cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIHBlY2k6
IGFzcGVlZDogQWRkIEFTVDI2MDAgY29tcGF0aWJsZQ0KDQpPbiAxMC8yLzIwMTkgNzozNSBQTSwg
Q2hpYVdlaSBXYW5nIHdyb3RlOg0KPiBIaSBKYWUgSHl1biwNCj4gDQo+IFRoYW5rcyBmb3IgdGhl
IGZlZWRiYWNrLg0KPiBGb3Igbm93IHNob3VsZCBJIHVzZSBHaXRIdWIgcHVsbC1yZXF1ZXN0IHRv
IHN1Ym1pdCB0aGUgcGF0Y2hlcyBvZiBQRUNJLXJlbGF0ZWQgY2hhbmdlIHRvIE9wZW5CTUMgZGV2
LTUuMyB0cmVlIG9ubHk/DQoNCllvdSBjb3VsZCBzdWJtaXQgdGhpcyBwYXRjaCBzZXJpZXMgdG8g
T3BlbkJNQyBtYWlsaW5nIGxpc3Qgd2l0aCBbUEFUQ0ggbGludXggZGV2LTUuM10gcHJlZml4Lg0K
DQpUaGFua3MsDQoNCkphZQ0K
