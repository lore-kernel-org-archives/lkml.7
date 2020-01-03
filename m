Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920BC21734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgACEYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 23:24:16 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:36344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgACEYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:24:16 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 75B294AA65AA5774C757;
        Fri,  3 Jan 2020 12:24:13 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0439.000;
 Fri, 3 Jan 2020 12:24:04 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Morten Rasmussen" <morten.rasmussen@arm.com>
Subject: RE: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Topic: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Index: AQHVuWnsK0zwK8RxTkqe/SNAoYeaUKfT+S+AgALBI6CAAAyngIAAlqWw//+IwoCAAXt3QA==
Date:   Fri, 3 Jan 2020 04:24:04 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
In-Reply-To: <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWYWxlbnRpbiBTY2huZWlkZXIg
W21haWx0bzp2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEph
bnVhcnkgMDIsIDIwMjAgOToyMiBQTQ0KPiBUbzogWmVuZ3RhbyAoQik7IFN1ZGVlcCBIb2xsYQ0K
PiBDYzogTGludXhhcm07IEdyZWcgS3JvYWgtSGFydG1hbjsgUmFmYWVsIEouIFd5c29ja2k7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1vcnRlbiBSYXNtdXNzZW4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gY3B1LXRvcG9sb2d5OiB3YXJuIGlmIE5VTUEgY29uZmlndXJhdGlvbnMg
Y29uZmxpY3RzDQo+IHdpdGggbG93ZXIgbGF5ZXINCj4gDQo+IE9uIDAyLzAxLzIwMjAgMTI6NDcs
IFplbmd0YW8gKEIpIHdyb3RlOg0KPiA+Pg0KPiA+PiBBcyBJIHNhaWQsIHdyb25nIGNvbmZpZ3Vy
YXRpb25zIG5lZWQgdG8gYmUgZGV0ZWN0ZWQgd2hlbiBnZW5lcmF0aW5nDQo+ID4+IERUL0FDUEkg
aWYgcG9zc2libGUuIFRoZSBhYm92ZSB3aWxsIHByaW50IHdhcm5pbmcgb24gc3lzdGVtcyB3aXRo
DQo+IE5VTUENCj4gPj4gd2l0aGluIHBhY2thZ2UuDQo+ID4+DQo+ID4+IE5VTUE6ICAwLTcsIDgt
MTUNCj4gPj4gY29yZV9zaWJsaW5nczogICAwLTE1DQo+ID4+DQo+ID4+IFRoZSBhYm92ZSBpcyB0
aGUgZXhhbXBsZSB3aGVyZSB0aGUgZGllIGhhcyAxNiBDUFVzIGFuZCAyIE5VTUENCj4gbm9kZXMN
Cj4gPj4gd2l0aGluIGEgcGFja2FnZSwgeW91ciBjaGFuZ2UgdGhyb3dzIGVycm9yIHRvIHRoZSBh
Ym92ZSBjb25maWcgd2hpY2ggaXMNCj4gPj4gd3JvbmcuDQo+ID4+DQo+ID4gRnJvbSB5b3VyIGV4
YW1wbGUsIHRoZSBjb3JlIDcgYW5kIGNvcmUgOCBoYXMgZ290IGRpZmZlcmVudCBMTEMgYnV0IHRo
ZQ0KPiBzYW1lIExvdw0KPiA+IExldmVsIGNhY2hlPw0KPiANCj4gQUZBSUEgd2hhdCBtYXR0ZXJz
IGhlcmUgaXMgbWVtb3J5IGNvbnRyb2xsZXJzLCBsZXNzIHNvIExMQ3MuIENvcmVzIHdpdGhpbg0K
PiBhIHNpbmdsZSBkaWUgY291bGQgaGF2ZSBwcml2YXRlIExMQ3MgYW5kIHNlcGFyYXRlIG1lbW9y
eSBjb250cm9sbGVycywgb3INCj4gc2hhcmVkIExMQyBhbmQgc2VwYXJhdGUgbWVtb3J5IGNvbnRy
b2xsZXJzLg0KPiANCj4gPiBGcm9tIHNjaGVkdWxlIHZpZXcgb2YgcG9pbnQsIGxvd2VyIGxldmVs
IHNjaGVkIGRvbWFpbiBzaG91bGQgYmUgYSBzdWJzZXQNCj4gb2YgaGlnaGVyDQo+ID4gTGV2ZWwg
c2NoZWQgZG9tYWluLg0KPiA+DQo+IA0KPiBSaWdodCwgYW5kIHRoYXQgaXMgY2hlY2tlZCB3aGVu
IHlvdSBoYXZlIHNjaGVkX2RlYnVnIG9uIHRoZSBjbWRsaW5lDQo+IChvciB3cml0ZSAxIHRvIC9z
eXMva2VybmVsL2RlYnVnL3NjaGVkX2RlYnVnICYgcmVnZW5lcmF0ZSB0aGUgc2NoZWQNCj4gZG9t
YWlucykNCj4gDQoNCk5vLCBoZXJlIEkgdGhpbmsgeW91IGRvbid0IGdldCBteSBpc3N1ZSwgcGxl
YXNlIHRyeSB0byB1bmRlcnN0YW5kIG15IGV4YW1wbGUNCkZpcnN0Oi4NCg0KKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKg0KTlVNQTogICAgICAgICAwLTIsICAzLTcNCmNvcmVf
c2libGluZ3M6ICAgIDAtMywgIDQtNw0KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKg0KV2hlbiB3ZSBhcmUgYnVpbGRpbmcgdGhlIHNjaGVkIGRvbWFpbiwgcGVyIHRoZSBjdXJy
ZW50IGNvZGU6DQooMSkgRm9yIGNvcmUgMw0KIE1DIHNjaGVkIGRvbWFpbiBmYWxsYmFja3MgdG8g
M343DQogRElFIHNjaGVkIGRvbWFpbiBpcyAzfjcNCigyKSBGb3IgY29yZSA0Og0KIE1DIHNjaGVk
IGRvbWFpbiBpcyA0fjcNCiBESUUgc2NoZWQgZG9tYWluIGlzIDN+Nw0KDQpXaGVuIHdlIGFyZSBi
dWlsZCBzY2hlZCBncm91cHMgZm9yIHRoZSBNQyBsZXZlbDoNCigxKS4gY29yZTMncyBzY2hlZCBn
cm91cHMgY2hhaW4gaXMgYnVpbHQgbGlrZSBhczogMy0+NC0+NS0+Ni0+Ny0+MyANCigyKS4gY29y
ZTQncyBzY2hlZCBncm91cHMgY2hhaW4gaXMgYnVpbHQgbGlrZSBhczogNC0+NS0+Ni0+Ny0+NCAN
CnNvIGFmdGVyICgyKSwgDQpjb3JlMydzIHNjaGVkIGdyb3VwcyBpcyBvdmVybGFwcGVkLCBhbmQg
aXQncyBub3QgYSBjaGFpbiBhbnkgbW9yZS4NCkluIHRoZSBhZnRlcndhcmRzIHVzZWNhc2Ugb2Yg
Y29yZTMncyBzY2hlZCBncm91cHMsIGRlYWRsb29wIGhhcHBlbnMuDQoNCkFuZCBpdCdzIGRpZmZp
Y3VsdCBmb3IgdGhlIHNjaGVkdWxlciB0byBmaW5kIG91dCBzdWNoIGVycm9ycywNCnRoYXQgaXMg
d2h5IEkgdGhpbmsgYSB3YXJuaW5nIGlzIG5lY2Vzc2FyeSBoZXJlLg0KDQo+IE5vdywgSSBkb24n
dCBrbm93IGhvdyB0aGlzIHBsYXlzIG91dCBmb3IgdGhlIG51bWEtaW4tcGFja2FnZSB0b3BvbG9n
aWVzDQo+IGxpa2UNCj4gdGhlIG9uZSBzdWdnZXN0ZWQgYnkgU3VkZWVwLiB4ODYgYW5kIEFNRCBo
YWQgdG8gcGxheSBzb21lIGdhbWVzIHRvDQo+IGdldA0KPiBudW1hLWluLXBhY2thZ2UgdG9wb2xv
Z2llcyB3b3JraW5nLCBzZWUgZS5nLg0KPiANCj4gICBjZWJmMTVlYjA5YTIgKCJ4ODYsIHNjaGVk
OiBBZGQgbmV3IHRvcG9sb2d5IGZvciBtdWx0aS1OVU1BLW5vZGUNCj4gQ1BVcyIpDQo+IA0KPiBw
ZXJoYXBzIHlvdSBuZWVkIHRvICJsaWUiIGhlcmUgYW5kIGVuc3VyZSBzdWItTlVNQSBzY2hlZCBk
b21haW4gbGV2ZWxzDQo+IGFyZQ0KPiBhIHN1YnNldCBvZiB0aGUgTlVNQSBsZXZlbHMsIGkuZS4g
bGllIGZvciBjb3JlX3NpYmxpbmdzLiBJIG1pZ2h0IGdvIGFuZA0KPiBwbGF5IHdpdGggdGhpcyB0
byBzZWUgaG93IGl0IGJlaGF2ZXMuDQo=
