Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F07BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E61720854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCGR6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:58:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41212 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbfCGR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:58:05 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27Hpuos008259;
        Thu, 7 Mar 2019 18:57:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhkngg4a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 07 Mar 2019 18:57:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 40DF438;
        Thu,  7 Mar 2019 17:57:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 05ED6572C;
        Thu,  7 Mar 2019 17:57:46 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 7 Mar
 2019 18:57:45 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Thu, 7 Mar 2019 18:57:45 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: RE: [PATCH] irqchip: stm32: don't set rising configuration registers
 at init
Thread-Topic: [PATCH] irqchip: stm32: don't set rising configuration registers
 at init
Thread-Index: AQHU1QD7RMigUJWrgUiPC0+O3u7LzKYATfOAgAAbASD///eOAIAAEpMQ
Date:   Thu, 7 Mar 2019 17:57:45 +0000
Message-ID: <d6e4ee19fb014f0b95a6ad636e3bffa8@SFHDAG5NODE3.st.com>
References: <1551975317-5171-1-git-send-email-fabien.dessenne@st.com>
 <6ee8e9dc-f331-7bc9-64e2-8978ab17aed1@arm.com>
 <6817f02f47b4436cb9911371f91523ba@SFHDAG5NODE3.st.com>
 <bd9a176c-42cc-1238-0578-4c994c864151@arm.com>
