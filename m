Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29932C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C2F2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfIIGeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:34:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:3168 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfIIGea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 02:34:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 23:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,483,1559545200"; 
   d="scan'208";a="178248612"
Received: from pgsmsx101.gar.corp.intel.com ([10.221.44.78])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2019 23:34:26 -0700
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.125]) by
 PGSMSX101.gar.corp.intel.com ([169.254.1.57]) with mapi id 14.03.0439.000;
 Mon, 9 Sep 2019 14:34:25 +0800
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint
 support
Thread-Topic: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint
 support
Thread-Index: AQHVZFJP8PyrEMjcjUeZpcb0xW/mNqceLbmAgASxdDA=
Date:   Mon, 9 Sep 2019 06:34:25 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C7402C9EA2@PGSMSX108.gar.corp.intel.com>
References: <1567733058-9561-1-git-send-email-brent.lu@intel.com>
 <391e8f6c-7e35-deb4-4f4d-c39396b778ba@linux.intel.com>
In-Reply-To: <391e8f6c-7e35-deb4-4f4d-c39396b778ba@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTQyOGU1NDgtZWRmZS00OTUyLWI0YmItY2NmNzkxOTgzODVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicytMeTJYeTJBVEcwclJpKzRNcndacGpVejJtMm1cL0RZRHBJNFkxRGhXQzBkOGllcmUyemxPYU5HWTlPTGpxQ2wifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGllcnJlDQoNCldlIGFyZSB3b3JraW5nIG9uIGEgYmFja3BvcnQgMy4xNCBicmFuY2ggZm9y
IENocm9tZSBwcm9qZWN0cyBiYXNlZCBvbiBCRFcgcGxhdGZvcm0uIEluIHRoZSBicmFuY2ggNC1j
aGFubmVsIGNhcHR1cmUgaXMgc3VwcG9ydGVkIG9uIHNvbWUgcGxhdGZvcm1zIGJ1dCBub3QgYWxs
LiBTbyB3ZSBuZWVkIHRvIGFkZCBhIGNvbnN0cmFpbnQgaW4gdGhlIG1hY2hpbmUgZHJpdmVyIGZv
ciBtYWNoaW5lcyBkb24ndCBzdXBwb3J0IHRoaXMgZmVhdHVyZS4NCg0KSSBjaGVja2VkIHRoZSBm
b3ItbmV4dCBicmFuY2ggaW4gdGhlIGJyb29uaWUgcmVwby4gVGhlIGNoYW5uZWxzX21heCBvZiBI
U1dfUENNX0RBSV9JRF9TWVNURU0gaXMgNCBmb3IgY2FwdHVyZSBzdHJlYW0gc28gSSB0aGluayBp
dCB3b3VsZCBoYXZlIHNhbWUgaXNzdWUgbGlrZSBnb29nbGUncyBiYWNrcG9ydCB0cmVlLiBJIGRp
ZG4ndCBmaW5kIGFueSBjb25zdHJhaW50IGZvciB0aGlzIGRhaS4gV291bGQgeW91IHBvaW50IG91
dCB3aGVyZSBpdCBpcz8NCg0KCQkuY2FwdHVyZSA9IHsNCgkJCS5zdHJlYW1fbmFtZSA9ICJBbmFs
b2cgQ2FwdHVyZSIsDQoJCQkuY2hhbm5lbHNfbWluID0gMiwNCgkJCS5jaGFubmVsc19tYXggPSA0
LA0KCQkJLnJhdGVzID0gU05EUlZfUENNX1JBVEVfNDgwMDAsDQoJCQkuZm9ybWF0cyA9IFNORFJW
X1BDTV9GTVRCSVRfUzI0X0xFIHwgU05EUlZfUENNX0ZNVEJJVF9TMTZfTEUsDQoJCX0sDQoNClJl
Z2FyZHMsDQpCcmVudCBMdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGll
cnJlLUxvdWlzIEJvc3NhcnQgW21haWx0bzpwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRl
bC5jb21dIA0KU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgNiwgMjAxOSAxMDoyMSBQTQ0KVG86IEx1
LCBCcmVudCA8YnJlbnQubHVAaW50ZWwuY29tPjsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
DQpDYzogUm9qZXdza2ksIENlemFyeSA8Y2V6YXJ5LnJvamV3c2tpQGludGVsLmNvbT47IGxpYW0u
ci5naXJkd29vZEBsaW51eC5pbnRlbC5jb207IHlhbmcuamllQGxpbnV4LmludGVsLmNvbTsgYnJv
b25pZUBrZXJuZWwub3JnOyBwZXJleEBwZXJleC5jejsgdGl3YWlAc3VzZS5jb207IGt1bmlub3Jp
Lm1vcmltb3RvLmd4QHJlbmVzYXMuY29tOyB0Z2x4QGxpbnV0cm9uaXguZGU7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbYWxzYS1kZXZlbF0gW1BBVENIXSBBU29D
OiBiZHctcnQ1Njc3OiBjaGFubmVsIGNvbnN0cmFpbnQgc3VwcG9ydA0KDQpPbiA5LzUvMTkgODoy
NCBQTSwgQnJlbnQgTHUgd3JvdGU6DQo+IEJEVyBib2FyZHMgdXNpbmcgdGhpcyBtYWNoaW5lIGRy
aXZlciBzdXBwb3J0cyBvbmx5IHN0ZXJlbyBjYXB0dXJlIGFuZCANCj4gcGxheWJhY2suIEltcGxl
bWVudCBhIGNvbnN0cmFpbnQgdG8gZW5mb3JjZSBpdC4NCg0KSHVtbSwgY2FuIHlvdSBjbGFyaWZ5
IHdoYXQgcHJvYmxlbS9lcnJvciB0aGlzIHBhdGNoIGZpeGVzPw0KDQpUaGVyZSBhcmUgYWxyZWFk
eSBjb25zdHJhaW50cyBvbiB0aGUgaHN3X2RhaXNbXSB3aGVyZSB0aGUgY2hhbm5lbHMgYXJlIHN0
ZXJlbyBvbmx5Lg0KDQpUaGFua3MNCi1QaWVycmUNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQnJl
bnQgTHUgPGJyZW50Lmx1QGludGVsLmNvbT4NCj4gLS0tDQo+ICAgc291bmQvc29jL2ludGVsL2Jv
YXJkcy9iZHctcnQ1Njc3LmMgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9pbnRlbC9ib2FyZHMvYmR3LXJ0NTY3Ny5jIA0KPiBiL3NvdW5kL3NvYy9pbnRl
bC9ib2FyZHMvYmR3LXJ0NTY3Ny5jDQo+IGluZGV4IDRhNGQzMzUuLmEzMTJiNTUgMTAwNjQ0DQo+
IC0tLSBhL3NvdW5kL3NvYy9pbnRlbC9ib2FyZHMvYmR3LXJ0NTY3Ny5jDQo+ICsrKyBiL3NvdW5k
L3NvYy9pbnRlbC9ib2FyZHMvYmR3LXJ0NTY3Ny5jDQo+IEBAIC0yMiw2ICsyMiw4IEBADQo+ICAg
DQo+ICAgI2luY2x1ZGUgIi4uLy4uL2NvZGVjcy9ydDU2NzcuaCINCj4gICANCj4gKyNkZWZpbmUg
RFVBTF9DSEFOTkVMIDINCj4gKw0KPiAgIHN0cnVjdCBiZHdfcnQ1Njc3X3ByaXYgew0KPiAgIAlz
dHJ1Y3QgZ3Bpb19kZXNjICpncGlvX2hwX2VuOw0KPiAgIAlzdHJ1Y3Qgc25kX3NvY19jb21wb25l
bnQgKmNvbXBvbmVudDsgQEAgLTI0NSw2ICsyNDcsMzYgQEAgc3RhdGljIA0KPiBpbnQgYmR3X3J0
NTY3N19pbml0KHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpydGQpDQo+ICAgCXJldHVybiAw
Ow0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBjb25zdCB1bnNpZ25lZCBpbnQgY2hhbm5lbHNbXSA9
IHsNCj4gKwlEVUFMX0NIQU5ORUwsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IHNuZF9wY21faHdfY29uc3RyYWludF9saXN0IGNvbnN0cmFpbnRzX2NoYW5uZWxzID0gew0KPiAr
CS5jb3VudCA9IEFSUkFZX1NJWkUoY2hhbm5lbHMpLA0KPiArCS5saXN0ID0gY2hhbm5lbHMsDQo+
ICsJLm1hc2sgPSAwLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGludCBiZHdfZmVfc3RhcnR1cChz
dHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkgew0KPiArCXN0cnVjdCBzbmRfcGNt
X3J1bnRpbWUgKnJ1bnRpbWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7DQo+ICsNCj4gKwkvKg0KPiAr
CSAqIE9uIHRoaXMgcGxhdGZvcm0gZm9yIFBDTSBkZXZpY2Ugd2Ugc3VwcG9ydCwNCj4gKwkgKiBz
dGVyZW8NCj4gKwkgKi8NCj4gKw0KPiArCXJ1bnRpbWUtPmh3LmNoYW5uZWxzX21heCA9IERVQUxf
Q0hBTk5FTDsNCj4gKwlzbmRfcGNtX2h3X2NvbnN0cmFpbnRfbGlzdChydW50aW1lLCAwLCBTTkRS
Vl9QQ01fSFdfUEFSQU1fQ0hBTk5FTFMsDQo+ICsJCQkJCSAgICZjb25zdHJhaW50c19jaGFubmVs
cyk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBzbmRfc29jX29wcyBiZHdfcnQ1Njc3X2ZlX29wcyA9IHsNCj4gKwkuc3RhcnR1cCA9IGJkd19m
ZV9zdGFydHVwLA0KPiArfTsNCj4gKw0KPiAgIC8qIGJyb2Fkd2VsbCBkaWdpdGFsIGF1ZGlvIGlu
dGVyZmFjZSBnbHVlIC0gY29ubmVjdHMgY29kZWMgPC0tPiBDUFUgKi8NCj4gICBTTkRfU09DX0RB
SUxJTktfREVGKGR1bW15LA0KPiAgIAlEQUlMSU5LX0NPTVBfQVJSQVkoQ09NUF9EVU1NWSgpKSk7
DQo+IEBAIC0yNzMsNiArMzA1LDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rIGJk
d19ydDU2NzdfZGFpc1tdID0gew0KPiAgIAkJfSwNCj4gICAJCS5kcGNtX2NhcHR1cmUgPSAxLA0K
PiAgIAkJLmRwY21fcGxheWJhY2sgPSAxLA0KPiArCQkub3BzID0gJmJkd19ydDU2NzdfZmVfb3Bz
LA0KPiAgIAkJU05EX1NPQ19EQUlMSU5LX1JFRyhmZSwgZHVtbXksIHBsYXRmb3JtKSwNCj4gICAJ
fSwNCj4gICANCj4gDQoNCg==
