Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA59FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E1C2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389563AbfEXIay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:30:54 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:12392 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389046AbfEXIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:30:54 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 24 May
 2019 16:30:51 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 24 May
 2019 16:30:50 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Fri, 24 May 2019 16:30:50 +0800
From:   TonyWWang-oc <TonyWWang-oc@zhaoxin.com>
To:     Borislav Petkov <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
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
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjEgMS8zXSB4ODYvY3B1OiBDcmVhdGUgWmhhb3hp?=
 =?utf-8?Q?n_processors_architecture_support_file?=
Thread-Topic: [PATCH v1 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
Thread-Index: AdURTsiYNBazyGlVQHaDmthi3UM1jP//f6yAgAAVZYD//m7OAA==
Date:   Fri, 24 May 2019 08:30:50 +0000
Message-ID: <a2dffc4698c749f3987efb55dd638509@zhaoxin.com>
References: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
 <20190523102417.GC11016@kroah.com> <20190523114051.GA3268@cz.tnic>
In-Reply-To: <20190523114051.GA3268@cz.tnic>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.23]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMjMsIDIwMTksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4+IFRoaXMgcGF0
Y2ggaXMgdG90YWxseSBjb3JydXB0ZWQsIHdpdGggbGVhZGluZyBzcGFjZXMgZHJvcHBlZCBhbmQg
dGFicw0KPj4gdHVybmVkIGludG8gc3BhY2VzLiAgUGxlYXNlIHJlYWQgdGhlIGVtYWlsIGNsaWVu
dCBkb2N1bWVudGF0aW9uIGluIHRoZQ0KPj4ga2VybmVsIGRpcmVjdG9yeSBmb3IgaG93IHRvIGZp
eCB5b3VyIGVtYWlsIGNsaWVudCwgb3IganVzdCB1c2UgJ2dpdA0KPj4gc2VuZC1lbWFpbCcgdG8g
c2VuZCB0aGUgcGF0Y2hlcyBvdXQgZGlyZWN0bHkuDQo+DQo+Li4gYW5kIGJlZm9yZSB5b3UgZG8g
dGhhdCwgcnVuIHRoZW0gYWxsIHRocm91Z2ggY2hlY2twYXRjaC5wbCBhbmQgYXBwbHkNCj5jb21t
b24gc2Vuc2Ugd2hlbiBmaXhpbmcgdGhlIHdhcm5pbmdzIGZyb20gaXQ6DQoNCk9rLCBJIHdpbGwg
cnVuIG15IHBhdGNoZXMgdGhyb3VnaCBjaGVja3BhdGNoLnBsIGFuZCBtb2RpZnkgdGhlbSBwcm9w
ZXJseQ0KYmVmb3JlIHJlc2VuZC4NCg0KVGhhbmtzDQpUb255V1dhbmctb2MNCg==
