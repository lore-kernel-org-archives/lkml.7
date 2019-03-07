Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74A42063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCGHtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:49:32 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39645 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGHtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:49:32 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x277nCKL001430, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x277nCKL001430
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Thu, 7 Mar 2019 15:49:12 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0415.000; Thu, 7 Mar
 2019 15:49:12 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     kernel test robot <rong.a.chen@intel.com>
CC:     Johannes Berg <johannes.berg@intel.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "lkp@01.org" <lkp@01.org>
Subject: RE: [LKP] [mac80211]  c752cac9db: hwsim.ap_vlan_iface_cleanup_multibss_per_sta_vif.fail
Thread-Topic: [LKP] [mac80211]  c752cac9db:
 hwsim.ap_vlan_iface_cleanup_multibss_per_sta_vif.fail
Thread-Index: AQHU1LQSuWimyP1n2kK8SVey/nhNFqX/ycDA
Date:   Thu, 7 Mar 2019 07:49:11 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17B4425@RTITMBSVM04.realtek.com.tw>
References: <20190307070450.GO25100@shao2-debian>
In-Reply-To: <20190307070450.GO25100@shao2-debian>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.124]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbToga2VybmVsIHRlc3Qgcm9i
b3QgW21haWx0bzpyb25nLmEuY2hlbkBpbnRlbC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJj
aCAwNywgMjAxOSAzOjA1IFBNDQo+IFRvOiBUb255IENodWFuZw0KPiBDYzogSm9oYW5uZXMgQmVy
ZzsgTGFycnkgRmluZ2VyOyBMS01MOyBMaW51cyBUb3J2YWxkczsgbGtwQDAxLm9yZw0KPiBTdWJq
ZWN0OiBbTEtQXSBbbWFjODAyMTFdIGM3NTJjYWM5ZGI6DQo+IGh3c2ltLmFwX3ZsYW5faWZhY2Vf
Y2xlYW51cF9tdWx0aWJzc19wZXJfc3RhX3ZpZi5mYWlsDQo+IA0KPiBGWUksIHdlIG5vdGljZWQg
dGhlIGZvbGxvd2luZyBjb21taXQgKGJ1aWx0IHdpdGggZ2NjLTgpOg0KPiANCj4gY29tbWl0OiBj
NzUyY2FjOWRiMWIwYzQ2OWRiN2JhOWQxN2FmNGJhNzA4OTg0ZGI1ICgibWFjODAyMTE6IGZpeA0K
PiBHRlBfS0VSTkVMIHVuZGVyIHRhc2tsZXQgY29udGV4dCIpDQo+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdCBtYXN0ZXINCj4g
DQo+IGluIHRlc3RjYXNlOiBod3NpbQ0KPiB3aXRoIGZvbGxvd2luZyBwYXJhbWV0ZXJzOg0KPiAN
Cj4gCWdyb3VwOiBod3NpbS0wMg0KPiANCj4gDQo+IA0KPiBvbiB0ZXN0IG1hY2hpbmU6IHFlbXUt
c3lzdGVtLXg4Nl82NCAtZW5hYmxlLWt2bSAtY3B1IFNhbmR5QnJpZGdlIC1zbXAgMg0KPiAtbSA0
Rw0KPiANCj4gY2F1c2VkIGJlbG93IGNoYW5nZXMgKHBsZWFzZSByZWZlciB0byBhdHRhY2hlZCBk
bWVzZy9rbXNnIGZvciBlbnRpcmUNCj4gbG9nL2JhY2t0cmFjZSk6DQo+IA0KDQo8Li4uPg0KDQo+
IA0KPiAyMDE5LTAzLTA2IDE0OjUxOjE1IAkuL3J1bi10ZXN0cy5weSBhcF92bGFuX2lmYWNlX2Ns
ZWFudXBfbXVsdGlic3MNCj4gREVWOiB3bGFuMDogMDI6MDA6MDA6MDA6MDA6MDANCj4gREVWOiB3
bGFuMTogMDI6MDA6MDA6MDA6MDE6MDANCj4gREVWOiB3bGFuMjogMDI6MDA6MDA6MDA6MDI6MDAN
Cj4gQVBERVY6IHdsYW4zDQo+IEFQREVWOiB3bGFuNA0KPiBTVEFSVCBhcF92bGFuX2lmYWNlX2Ns
ZWFudXBfbXVsdGlic3MgMS8xDQo+IFRlc3Q6IEFQIFZMQU4gb3BlcmF0aW9uIGluIG11bHRpLUJT
UyBtdWx0aS1WTEFOIGNhc2UNCj4gUlRORVRMSU5LIGFuc3dlcnM6IEZpbGUgZXhpc3RzDQo+IFN0
YXJ0aW5nIEFQIHdsYW40DQo+IFN0YXJ0aW5nIGludGVyZmFjZSB3bGFuMw0KPiBDb25uZWN0IFNU
QSB3bGFuMCB0byBBUA0KPiBDb25uZWN0IFNUQSB3bGFuMSB0byBBUA0KPiB3bGFuMCAtPiBWTEFO
IDINCj4gdGVzdCB3bGFuMSA9PSBWTEFOIDENCj4gd2xhbjEgLT4gVkxBTiAyDQo+IHRlc3Qgd2xh
bjAgPT0gVkxBTiAyDQo+IFBBU1MgYXBfdmxhbl9pZmFjZV9jbGVhbnVwX211bHRpYnNzIDMuMDM3
MTE1IDIwMTktMDMtMDYgMTQ6NTE6MTkuMzYyNTM2DQo+IHBhc3NlZCBhbGwgMSB0ZXN0IGNhc2Uo
cykNCj4gMjAxOS0wMy0wNiAxNDo1MToxOSAJLi9ydW4tdGVzdHMucHkNCj4gYXBfdmxhbl9pZmFj
ZV9jbGVhbnVwX211bHRpYnNzX3Blcl9zdGFfdmlmDQo+IERFVjogd2xhbjA6IDAyOjAwOjAwOjAw
OjAwOjAwDQo+IERFVjogd2xhbjE6IDAyOjAwOjAwOjAwOjAxOjAwDQo+IERFVjogd2xhbjI6IDAy
OjAwOjAwOjAwOjAyOjAwDQo+IEFQREVWOiB3bGFuMw0KPiBBUERFVjogd2xhbjQNCj4gU1RBUlQg
YXBfdmxhbl9pZmFjZV9jbGVhbnVwX211bHRpYnNzX3Blcl9zdGFfdmlmIDEvMQ0KPiBUZXN0OiBB
UCBWTEFOIG9wZXJhdGlvbiBpbiBtdWx0aS1CU1MgbXVsdGktVkxBTiBjYXNlIHdpdGggcGVyLXN0
YS12aWYgc2V0DQo+IFN0YXJ0aW5nIEFQIHdsYW40DQo+IFN0YXJ0aW5nIGludGVyZmFjZSB3bGFu
Mw0KPiBDb25uZWN0IFNUQSB3bGFuMCB0byBBUA0KPiBDb25uZWN0IFNUQSB3bGFuMSB0byBBUA0K
PiBkZXYxLT5kZXYyIHVuaWNhc3QgZGF0YSBkZWxpdmVyeSBmYWlsZWQNCj4gVHJhY2ViYWNrICht
b3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KPiAgIEZpbGUgIi4vcnVuLXRlc3RzLnB5IiwgbGluZSA0
NjYsIGluIG1haW4NCj4gICAgIHQoZGV2LCBhcGRldikNCj4gICBGaWxlICIvbGtwL2JlbmNobWFy
a3MvaHdzaW0vdGVzdHMvaHdzaW0vdGVzdF9hcF92bGFuLnB5IiwgbGluZSA1MDUsIGluDQo+IHRl
c3RfYXBfdmxhbl9pZmFjZV9jbGVhbnVwX211bHRpYnNzX3Blcl9zdGFfdmlmDQo+ICAgICAnbXVs
dGktYnNzLWlmYWNlLXBlcl9zdGFfdmlmLmNvbmYnKQ0KPiAgIEZpbGUgIi9sa3AvYmVuY2htYXJr
cy9od3NpbS90ZXN0cy9od3NpbS90ZXN0X2FwX3ZsYW4ucHkiLCBsaW5lIDQxMywgaW4NCj4gYXBf
dmxhbl9pZmFjZV9jbGVhbnVwX211bHRpYnNzDQo+ICAgICBod3NpbV91dGlscy50ZXN0X2Nvbm5l
Y3Rpdml0eV9pZmFjZShkZXZbMV0sIGhhcGQxLCAiYnJ2bGFuMSIpDQo+ICAgRmlsZSAiL2xrcC9i
ZW5jaG1hcmtzL2h3c2ltL3Rlc3RzL2h3c2ltL2h3c2ltX3V0aWxzLnB5IiwgbGluZSAxNzYsIGlu
DQo+IHRlc3RfY29ubmVjdGl2aXR5X2lmYWNlDQo+ICAgICBtYXhfdHJpZXM9bWF4X3RyaWVzLCB0
aW1lb3V0PXRpbWVvdXQpDQo+ICAgRmlsZSAiL2xrcC9iZW5jaG1hcmtzL2h3c2ltL3Rlc3RzL2h3
c2ltL2h3c2ltX3V0aWxzLnB5IiwgbGluZSAxNjksIGluDQo+IHRlc3RfY29ubmVjdGl2aXR5DQo+
ICAgICByYWlzZSBFeGNlcHRpb24obGFzdF9lcnIpDQo+IEV4Y2VwdGlvbjogZGV2MS0+ZGV2MiB1
bmljYXN0IGRhdGEgZGVsaXZlcnkgZmFpbGVkDQo+IEZBSUwgYXBfdmxhbl9pZmFjZV9jbGVhbnVw
X211bHRpYnNzX3Blcl9zdGFfdmlmIDYuOTE3MTQ2IDIwMTktMDMtMDYNCj4gMTQ6NTE6MjYuNzg0
NjY0DQo+IHBhc3NlZCAwIHRlc3QgY2FzZShzKQ0KPiBza2lwcGVkIDAgdGVzdCBjYXNlKHMpDQo+
IGZhaWxlZCB0ZXN0czogYXBfdmxhbl9pZmFjZV9jbGVhbnVwX211bHRpYnNzX3Blcl9zdGFfdmlm
DQoNCjwuLi4+DQoNCj4gDQo+IA0KPiBUbyByZXByb2R1Y2U6DQo+IA0KPiAgICAgICAgICMgYnVp
bGQga2VybmVsDQo+IAljZCBsaW51eA0KPiAJY3AgY29uZmlnLTQuMTkuMC0xMjQ1My1nYzc1MmNh
YyAuY29uZmlnDQo+IAltYWtlIEhPU1RDQz1nY2MtOCBDQz1nY2MtOCBBUkNIPXg4Nl82NCBvbGRk
ZWZjb25maWcNCj4gCW1ha2UgSE9TVENDPWdjYy04IENDPWdjYy04IEFSQ0g9eDg2XzY0IHByZXBh
cmUNCj4gCW1ha2UgSE9TVENDPWdjYy04IENDPWdjYy04IEFSQ0g9eDg2XzY0IG1vZHVsZXNfcHJl
cGFyZQ0KPiAJbWFrZSBIT1NUQ0M9Z2NjLTggQ0M9Z2NjLTggQVJDSD14ODZfNjQgU0hFTEw9L2Jp
bi9iYXNoDQo+IAltYWtlIEhPU1RDQz1nY2MtOCBDQz1nY2MtOCBBUkNIPXg4Nl82NCBiekltYWdl
DQo+IA0KPiANCj4gICAgICAgICBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2xr
cC10ZXN0cy5naXQNCj4gICAgICAgICBjZCBsa3AtdGVzdHMNCj4gICAgICAgICBiaW4vbGtwIHFl
bXUgLWsgPGJ6SW1hZ2U+IGpvYi1zY3JpcHQgIyBqb2Itc2NyaXB0IGlzIGF0dGFjaGVkIGluIHRo
aXMNCj4gZW1haWwNCj4gDQo+IA0KPiANCj4gVGhhbmtzLA0KPiBSb25nIENoZW4NCg0KDQpJdCBs
b29rcyByZWFsbHkgc3RyYW5nZSB0aGF0IHRoaXMgcGF0Y2ggZmFpbGVkIHRoZSB0ZXN0Lg0KQW5k
IEkgY2hlY2tlZCB0aGUgZG1lc2csIHRoZSBsb2cgc2hvd3MgbWUgdGhhdA0KDQpQQVNTIGFwX3Zs
YW5faWZhY2VfY2xlYW51cF9tdWx0aWJzc19wZXJfc3RhX3ZpZg0KDQpBdCBsaW5lIDI0MDAwLg0K
DQpTbyBJIHRoaW5rIEkgbmVlZCB0byByZXByb2R1Y2UgdGhpcyB0byBjb25maXJtIGl0Lg0KT3Ig
YW55b25lIGhhcyBhbnkgaWRlYSBwbGVhc2UgbGV0IG1lIGtub3cuDQpUaGFua3MNCg0KWWFuLUhz
dWFuDQo=
