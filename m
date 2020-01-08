Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF25AC33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879B32075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgAHCTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:19:21 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgAHCTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:19:21 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 0AB3E2A886DD3E53896B;
        Wed,  8 Jan 2020 10:19:19 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0439.000;
 Wed, 8 Jan 2020 10:19:08 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
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
Thread-Index: AQHVuWnsK0zwK8RxTkqe/SNAoYeaUKfT+S+AgALBI6CAAAyngIAAlqWw//+IwoCAAXt3QP//7niAgAAVeoCAAFV+gIAENd2QgABR3QCAAtw2YA==
Date:   Wed, 8 Jan 2020 02:19:06 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340B8644@dggemm526-mbx.china.huawei.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <7b375d79-2d3c-422b-27a6-68972fbcbeaf@arm.com>
 <66943c82-2cfd-351b-7f36-5aefdb196a03@arm.com>
 <c0e82c31-8ed6-4739-6b01-2594c58df95a@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340B3203@dggemm526-mbx.china.huawei.com>
 <51a7d543-e35f-6492-fa51-02828832c154@arm.com>
In-Reply-To: <51a7d543-e35f-6492-fa51-02828832c154@arm.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEaWV0bWFyIEVnZ2VtYW5uIFtt
YWlsdG86ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tXQ0KPiBTZW50OiBNb25kYXksIEphbnVhcnkg
MDYsIDIwMjAgMTA6MzEgUE0NCj4gVG86IFplbmd0YW8gKEIpOyBWYWxlbnRpbiBTY2huZWlkZXI7
IFN1ZGVlcCBIb2xsYQ0KPiBDYzogTGludXhhcm07IEdyZWcgS3JvYWgtSGFydG1hbjsgUmFmYWVs
IEouIFd5c29ja2k7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1vcnRlbiBSYXNt
dXNzZW4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY3B1LXRvcG9sb2d5OiB3YXJuIGlmIE5VTUEg
Y29uZmlndXJhdGlvbnMgY29uZmxpY3RzDQo+IHdpdGggbG93ZXIgbGF5ZXINCj4gDQo+IE9uIDA2
LzAxLzIwMjAgMDI6NDgsIFplbmd0YW8gKEIpIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IERpZXRtYXIgRWdnZW1hbm4g
W21haWx0bzpkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb21dDQo+ID4+IFNlbnQ6IFNhdHVyZGF5LCBK
YW51YXJ5IDA0LCAyMDIwIDE6MjEgQU0NCj4gPj4gVG86IFZhbGVudGluIFNjaG5laWRlcjsgWmVu
Z3RhbyAoQik7IFN1ZGVlcCBIb2xsYQ0KPiA+PiBDYzogTGludXhhcm07IEdyZWcgS3JvYWgtSGFy
dG1hbjsgUmFmYWVsIEouIFd5c29ja2k7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IE1vcnRlbiBSYXNtdXNzZW4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY3B1LXRvcG9s
b2d5OiB3YXJuIGlmIE5VTUEgY29uZmlndXJhdGlvbnMNCj4gY29uZmxpY3RzDQo+ID4+IHdpdGgg
bG93ZXIgbGF5ZXINCj4gPj4NCj4gPj4gT24gMDMvMDEvMjAyMCAxMzoxNCwgVmFsZW50aW4gU2No
bmVpZGVyIHdyb3RlOg0KPiA+Pj4gT24gMDMvMDEvMjAyMCAxMDo1NywgVmFsZW50aW4gU2NobmVp
ZGVyIHdyb3RlOg0KPiANCj4gPj4gU3RpbGwgZG9uJ3Qgc2VlIHRoZSBhY3R1YWwgcHJvYmxlbSBj
YXNlLiBUaGUgY2xvc2VzdCBJIGNhbWUgaXM6DQo+ID4+DQo+ID4+IHFlbXUtc3lzdGVtLWFhcmNo
NjQgLWtlcm5lbCAuLi4gLWFwcGVuZCAnIC4uLiBsb2dsZXZlbD04IHNjaGVkX2RlYnVnJw0KPiA+
PiAtc21wIGNvcmVzPTQsc29ja2V0cz0yIC4uLiAtbnVtYSBub2RlLGNwdXM9MC0yLG5vZGVpZD0w
DQo+ID4+IC1udW1hIG5vZGUsY3B1cz0zLTcsbm9kZWlkPTENCj4gPj4NCj4gPg0KPiA+IEl0J3Mg
cmVsYXRlZCB0byB0aGUgSFcgdG9wb2xvZ3ksIGlmIHlvdSBodyBoYXZlIGdvdCAyIGNsdXN0ZXJz
IDB+MywgNH43LA0KPiA+IHdpdGggdGhlIG1haW5saW5lIHFlbXUsIHlvdSB3aWxsIHNlZSB0aGUg
aXNzdWUuDQo+ID4gSSB0aGluayB5b3UgY2FuIG1hbnVhbGx5IG1vZGlmeSB0aGUgTVBJRFIgcGFy
c2luZyB0byByZXByb2R1Y2UgdGhlDQo+ID4gaXNzdWUuDQo+ID4gTGludXggd2lsbCB1c2UgdGhl
IE1QSURSIHRvIGd1ZXNzIHRoZSBNQyB0b3BvbG9neSBzaW5jZSBjdXJyZW50bHkgcWVtdQ0KPiA+
IGRvbid0IHByb3ZpZGUgaXQuDQo+ID4gUmVmZXIgdG86IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFi
cy5vcmcvY292ZXIvOTM5MzAxLw0KPiANCj4gVGhhdCBtYWtlcyBzZW5zZSB0byBtZS4gVmFsZW50
aW4gYW5kIEkgYWxyZWFkeSBkaXNjdXNzZWQgdGhpcyBzZXR1cCBhcyBhDQo+IHBvc3NpYmxlIHN5
c3RlbSB3aGVyZSB0aGlzIGlzc3VlIGNhbiBoYXBwZW4uDQo+IA0KPiBJIGFscmVhZHkgc3VzcGVj
dGVkIHRoYXQgdmlydCBtYWNoaW5lcyBvbmx5IHN1cHBvcnQgZmxhdCBjcHUgdG9wbG9neS4NCj4g
R29vZCB0byBrbm93LiBBbHRob3VnaCBJIHdhcyBhYmxlIHRvIHRvIHBhc3MgJy4uLiAtc21wIGNv
cmVzPTggLWR0Yg0KPiBmb28uZHRiIC4uLicgaW50byBtYWlubGluZSBxZW11IHRvIGFjaGlldmUg
YSAyIGNsdXN0ZXIgc3lzdGVtIChNQyBhbmQNCj4gRElFIHNkIGxldmVsKSB3aXRoIGFuIGV4dHJh
IGNwdS1tYXAgZW50cnkgaW4gdGhlIGR0cyBmaWxlOg0KPiANCj4gICAgICAgICAgICAgICAgY3B1
LW1hcCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsdXN0ZXIwIHsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb3JlMCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjcHUgPSA8JkE1M18wPjsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB9Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAg
Y2x1c3RlcjEgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvcmUwIHsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdSA9IDwmQTUzXzQ+Ow0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLi4uDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ICAgICAg
ICAgICAgICAgICB9Ow0KPiANCj4gQnV0IEkgZGlkbid0IHN1Y2NlZWQgaW4gY29tYmluaW5nIHRo
aXMgd2l0aCB0aGUgJy4uLiAtbnVtYQ0KPiBub2RlLGNwdXM9MC0zLG5vZGVpZD0wIC1udW1hIG5v
ZGUsY3B1cz00LTcsbm9kZWlkPTEgLi4uJyBwYXJhbXMgdG8NCj4gY3JlYXRlIGEgc3lzdGVtIGxp
a2UgeW91cnMuDQoNCkkgZ3Vlc3QgdGhhdCB5b3UgaGF2ZSB1c2VkIHlvdXIgb3duIGR0Yiwgc28g
bWF5YmUgeW91IG5lZWQgdG8gc3BlY2lmeSB0aGUgDQpudW1hX25vZGVfaWQgaW4gdGhlIGRldmlj
ZSB0cmVlLg0KTWF5YmUgeW91IGNhbiByZWZlciB0bzoNCkRvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9udW1hLnR4dA0KDQo+IA0KPiBZb3VyIGlzc3VlIGlzIHJlbGF0ZWQgdG8gdGhl
ICdudW1hIG1hc2sgY2hlY2sgZm9yIHNjaGVkdWxlciBNQw0KPiBzZWxlY3Rpb24nIGZ1bmN0aW9u
YWxpdHkuICBJdCB3YXMgaW50cm9kdWNlZCBieSBjb21taXQgMzdjM2VjMmQ4MTBmIGFuZA0KPiBy
ZS1pbnRyb2R1Y2VkIGJ5IGNvbW1pdCBlNjdlY2Y2NDcwMjAgbGF0ZXIuIEkgZG9uJ3Qga25vdyB3
aHkgd2UgbmVlZA0KPiB0aGlzIGZ1bmN0aW9uYWxpdHk/DQo+IA0KPiBIb3cgZG9lcyB5b3VyIHNl
dHVwIGJlaGF2ZSB3aGVuIHlvdSByZXZlcnQgY29tbWl0IGU2N2VjZjY0NzAyMD8gT3INCj4gZG8N
Cj4geW91IHdhbnQgYW4gZXhwbGljaXQgd2FybmluZyBpbiBjYXNlIG9mIE5VTUEgYm91bmRhcmll
cyBub3QgcmVzcGVjdGluZw0KPiBwaHlzaWNhbCB0b3BvbG9neT8NCg0KSSB3aWxsIG5lZWQgdG8g
aGF2ZSBhIGxvb2sgdG8gY29tbWl0IGU2N2VjZjY0NzAyMA0KVGhhbmtzIA0KDQpSZWdhcmRzDQpa
ZW5ndGFvIA0KDQo=
