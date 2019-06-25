Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E0C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805B3204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfFYIPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:15:10 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:28921 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727896AbfFYIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:15:08 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 25 Jun
 2019 16:15:02 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 25 Jun
 2019 16:15:01 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Tue, 25 Jun 2019 16:15:01 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Joe Perches <joe@perches.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW3RpcDp4ODYvY3B1XSB4ODYvY3B1OiBDcmVhdGUgWmhh?=
 =?gb2312?Q?oxin_processors_architecture_support_file?=
Thread-Topic: =?gb2312?B?tPC4tDogW3RpcDp4ODYvY3B1XSB4ODYvY3B1OiBDcmVhdGUgWmhhb3hpbiBw?=
 =?gb2312?Q?rocessors_architecture_support_file?=
Thread-Index: AQHVKOOuJgVCbooVKUWtNKtndOW5M6ancRaAgAR0yTD//4FiAIAAoBow
Date:   Tue, 25 Jun 2019 08:15:01 +0000
Message-ID: <540fd8d21fd043f6a8b49b018fc3b03e@zhaoxin.com>
References: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>
  <tip-761fdd5e3327db6c646a09bab5ad48cd42680cd2@git.kernel.org>
 <7ec724a310a710e6415320ff530daba0e1d30505.camel@perches.com>
 <505e342c814e4b29ae2a23a6eaf63ea7@zhaoxin.com>
 <alpine.DEB.2.21.1906250826550.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906250826550.32342@nanos.tec.linutronix.de>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.75]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyNSBKdW4gMjAxOSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBUb255LA0KPiAN
Cj4gT24gVHVlLCAyNSBKdW4gMjAxOSwgVG9ueSBXIFdhbmctb2Mgd3JvdGU6DQo+ID4gT24gU3Vu
LCBKdW4gMjMsIDIwMTksIEpvZSBQZXJjaGVzIHdyb3RlOg0KPiA+ID4gPiB4ODYvY3B1OiBDcmVh
dGUgWmhhb3hpbiBwcm9jZXNzb3JzIGFyY2hpdGVjdHVyZSBzdXBwb3J0IGZpbGUNCj4gPiA+ID4N
Cj4gPiA+IFtdDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3poYW94
aW4uYw0KPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvemhhb3hpbi5jDQo+ID4gPiBbXQ0KPiA+ID4g
PiArc3RhdGljIHZvaWQgaW5pdF96aGFveGluX2NhcChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+
ID4gPiA+ICt7DQo+ID4gPiA+ICsJdTMyICBsbywgaGk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkv
KiBUZXN0IGZvciBFeHRlbmRlZCBGZWF0dXJlIEZsYWdzIHByZXNlbmNlICovDQo+ID4gPiA+ICsJ
aWYgKGNwdWlkX2VheCgweEMwMDAwMDAwKSA+PSAweEMwMDAwMDAxKSB7DQo+ID4gPiA+ICsJCXUz
MiB0bXAgPSBjcHVpZF9lZHgoMHhDMDAwMDAwMSk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJLyog
RW5hYmxlIEFDRSB1bml0LCBpZiBwcmVzZW50IGFuZCBkaXNhYmxlZCAqLw0KPiA+ID4gPiArCQlp
ZiAoKHRtcCAmIChBQ0VfUFJFU0VOVCB8IEFDRV9FTkFCTEVEKSkgPT0gQUNFX1BSRVNFTlQpIHsN
Cj4gPiA+DQo+ID4gPiB0cml2aWE6DQo+ID4gPg0KPiA+ID4gUGVyaGFwcyB0aGlzIGlzIG1vcmUg
aW50ZWxsaWdpYmxlIGZvciBodW1hbnMgdG8gcmVhZA0KPiA+ID4gYW5kIGl0IGRlZHVwbGljYXRl
cyB0aGUgY29tbWVudCBhczoNCj4gPiA+DQo+ID4gPiAJCWlmICgodG1wICYgQUNFX1BSRVNFTlQp
ICYmICEodG1wICYgQUNFX0VOQUJMRUQpKQ0KPiA+ID4NCj4gPiA+IFRoZSBjb21waWxlciBwcm9k
dWNlcyB0aGUgc2FtZSBvYmplY3QgY29kZS4NCj4gPiA+DQo+ID4NCj4gPiBUaGFua3MgZm9yIHRo
ZSB0cml2aWEsIEkgd2lsbCBjaGFuZ2UgdGhpcyBpbiB0aGUgbmV4dCB2ZXJzaW9uIHBhdGNoIHNl
dC4NCj4gDQo+IGFzIHlvdSBtaWdodCBoYXZlIG5vdGljZWQgZnJvbSB0aGUgdGlwIGJvdCBjb21t
aXQgbm90aWZpY2F0aW9uIG1haWwsIHlvdXINCj4gcGF0Y2ggc2V0IGhhcyBiZWVuIG1lcmdlZCBp
bnRvIHRoZSB0aXAgdHJlZSBhbmQgaXMgcXVldWVkIGZvciB0aGUgNS4zIG1lcmdlDQo+IHdpbmRv
dy4gU28gYSBuZXcgcGF0Y2ggc2V0IGlzIHBvaW50bGVzcy4gSWYgYXQgYWxsIHRoZW4geW91IGNh
biBzZW5kIGENCj4gZGVsdGEgcGF0Y2guDQo+IA0KPiBUaG91Z2ggSSBoYXZlIHRvIHNheSwgdGhh
dCBJIHByZWZlciB0aGUgZXhpc3RpbmcgY2hlY2s6DQo+IA0KPiA+ID4gPiArCQlpZiAoKHRtcCAm
IChBQ0VfUFJFU0VOVCB8IEFDRV9FTkFCTEVEKSkgPT0gQUNFX1BSRVNFTlQpIHsNCj4gDQo+IEl0
J3MgcHJldHR5IGNsZWFyLCBidXQgdGhhdCdzIHJlYWxseSBhIG1hdHRlciBvZiBwZXJzb25hbCBw
cmVmZXJlbmNlLiBTbw0KPiBmcm9tIG15IHNpZGUgdGhlcmUgaXMgbm90aGluZyB0byBkbyBhdCBh
bGwuDQoNCkdvdCBpdCwgSSB3aWxsIG5vdCBjaGFuZ2UgdGhpcyBjb2RlLg0KDQpUaGFua3MNClRv
bnlXV2FuZy1vYw0KDQo=
