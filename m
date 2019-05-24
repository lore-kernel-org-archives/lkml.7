Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995F7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6665E2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbfEXI04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:26:56 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:21283 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389046AbfEXI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:26:55 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 24 May
 2019 16:26:54 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 24 May
 2019 16:26:53 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Fri, 24 May 2019 16:26:53 +0800
From:   TonyWWang-oc <TonyWWang-oc@zhaoxin.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
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
Thread-Index: AdURTsiYNBazyGlVQHaDmthi3UM1jP//fnaA//5akmA=
Date:   Fri, 24 May 2019 08:26:53 +0000
Message-ID: <8be0aea838404246ac06b106c2099259@zhaoxin.com>
References: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
 <20190523101957.GB11016@kroah.com>
In-Reply-To: <20190523101957.GB11016@kroah.com>
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

T24gVGh1LCBNYXkgMjMsIDIwMTksIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0K
Pj4gKyAqIFRoaXMgZmlsZSBpcyBsaWNlbnNlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsDQo+PiArICogTGljZW5zZSB2Mi4wIG9yIGxhdGVyLiBTZWUgZmlsZSBDT1BZSU5HIGZv
ciBkZXRhaWxzLg0KPg0KPlRoYXQgY29udHJpZGljdHMgdGhlIGZpcnN0IGxpbmUgb2YgdGhlIGZp
bGUgOigNCj4NCj5QbGVhc2Ugc29ydCB0aGlzIG91dCB3aXRoIHlvdXIgbGF3eWVycyBhbmQgcmVz
ZW5kIGl0IGNvcnJlY3RlZC4NCj4NCj5BbHNvLCBncGwgImJvaWxlcnBsYXRlIiB0ZXh0IGxpa2Ug
dGhpcyBkb2VzIG5vdCBuZWVkIHRvIGJlIGluIHRoZSBmaWxlDQo+aWYgeW91IGp1c3QgaW5jbHVk
ZSB0aGUgc3BkeCBsaW5lLg0KDQpPaywgSSB3aWxsIHNvcnQgdGhpcyBvdXQgd2l0aCBvdXIgbGF3
eWVycywgdGhlbiBhZGp1c3QgdGhpcyB0ZXh0IGNvcnJlY3RseQ0KYmVmb3JlIHJlc2VuZCBpdC4N
Cg0KVGhhbmtzDQpUb255V1dhbmctb2MNCg==
