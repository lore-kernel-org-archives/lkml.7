Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD7EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2F62075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfC1EVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 00:21:32 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:41767 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfC1EVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 00:21:31 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2S4L1WJ013502
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 13:21:01 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2S4L1Wm023440;
        Thu, 28 Mar 2019 13:21:01 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2S4Hs2U018139;
        Thu, 28 Mar 2019 13:21:01 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-3752172; Thu, 28 Mar 2019 13:17:17 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Thu,
 28 Mar 2019 13:17:17 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     "bhe@redhat.com" <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Dave Young" <dyoung@redhat.com>
CC:     "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Topic: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Index: AQHU5R0gSF49+PGwf02T2oxnk4CVXQ==
Date:   Thu, 28 Mar 2019 04:17:16 +0000
Message-ID: <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
References: <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
In-Reply-To: <20190327014852.GA3659@MiWiFi-R3L-srv>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <02CEF9EDAA658F4DAC8380FFA1A6906F@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS8wMy8yNyAxMDo0OCwgYmhlQHJlZGhhdC5jb20gd3JvdGU6DQo+Pj4gU28gZWZpX2dl
dF9yc2RwX2FkZHIoKSBuZWVkcyB0byBiZSByZWZhY3RvcmVkIGluIHN1Y2ggYSB3YXkgc28gdGhh
dCBhdA0KPj4+IGxlYXN0IHRoZSBsb29wIHRvd2FyZHMgdGhlIGVuZCBnZXRzIGNhcnZlZCBvdXQg
aW50byBhIHNlcGFyYXRlIGZ1bmN0aW9uDQo+Pj4gLSBfX2VmaV9nZXRfcnNkcF9hZGRyKCkgb3Ig
c28gLSB3aGljaCBnZXRzIGNvbmZpZ190YWJsZXMsIG5yX3RhYmxlcyBhbmQNCj4+PiBzaXplIGFz
IGFyZ3VtZW50cyBhbmQgZmluZHMgdGhlIFJTRFAgYWRkcmVzcyBpbiB0aGUga2V4ZWMtZWQga2Vy
bmVsLg0KPj4NCj4+IFlvdSBuZWVkIHRvIGNhcnZlIG91dCB0aGUgbG9vcCBhdCB0aGUgZW5kIGFu
ZCBtYWtlIGl0IGludG8gYSBzZXBhcmF0ZQ0KPj4gX19lZmlfZ2V0X3JzZHBfYWRkcigpIGZ1bmN0
aW9uIHdoaWNoIGdldHMgdGhlIHBoeXNpY2FsIG9yIHRoZSB2aXJ0dWFsDQo+PiBhZGRyZXNzLg0K
PiANCj4gSSBndWVzcyBCb3JpcyBpcyBzdWdnZXN0aW5nIGNvZGUgbGlrZSBiZWxvdy4gUGxlYXNl
IGNvcnJlY3QgbWUgaWYgSSBhbQ0KPiB3cm9uZy4NCj4gDQo+IHN0YXRpYyBhY3BpX3BoeXNpY2Fs
X2FkZHJlc3MgX2VmaV9nZXRfcnNkcF9hZGRyKGVmaV9jb25maWdfdGFibGUgdGJsLCAuLi4pDQo+
IHsNCj4gCS8qIEdldCBFRkkgdGFibGVzIGZyb20gc3lzdGFiLiAqLw0KPiAJZm9yIChpID0gMDsg
aSA8IG5yX3RhYmxlczsgaSsrKSB7DQo+IAkJLi4uDQo+IAl9DQo+IAlyZXR1cm4gcnNkcF9hZGRy
Ow0KPiB9DQo+IA0KPiBzdGF0aWMgYWNwaV9waHlzaWNhbF9hZGRyZXNzIGVmaV9nZXRfcnNkcF9h
ZGRyKHZvaWQpDQo+IHsNCj4gCS4uLg0KPiAJLyogR2V0IHN5c3RhYiBmcm9tIGJvb3QgcGFyYW1z
LiAqLwkJDQo+IAkuLi4NCj4gCS8qIEhhbmRsZSBFRkkgYml0bmVzcyBwcm9wZXJseSAqLw0KPiAJ
Li4uDQo+IAlyZXR1cm4gX2VmaV9nZXRfcnNkcF9hZGRyKCk7DQo+IH0NCj4gDQo+IA0KPiBzdGF0
aWMgYWNwaV9waHlzaWNhbF9hZGRyZXNzIGtleGVjX2dldF9yc2RwX2FkZHIodm9pZCkNCj4gew0K
PiAJaWYgKCFpc19rZXhlY19ib290ZWQpDQo+IAkJcmV0dXJuIDA7DQo+IA0KPiAJZWZpX2dldF9z
ZXR1cF9kYXRhX2FkZHIoKTsNCj4gCS4uLg0KPiAJLyogSGFuZGxlIEVGSSBiaXRuZXNzIHByb3Bl
cmx5ICovDQo+IAkuLi4NCj4gCXJldHVybiBfZWZpX2dldF9yc2RwX2FkZHIoKTsNCj4gfQ0KDQpJ
IHN0aWxsIGRvbid0IGdldCBpdC4uLiBXZSBzdGlsbCBuZWVkIHN5c3RhYiBmb3Iga2V4ZWMgY2Fz
ZSBhcyB3ZWxsDQp0byBnZXQgbnJfdGFibGVzLiBEb24ndCB3ZT8NCg0KPiBhY3BpX3BoeXNpY2Fs
X2FkZHJlc3MgZ2V0X3JzZHBfYWRkcih2b2lkKQ0KPiB7DQo+ICAgICAgICAgIGFjcGlfcGh5c2lj
YWxfYWRkcmVzcyBwYTsNCj4gDQo+ICAgICAgICAgIHBhID0gZ2V0X2FjcGlfcnNkcCgpOw0KPiAN
Cj4gICAgICAgICAgaWYgKCFwYSkNCj4gICAgICAgICAgICAgICAgICBwYSA9IGJvb3RfcGFyYW1z
LT5hY3BpX3JzZHBfYWRkcjsNCj4gDQo+IA0KPiAJLyoqDQo+IAkvKkkgdGhpbmsgaGVyZSB3ZSBz
aG91bGQgY2hlY2sgaWYgaXQncyBrZXhlYyBib290ZWQgZmlyc3RseS4NCj4gCSAqIFNraXAgaXQg
aWYgbm90IGtleGVjLiB0aGlzIGNhbiBhdm9pZCB0aGUgd3Jvbmcga2V4ZWMgdmlydA0KPiAJICog
YWRkciBwYXJzaW5nLi8NCj4gICAgICAgICAgaWYgKCFwYSkNCj4gICAgICAgICAgICAgICAgICBw
YSA9IGtleGVjX2dldF9yZHNwX2FkZHIoKTsgICAgICAgICAgICAgPC0tLSBuZXcgZnVuY3Rpb24N
Cj4gDQo+ICAgICAgICAgIGlmICghcGEpDQo+ICAgICAgICAgICAgICAgICAgcGEgPSBlZmlfZ2V0
X3JzZHBfYWRkcigpOw0KPiANCg0KU2hvdWxkbid0IHQgZWZpX2dldF9yc2RwX2FkZHIoKSBjaGVj
ayAiaXNfa2V4ZWNfYm9vdGVkIiBhbmQgZXhpdA0KZWFybHkgc28gdGhhdCBpdCBuZXZlciB0cmll
cyB0byB1c2UgdmlydHVhbCBjb25maWdfdGFibGVzIHBvaW50ZXINCmlmIGZvciBzb21lIHVua25v
d24gcmVzYXNvbiBrZXhlY19nZXRfcnNkcF9hZGRyKCkgZmFpbGVkLg0KDQpDdXJyZW50bHkgSSBj
aGVjayAiaXNfa2V4ZWNfYm9vdGVkIiBieSBzdWJzZXQgb2YgZWZpX2dldF9zZXR1cF9kYXRhX2Fk
ZHIoKS4NCkRvIHlvdSBrbm93IGEgc2ltcGxlciB3YXkgdG8gY2hlY2sgImlzX2tleGVjX2Jvb3Rl
ZCI/DQoNCj4gICAgICAgICAgaWYgKCFwYSkNCj4gICAgICAgICAgICAgICAgICBwYSA9IGJpb3Nf
Z2V0X3JzZHBfYWRkcigpOw0KPiANCj4gICAgICAgICAgcmV0dXJuIHBhOw0KPiB9DQoNCi0tIA0K
SnVuJ2ljaGkgTm9tdXJhLCBORUMgQ29ycG9yYXRpb24gLyBORUMgU29sdXRpb24gSW5ub3ZhdG9y
cywgTHRkLg==

