Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D92C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8535420835
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfEGDhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:37:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:2344 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfEGDhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:37:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 20:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,440,1549958400"; 
   d="scan'208";a="344609157"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2019 20:34:06 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 6 May 2019 20:34:06 -0700
Received: from BGSMSX108.gar.corp.intel.com (10.223.4.192) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 6 May 2019 20:34:05 -0700
Received: from BGSMSX107.gar.corp.intel.com ([169.254.9.125]) by
 BGSMSX108.gar.corp.intel.com ([169.254.8.150]) with mapi id 14.03.0415.000;
 Tue, 7 May 2019 09:04:02 +0530
From:   "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Evan Green <evgreen@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     "M, Naveen" <naveen.m@intel.com>, Ben Zhang <benzh@chromium.org>,
        "Rajat Jain" <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: RE: [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
Thread-Topic: [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
Thread-Index: AQHVBF66kVtld5KEb06yyEGKrvv3D6Zeht+AgAB5C1A=
Date:   Tue, 7 May 2019 03:34:02 +0000
Message-ID: <64FD1F8348A3A14CA3CB4D4C9EB1D15F30A7C756@BGSMSX107.gar.corp.intel.com>
References: <20190506225321.74100-1-evgreen@chromium.org>
 <20190506225321.74100-2-evgreen@chromium.org>
 <74e8cfcd-b99f-7f66-48ce-44d60eb2bbca@linux.intel.com>
In-Reply-To: <74e8cfcd-b99f-7f66-48ce-44d60eb2bbca@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQaWVycmUtTG91aXMgQm9zc2Fy
dCBbbWFpbHRvOnBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbV0gDQpTZW50OiBU
dWVzZGF5LCBNYXkgNywgMjAxOSA3OjExIEFNDQpUbzogRXZhbiBHcmVlbiA8ZXZncmVlbkBjaHJv
bWl1bS5vcmc+OyBMaWFtIEdpcmR3b29kIDxsaWFtLnIuZ2lyZHdvb2RAbGludXguaW50ZWwuY29t
PjsgTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KQ2M6IE0sIE5hdmVlbiA8bmF2ZWVu
Lm1AaW50ZWwuY29tPjsgTSBSLCBTYXRoeWEgUHJha2FzaCA8c2F0aHlhLnByYWthc2gubS5yQGlu
dGVsLmNvbT47IEJlbiBaaGFuZyA8YmVuemhAY2hyb21pdW0ub3JnPjsgUmFqYXQgSmFpbiA8cmFq
YXRqYUBjaHJvbWl1bS5vcmc+OyBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6PjsgYWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBU
YWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuY29tPjsgTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdt
YWlsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8yXSBBU29DOiBTT0Y6IEFkZCBDb21l
dCBMYWtlIFBDSSBJRA0KDQoNCg0KT24gNS82LzE5IDU6NTMgUE0sIEV2YW4gR3JlZW4gd3JvdGU6
DQo+PiBBZGQgc3VwcG9ydCBmb3IgSW50ZWwgQ29tZXQgTGFrZSBwbGF0Zm9ybXMgYnkgYWRkaW5n
IGEgbmV3IEtjb25maWcgZm9yIA0KPj4gQ29tZXRMYWtlIGFuZCB0aGUgYXBwcm9wcmlhdGUgUENJ
IElELg0KDQo+VGhpcyBpcyBvZGQuIEkgY2hlY2tlZCBpbnRlcm5hbGx5IGEgZmV3IHdlZWtzIGJh
Y2sgYW5kIHRoZSBDTUwgUENJIElEIHdhcyA5ZGM4LCBzYW1lIGFzIFdITCBhbmQgQ05MLCBzbyB3
ZSBkaWQgbm90IGFkZCBhIFBDSSBJRCBvbiBwdXJwb3NlLiBUbyB0aGUgYmVzdCBvZiBteSBrbm93
bGVkZ2UgU09GIHByb2JlcyBmaW5lIG9uIENNTCBhbmQgdGhlIGtub3duIGlzc3VlcyBjYW4gYmUg
Zm91bmQgb24gdGhlIFNPRiBnaXRodWIgWzFdLg0KDQpUaGUgUENJIElEIGNoYW5nZSBpcyBzZWVu
IG9uIGxhdGVyIHByb2R1Y3Rpb24gU2kgdmVyc2lvbnMuIFRoZSBQQ0kgSUQgaXMgMDJjOC4NCg0K
PkNhcmUgdG8gc2VuZCB0aGUgbG9nIG9mIHN1ZG8gbHNwY2kgLXMgMDoxZi4zIC12biA/DQoNCkhl
cmUgeW91IGdvOg0KbG9jYWxob3N0IH4gIyBzdWRvIGxzcGNpIC1zIDA6MWYuMyAtdm4NCjAwOjFm
LjMgMDQwMTogODA4NjowMmM4DQogICAgICAgIFN1YnN5c3RlbTogODA4Njo3MjcwDQogICAgICAg
IEZsYWdzOiBmYXN0IGRldnNlbCwgSVJRIDExDQogICAgICAgIE1lbW9yeSBhdCBkMTExNDAwMCAo
NjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNktdDQogICAgICAgIE1lbW9yeSBhdCBk
MTAwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xTV0NCiAgICAgICAgQ2Fw
YWJpbGl0aWVzOiBbNTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzDQogICAgICAgIENhcGFi
aWxpdGllczogWzgwXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0xNCA8Pz4NCiAg
ICAgICAgQ2FwYWJpbGl0aWVzOiBbNjBdIE1TSTogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUt
IDY0Yml0Kw0KDQoNClsxXQ0KaHR0cHM6Ly9naXRodWIuY29tL3RoZXNvZnByb2plY3Qvc29mL2lz
c3Vlcz9xPWlzJTNBb3BlbitpcyUzQWlzc3VlK2xhYmVsJTNBQ01MDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBFdmFuIEdyZWVuIDxldmdyZWVuQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+IA0KPiAgIHNv
dW5kL3NvYy9zb2YvaW50ZWwvS2NvbmZpZyB8IDE2ICsrKysrKysrKysrKysrKysNCj4gICBzb3Vu
ZC9zb2Mvc29mL3NvZi1wY2ktZGV2LmMgfCAgNCArKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvZi9pbnRlbC9L
Y29uZmlnIGIvc291bmQvc29jL3NvZi9pbnRlbC9LY29uZmlnIA0KPiBpbmRleCAzMmVlMGZhYmFi
OTIuLjBiNjE2ZDAyNWYwNSAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL3NvZi9pbnRlbC9LY29u
ZmlnDQo+ICsrKyBiL3NvdW5kL3NvYy9zb2YvaW50ZWwvS2NvbmZpZw0KPiBAQCAtMjQsNiArMjQs
NyBAQCBjb25maWcgU05EX1NPQ19TT0ZfSU5URUxfUENJDQo+ICAgCXNlbGVjdCBTTkRfU09DX1NP
Rl9DQU5OT05MQUtFICBpZiBTTkRfU09DX1NPRl9DQU5OT05MQUtFX1NVUFBPUlQNCj4gICAJc2Vs
ZWN0IFNORF9TT0NfU09GX0NPRkZFRUxBS0UgIGlmIFNORF9TT0NfU09GX0NPRkZFRUxBS0VfU1VQ
UE9SVA0KPiAgIAlzZWxlY3QgU05EX1NPQ19TT0ZfSUNFTEFLRSAgICAgaWYgU05EX1NPQ19TT0Zf
SUNFTEFLRV9TVVBQT1JUDQo+ICsJc2VsZWN0IFNORF9TT0NfU09GX0NPTUVUTEFLRSAgIGlmIFNO
RF9TT0NfU09GX0NPTUVUTEFLRV9TVVBQT1JUDQo+ICAgCWhlbHANCj4gICAJICBUaGlzIG9wdGlv
biBpcyBub3QgdXNlci1zZWxlY3RhYmxlIGJ1dCBhdXRvbWFnaWNhbGx5IGhhbmRsZWQgYnkNCj4g
ICAJICAnc2VsZWN0JyBzdGF0ZW1lbnRzIGF0IGEgaGlnaGVyIGxldmVsIEBAIC0xNzksNiArMTgw
LDIxIEBAIGNvbmZpZyANCj4gU05EX1NPQ19TT0ZfSUNFTEFLRQ0KPiAgIAkgIFRoaXMgb3B0aW9u
IGlzIG5vdCB1c2VyLXNlbGVjdGFibGUgYnV0IGF1dG9tYWdpY2FsbHkgaGFuZGxlZCBieQ0KPiAg
IAkgICdzZWxlY3QnIHN0YXRlbWVudHMgYXQgYSBoaWdoZXIgbGV2ZWwNCj4gICANCj4gK2NvbmZp
ZyBTTkRfU09DX1NPRl9DT01FVExBS0UNCj4gKwl0cmlzdGF0ZQ0KPiArCXNlbGVjdCBTTkRfU09D
X1NPRl9DQU5OT05MQUtFDQo+ICsJaGVscA0KPiArCSAgVGhpcyBvcHRpb24gaXMgbm90IHVzZXIt
c2VsZWN0YWJsZSBidXQgYXV0b21hZ2ljYWxseSBoYW5kbGVkIGJ5DQo+ICsJICAnc2VsZWN0JyBz
dGF0ZW1lbnRzIGF0IGEgaGlnaGVyIGxldmVsDQo+ICsNCj4gK2NvbmZpZyBTTkRfU09DX1NPRl9D
T01FVExBS0VfU1VQUE9SVA0KPiArCWJvb2wgIlNPRiBzdXBwb3J0IGZvciBDb21ldExha2UiDQo+
ICsJaGVscA0KPiArCSAgVGhpcyBhZGRzIHN1cHBvcnQgZm9yIFNvdW5kIE9wZW4gRmlybXdhcmUg
Zm9yIEludGVsKFIpIHBsYXRmb3Jtcw0KPiArCSAgdXNpbmcgdGhlIENvbWV0bGFrZSBwcm9jZXNz
b3JzLg0KPiArCSAgU2F5IFkgaWYgeW91IGhhdmUgc3VjaCBhIGRldmljZS4NCj4gKwkgIElmIHVu
c3VyZSBzZWxlY3QgIk4iLg0KPiArDQo+ICAgY29uZmlnIFNORF9TT0NfU09GX0hEQV9DT01NT04N
Cj4gICAJdHJpc3RhdGUNCj4gICAJc2VsZWN0IFNORF9TT0NfU09GX0lOVEVMX0NPTU1PTg0KPiBk
aWZmIC0tZ2l0IGEvc291bmQvc29jL3NvZi9zb2YtcGNpLWRldi5jIGIvc291bmQvc29jL3NvZi9z
b2YtcGNpLWRldi5jIA0KPiBpbmRleCBiNzc4ZGZmYjJkMjUuLjVmMDEyODMzN2U0MCAxMDA2NDQN
Cj4gLS0tIGEvc291bmQvc29jL3NvZi9zb2YtcGNpLWRldi5jDQo+ICsrKyBiL3NvdW5kL3NvYy9z
b2Yvc29mLXBjaS1kZXYuYw0KPiBAQCAtMzUzLDYgKzM1MywxMCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHBjaV9kZXZpY2VfaWQgc29mX3BjaV9pZHNbXSA9IHsNCj4gICAjaWYgSVNfRU5BQkxFRChD
T05GSUdfU05EX1NPQ19TT0ZfSUNFTEFLRSkNCj4gICAJeyBQQ0lfREVWSUNFKDB4ODA4NiwgMHgz
NEM4KSwNCj4gICAJCS5kcml2ZXJfZGF0YSA9ICh1bnNpZ25lZCBsb25nKSZpY2xfZGVzY30sDQo+
ICsjZW5kaWYNCj4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19TTkRfU09DX1NPRl9DT01FVExBS0Up
DQo+ICsJeyBQQ0lfREVWSUNFKDB4ODA4NiwgMHgwMmM4KSwNCj4gKwkJLmRyaXZlcl9kYXRhID0g
KHVuc2lnbmVkIGxvbmcpJmNubF9kZXNjfSwNCj4gICAjZW5kaWYNCj4gICAJeyAwLCB9DQo+ICAg
fTsNCj4gDQo=
