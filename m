Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FFFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F8620675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbfEXI26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:28:58 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:21578 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389046AbfEXI26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:28:58 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 24 May
 2019 16:28:54 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 24 May
 2019 16:28:53 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Fri, 24 May 2019 16:28:53 +0800
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
Thread-Index: AdURTsiYNBazyGlVQHaDmthi3UM1jP//f6yA//5aa1A=
Date:   Fri, 24 May 2019 08:28:53 +0000
Message-ID: <2fa6fa90739d4900a1991492f377d8c0@zhaoxin.com>
References: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
 <20190523102417.GC11016@kroah.com>
In-Reply-To: <20190523102417.GC11016@kroah.com>
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
Pj4gVG8gaWRlbnRpZnkgWmhhb3hpbiBDUFUsIGFkZCBhIG5ldyB2ZW5kb3IgdHlwZSBYODZfVkVO
RE9SX1pIQU9YSU4NCj4+IGZvciBzeXN0ZW0gcmVjb2duaXRpb24uDQo+PiANCj4+IFNpZ25lZC1v
ZmYtYnk6IFRvbnlXV2FuZyA8VG9ueVdXYW5nLW9jQHpoYW94aW4uY29tPg0KPg0KPlNvbWUgYmFz
aWMgcGF0Y2ggdGlwcy4gIFlvdXIgRnJvbTogbGluZSBuZWVkcyB0byBtYXRjaCB0aGUgc2lnbmVk
LW9mZi1ieQ0KPmxpbmUsIHdoaWNoIGlzIG5vdCB0cnVlIGhlcmUuICBBbHNvLCBwbGVhc2UgdXNl
IHlvdXIgbmFtZSB3aXRoICcgJw0KPmNoYXJhY3RlcnMuDQoNClRoYW5rIHlvdSwgSSB3aWxsIGZv
bGxvdyB0aGVzZSB0aXBzLiANCg0KPg0KPj4gK3N0YXRpYyB2b2lkIGluaXRfemhhb3hpbl9jYXAo
c3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPj4gK3sNCj4+ICsgICB1MzIgIGxvLCBoaTsNCj4+ICsN
Cj4+ICsgICAvKiBUZXN0IGZvciBFeHRlbmRlZCBGZWF0dXJlIEZsYWdzIHByZXNlbmNlICovDQo+
PiArICAgaWYgKGNwdWlkX2VheCgweEMwMDAwMDAwKSA+PSAweEMwMDAwMDAxKSB7DQo+PiArICAg
ICAgdTMyIHRtcCA9IGNwdWlkX2VkeCgweEMwMDAwMDAxKTsNCj4NCj5UaGlzIHBhdGNoIGlzIHRv
dGFsbHkgY29ycnVwdGVkLCB3aXRoIGxlYWRpbmcgc3BhY2VzIGRyb3BwZWQgYW5kIHRhYnMNCj50
dXJuZWQgaW50byBzcGFjZXMuICBQbGVhc2UgcmVhZCB0aGUgZW1haWwgY2xpZW50IGRvY3VtZW50
YXRpb24gaW4gdGhlDQo+a2VybmVsIGRpcmVjdG9yeSBmb3IgaG93IHRvIGZpeCB5b3VyIGVtYWls
IGNsaWVudCwgb3IganVzdCB1c2UgJ2dpdA0KPnNlbmQtZW1haWwnIHRvIHNlbmQgdGhlIHBhdGNo
ZXMgb3V0IGRpcmVjdGx5Lg0KDQpTb3JyeSBmb3IgdGhhdCEgSSAgd2FzIG1hZGUgYSBtaXN0YWtl
IHRvIHNlbmQgdGhlIHBhdGNoIHdpdGggSFRNTCBmb3JtYXQuDQpJIHdpbGwgc2V0IHVwIG15IGVt
YWlsIGNsaWVudCBjb3JyZWN0bHkuDQoNClRoYW5rcw0KVG9ueVdXYW5nLW9jDQo=
