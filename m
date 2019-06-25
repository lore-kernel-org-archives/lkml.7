Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619CFC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2E42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfFYGTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:19:22 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:14483 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726495AbfFYGTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:19:22 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 25 Jun
 2019 14:19:16 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 25 Jun
 2019 14:19:15 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Tue, 25 Jun 2019 14:19:15 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     Joe Perches <joe@perches.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW3RpcDp4ODYvY3B1XSB4ODYvY3B1OiBDcmVhdGUgWmhhb3hpbiBw?=
 =?gb2312?Q?rocessors_architecture_support_file?=
Thread-Topic: [tip:x86/cpu] x86/cpu: Create Zhaoxin processors architecture
 support file
Thread-Index: AQHVKOOuJgVCbooVKUWtNKtndOW5M6ancRaAgAR0yTA=
Date:   Tue, 25 Jun 2019 06:19:15 +0000
Message-ID: <505e342c814e4b29ae2a23a6eaf63ea7@zhaoxin.com>
References: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>
         <tip-761fdd5e3327db6c646a09bab5ad48cd42680cd2@git.kernel.org>
 <7ec724a310a710e6415320ff530daba0e1d30505.camel@perches.com>
In-Reply-To: <7ec724a310a710e6415320ff530daba0e1d30505.camel@perches.com>
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

T24gU3VuLCBKdW4gMjMsIDIwMTksIEpvZSBQZXJjaGVzIHdyb3RlOg0KPiA+IHg4Ni9jcHU6IENy
ZWF0ZSBaaGFveGluIHByb2Nlc3NvcnMgYXJjaGl0ZWN0dXJlIHN1cHBvcnQgZmlsZQ0KPiA+DQo+
IFtdDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvemhhb3hpbi5jIGIvYXJj
aC94ODYva2VybmVsL2NwdS96aGFveGluLmMNCj4gW10NCj4gPiArc3RhdGljIHZvaWQgaW5pdF96
aGFveGluX2NhcChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+ID4gK3sNCj4gPiArCXUzMiAgbG8s
IGhpOw0KPiA+ICsNCj4gPiArCS8qIFRlc3QgZm9yIEV4dGVuZGVkIEZlYXR1cmUgRmxhZ3MgcHJl
c2VuY2UgKi8NCj4gPiArCWlmIChjcHVpZF9lYXgoMHhDMDAwMDAwMCkgPj0gMHhDMDAwMDAwMSkg
ew0KPiA+ICsJCXUzMiB0bXAgPSBjcHVpZF9lZHgoMHhDMDAwMDAwMSk7DQo+ID4gKw0KPiA+ICsJ
CS8qIEVuYWJsZSBBQ0UgdW5pdCwgaWYgcHJlc2VudCBhbmQgZGlzYWJsZWQgKi8NCj4gPiArCQlp
ZiAoKHRtcCAmIChBQ0VfUFJFU0VOVCB8IEFDRV9FTkFCTEVEKSkgPT0gQUNFX1BSRVNFTlQpIHsN
Cj4gDQo+IHRyaXZpYToNCj4gDQo+IFBlcmhhcHMgdGhpcyBpcyBtb3JlIGludGVsbGlnaWJsZSBm
b3IgaHVtYW5zIHRvIHJlYWQNCj4gYW5kIGl0IGRlZHVwbGljYXRlcyB0aGUgY29tbWVudCBhczoN
Cj4gDQo+IAkJaWYgKCh0bXAgJiBBQ0VfUFJFU0VOVCkgJiYgISh0bXAgJiBBQ0VfRU5BQkxFRCkp
DQo+IA0KPiBUaGUgY29tcGlsZXIgcHJvZHVjZXMgdGhlIHNhbWUgb2JqZWN0IGNvZGUuDQo+IA0K
DQpUaGFua3MgZm9yIHRoZSB0cml2aWEsIEkgd2lsbCBjaGFuZ2UgdGhpcyBpbiB0aGUgbmV4dCB2
ZXJzaW9uIHBhdGNoIHNldC4NCg0KVGhhbmtzDQpUb255V1dhbmctb2MNCg==