In-Reply-To: <bd9a176c-42cc-1238-0578-4c994c864151@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBaeW5naWVyIDxt
YXJjLnp5bmdpZXJAYXJtLmNvbT4NCj4gU2VudDogamV1ZGkgNyBtYXJzIDIwMTkgMTg6NDYNCj4g
VG86IEZhYmllbiBERVNTRU5ORSA8ZmFiaWVuLmRlc3Nlbm5lQHN0LmNvbT47IFRob21hcyBHbGVp
eG5lcg0KPiA8dGdseEBsaW51dHJvbml4LmRlPjsgSmFzb24gQ29vcGVyIDxqYXNvbkBsYWtlZGFl
bW9uLm5ldD47IE1heGltZSBDb3F1ZWxpbg0KPiA8bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47
IEFsZXhhbmRyZSBUT1JHVUUNCj4gPGFsZXhhbmRyZS50b3JndWVAc3QuY29tPjsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtDQo+IG1haWxtYW4uc3Rvcm1y
ZXBseS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogQmVu
amFtaW4gR0FJR05BUkQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gaXJxY2hpcDogc3RtMzI6IGRvbid0IHNldCByaXNpbmcgY29uZmlndXJhdGlvbiBy
ZWdpc3RlcnMgYXQgaW5pdA0KPiANCj4gT24gMDcvMDMvMjAxOSAxNzoyNCwgRmFiaWVuIERFU1NF
Tk5FIHdyb3RlOg0KPiA+IEhpDQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29tPg0KPiA+
PiBTZW50OiBqZXVkaSA3IG1hcnMgMjAxOSAxNzo0MA0KPiA+PiBUbzogRmFiaWVuIERFU1NFTk5F
IDxmYWJpZW4uZGVzc2VubmVAc3QuY29tPjsgVGhvbWFzIEdsZWl4bmVyDQo+ID4+IDx0Z2x4QGxp
bnV0cm9uaXguZGU+OyBKYXNvbiBDb29wZXIgPGphc29uQGxha2VkYWVtb24ubmV0PjsgTWF4aW1l
DQo+ID4+IENvcXVlbGluIDxtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tPjsgQWxleGFuZHJlIFRP
UkdVRQ0KPiA+PiA8YWxleGFuZHJlLnRvcmd1ZUBzdC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiA+PiBsaW51eC1zdG0zMkBzdC1tZC0gbWFpbG1hbi5zdG9ybXJlcGx5LmNv
bTsNCj4gPj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4+IENjOiBC
ZW5qYW1pbiBHQUlHTkFSRCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBpcnFjaGlwOiBzdG0zMjogZG9uJ3Qgc2V0IHJpc2luZyBjb25maWd1cmF0
aW9uDQo+ID4+IHJlZ2lzdGVycyBhdCBpbml0DQo+ID4+DQo+ID4+IE9uIDA3LzAzLzIwMTkgMTY6
MTUsIEZhYmllbiBEZXNzZW5uZSB3cm90ZToNCj4gPj4+IFRoZSByaXNpbmcgY29uZmlndXJhdGlv
biBzdGF0dXMgcmVnaXN0ZXIgKHJ0c3IpIGlzIG5vdCBiYW5rZWQuDQo+ID4+PiBBcyBpdCBpcyBz
aGFyZWQgd2l0aCB0aGUgY28tcHJvY2Vzc29yLCBpdCBzaG91bGQgbm90IGJlIHdyaXR0ZW4gYXQN
Cj4gPj4+IHByb2JlIHRpbWUsIGVsc2UgdGhlIGNvLXByb2Nlc3NvciBjb25maWd1cmF0aW9uIHdp
bGwgYmUgbG9zdC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4gRGVzc2VubmUg
PGZhYmllbi5kZXNzZW5uZUBzdC5jb20+DQo+ID4+DQo+ID4+IEZpeGVzOj8NCj4gPj4NCj4gPj4+
IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvaXJxY2hpcC9pcnEtc3RtMzItZXh0aS5jIHwgNSAtLS0tLQ0K
PiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLXN0bTMyLWV4dGkuYw0KPiA+Pj4gYi9kcml2ZXJz
L2lycWNoaXAvaXJxLXN0bTMyLWV4dGkuYw0KPiA+Pj4gaW5kZXggNmVkZmQ0Yi4uZmY4YTg0ZiAx
MDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtc3RtMzItZXh0aS5jDQo+ID4+
PiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLXN0bTMyLWV4dGkuYw0KPiA+Pj4gQEAgLTcxNiw3
ICs3MTYsNiBAQCBzdG0zMl9leHRpX2NoaXBfZGF0YQ0KPiA+Pj4gKnN0bTMyX2V4dGlfY2hpcF9p
bml0KHN0cnVjdA0KPiA+PiBzdG0zMl9leHRpX2hvc3RfZGF0YSAqaF9kYXRhLA0KPiA+Pj4gIAlj
b25zdCBzdHJ1Y3Qgc3RtMzJfZXh0aV9iYW5rICpzdG0zMl9iYW5rOw0KPiA+Pj4gIAlzdHJ1Y3Qg
c3RtMzJfZXh0aV9jaGlwX2RhdGEgKmNoaXBfZGF0YTsNCj4gPj4+ICAJdm9pZCBfX2lvbWVtICpi
YXNlID0gaF9kYXRhLT5iYXNlOw0KPiA+Pj4gLQl1MzIgaXJxc19tYXNrOw0KPiA+Pj4NCj4gPj4+
ICAJc3RtMzJfYmFuayA9IGhfZGF0YS0+ZHJ2X2RhdGEtPmV4dGlfYmFua3NbYmFua19pZHhdOw0K
PiA+Pj4gIAljaGlwX2RhdGEgPSAmaF9kYXRhLT5jaGlwc19kYXRhW2JhbmtfaWR4XTsgQEAgLTcy
NSwxMCArNzI0LDYgQEANCj4gPj4+IHN0bTMyX2V4dGlfY2hpcF9kYXRhICpzdG0zMl9leHRpX2No
aXBfaW5pdChzdHJ1Y3QNCj4gPj4+IHN0bTMyX2V4dGlfaG9zdF9kYXRhICpoX2RhdGEsDQo+ID4+
Pg0KPiA+Pj4gIAlyYXdfc3Bpbl9sb2NrX2luaXQoJmNoaXBfZGF0YS0+cmxvY2spOw0KPiA+Pj4N
Cj4gPj4+IC0JLyogRGV0ZXJtaW5lIG51bWJlciBvZiBpcnFzIHN1cHBvcnRlZCAqLw0KPiA+Pj4g
LQl3cml0ZWxfcmVsYXhlZCh+MFVMLCBiYXNlICsgc3RtMzJfYmFuay0+cnRzcl9vZnN0KTsNCj4g
Pj4+IC0JaXJxc19tYXNrID0gcmVhZGxfcmVsYXhlZChiYXNlICsgc3RtMzJfYmFuay0+cnRzcl9v
ZnN0KTsNCj4gPj4+IC0NCj4gPj4NCj4gPj4gQW5kIEkgZ3Vlc3MgeW91IGRvbid0IG5lZWQgdG8g
ZmluZCBvdXQgdGhlIG51bWJlciBvZiBzdXBwb3J0ZWQgSVJRcz8NCj4gPg0KPiA+IFRoYXQncyBj
b3JyZWN0LCB0aGlzIGluZm9ybWVkIGlzIHVzZWxlc3MgOiBpcnFzX21hc2sgaXMgbmV2ZXIgdXNl
ZCAoaXQNCj4gPiB1c2VkIHRvIGJlIG91dHB1dCBpbiBhIGxvZyBmb3IgZGVidWcgcHVycG9zZS5h
bmQgdGhlIGxvZyBoYXMgYmVlbg0KPiA+IHJlbW92ZWQpDQo+ID4NCj4gPg0KPiA+Pg0KPiA+PiBB
bHNvLCBhIGhhbmRmdWwgb2YgbGluZXMgZG93biwgeW91J3JlIHdyaXRpbmcgYWdhaW4gdG8gdGhl
IHNhbWUNCj4gPj4gcmVnaXN0ZXIuIFdoeSBpc24ndCB0aGF0IGEgcHJvYmxlbT8NCj4gPg0KPiA+
IEl0J3Mgb2J2aW91c2x5IGEgcHJvYmxlbSA6IGFub3RoZXIgcGF0Y2ggaXMgbWlzc2luZywgSSBh
bSBnb2luZyB0byBhZGQgaXQgaW4gdjIuDQo+ID4gVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91
dCENCj4gDQo+IFlvdSBhcmUgYWxzbyBoYXBwaWx5IHdyaXRpbmcgdG8gdGhhdCByZWdpc3RlciBp
biBvdGhlciBwbGFjZXMgdmlhIHN0bTMyX2V4dGlfc2V0X2JpdA0KPiBhbmQgY28uIEFsbCB0aGF0
IGlzIGRvbmUgd2l0aG91dCBhbnkgY29vcGVyYXRpb24gd2l0aCB0aGUgY29wcm9jZXNzb3IgKHdo
YXRldmVyDQo+IHRoYXQgaXMuLi4pLCBzbyBJIHJlYWxseSB3b25kZXIgaWYgaXQgYWxsIHdvcmtz
IGJ5IG1hZ2ljIG9yIGx1Y2suLi4NCg0KVGhlcmUgaXMgY2VydGFpbmx5IHNvbWUgbWFnaWMgYW5k
IGx1Y2shIEJ1dCB0aGVyZSBpcyBhIGJpdCBtb3JlIDogdGhlIGFjY2VzcyB0byBib3RoIHJ0c3Ig
YW5kIGZ0c3IgcmVncyBhcmUgY29udHJvbGxlZCB3aXRoIGEgY2FsbCB0byBzdG0zMl9leHRpX2h3
c3Bpbl9sb2NrKCkgd2hpY2ggdXNlcyBhbiBIV1NwaW5sb2NrIHNoYXJlZCB3aXRoIHRoZSBjb3By
b2Nlc3Nvci4NClRoZSBvdGhlciByZWdpc3RlcnMgYXJlIG5vdCBhY2Nlc3NlZCBieSB0aGUgY29w
cm9jZXNzb3IsIGhlbmNlIGFyZSBub3QgaHdzcGlubG9jay1wcm90ZWN0ZWQuDQoNCg0KPiANCj4g
VGhhbmtzLA0KPiANCj4gCU0uDQo+IC0tDQo+IEphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qgc21l
bGxzIGZ1bm55Li4uDQo=
