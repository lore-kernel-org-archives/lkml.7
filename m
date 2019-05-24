Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA2DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6A62175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389622AbfEXIcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:32:16 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:21942 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389327AbfEXIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:32:15 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 24 May
 2019 16:32:14 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 24 May
 2019 16:32:13 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Fri, 24 May 2019 16:32:13 +0800
From:   TonyWWang-oc <TonyWWang-oc@zhaoxin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYxIDEvM10geDg2L2NwdTogQ3JlYXRlIFpoYW94aW4g?=
 =?gb2312?Q?processors_architecture_support_file?=
Thread-Topic: [PATCH v1 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
Thread-Index: AdURTsiYNBazyGlVQHaDmthi3UM1jP//sI0A//6JUUA=
Date:   Fri, 24 May 2019 08:32:13 +0000
Message-ID: <fa81a673c51140898b701769b47a84f5@zhaoxin.com>
References: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
 <alpine.DEB.2.21.1905231516350.2291@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1905231516350.2291@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.23]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMjMsIDIwMTksIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+ICsgKiBUaGlz
IGZpbGUgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbA0KPj4g
KyAqIExpY2Vuc2UgdjIuMCBvciBsYXRlci4gU2VlIGZpbGUgQ09QWUlORyBmb3IgZGV0YWlscy4N
Cj4NCj5QbGVhc2UgcmVtb3ZlIHRoaXMgYm9pbGVycGxhdGUgdGV4dC4gVGhlIFNQRFggbGljZW5z
ZSBpZGVudGlmaWVyIGlzDQo+c3VmZmljaWVudCwgYnV0IGxvb2tpbmcgYXQgdGhhdDoNCj4NCj4+
ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPg0KPlRoYXQgY2xlYXJseSBk
aXNhZ3JlZXMgd2l0aCB5b3VyIGJvaWxlcnBsYXRlIHRleHQgd2hpY2ggc2F5cyAndjIuMCBvcg0K
PmxhdGVyJy4gQXNzdW1lZCB0aGF0IHlvdSB3YW50IG9yIGxhdGVyLCB0aGVuIHRoZSBTUERYIGlk
IG5lZWRzIHRvIHNheSBzby4NCj4NCj4vLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlcg0KDQpPaywgSSB3aWxsIGFkanVzdCB0aGlzIHRleHQgYWZ0ZXIgc29ydCB0aGlz
IG91dCB3aXRoIG91ciBsYXd5ZXJzLg0KIA0KVGhhbmtzDQpUb255V1dhbmctb2MNCg==
