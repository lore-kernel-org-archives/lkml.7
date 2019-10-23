Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58D4CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E53821920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392143AbfJWORI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:17:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:10364 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbfJWORI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:17:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 07:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="398054644"
Received: from kmsmsx151.gar.corp.intel.com ([172.21.73.86])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2019 07:17:04 -0700
Received: from pgsmsx101.gar.corp.intel.com ([169.254.1.80]) by
 KMSMSX151.gar.corp.intel.com ([169.254.10.97]) with mapi id 14.03.0439.000;
 Wed, 23 Oct 2019 22:17:02 +0800
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Olof Johansson <olof@lixom.net>,
        "Maxime Ripard" <mripard@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        "Anson Huang" <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ong, Hean Loong" <hean.loong.ong@intel.com>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "Tan, Ley Foon" <ley.foon.tan@intel.com>
Subject: RE: [PATCHv2] arm64: defconfig: add JFFS FS support in defconfig
Thread-Topic: [PATCHv2] arm64: defconfig: add JFFS FS support in defconfig
Thread-Index: AQHVhLQ1uC9R903uo0+8xK6FATnE6KdkwMoAgAOObJA=
Date:   Wed, 23 Oct 2019 14:17:02 +0000
Message-ID: <D53702B8F0ACD34B9B1D7D82EE03C045078535F3@PGSMSX101.gar.corp.intel.com>
References: <1571293732-13667-1-git-send-email-joyce.ooi@intel.com>
 <99d66573-a66f-947a-6f50-098c745ebab7@kernel.org>
In-Reply-To: <99d66573-a66f-947a-6f50-098c745ebab7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTg1ZTc5YTQtYWI1Mi00NjBlLWJiYTctZTIwM2RmNmM1NmY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOVRXSnBvYzhnWUhYMmEwZm5NNWptYlVOak5SY0pNXC9IMHBJVDRXWGFDQkNhK3JEcmdHZ2Q2cHhCWUlBcnppWmwifQ==
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGluaCBOZ3V5ZW4gPGRp
bmd1eWVuQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyMSwgMjAxOSAxMTo1
NyBQTQ0KPiBUbzogT29pLCBKb3ljZSA8am95Y2Uub29pQGludGVsLmNvbT47IFZsYWRpbWlyIE11
cnppbg0KPiA8dmxhZGltaXIubXVyemluQGFybS5jb20+OyBDYXRhbGluIE1hcmluYXMgPGNhdGFs
aW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbA0KPiBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4g
Q2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IE9sb2YgSm9oYW5zc29uIDxvbG9m
QGxpeG9tLm5ldD47DQo+IE1heGltZSBSaXBhcmQgPG1yaXBhcmRAa2VybmVsLm9yZz47IEJqb3Ju
IEFuZGVyc3Nvbg0KPiA8Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+OyBBcm5kIEJlcmdtYW5u
IDxhcm5kQGFybmRiLmRlPjsgSmFnYW4gVGVraQ0KPiA8amFnYW5AYW1hcnVsYXNvbHV0aW9ucy5j
b20+OyBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT47DQo+IExlb25hcmQgQ3Jlc3Rl
eiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyBNYXJjaW4gSnVzemtpZXdpY3oNCj4gPG1hcmNp
bi5qdXN6a2lld2ljekBsaW5hcm8ub3JnPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgT25nLCBIZWFuIExvb25n
IDxoZWFuLmxvb25nLm9uZ0BpbnRlbC5jb20+OyBTZWUsDQo+IENoaW4gTGlhbmcgPGNoaW4ubGlh
bmcuc2VlQGludGVsLmNvbT47IFRhbiwgTGV5IEZvb24NCj4gPGxleS5mb29uLnRhbkBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2Ml0gYXJtNjQ6IGRlZmNvbmZpZzogYWRkIEpGRlMg
RlMgc3VwcG9ydCBpbiBkZWZjb25maWcNCj4gDQo+IA0KPiANCj4gT24gMTAvMTcvMTkgMToyOCBB
TSwgT29pLCBKb3ljZSB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgSkZGUzIgRlMgc3VwcG9y
dCBhbmQgcmVtb3ZlIFFTUEkgU2VjdG9yIDRLIHNpemUgZm9yY2UNCj4gPiBpbiB0aGUgZGVmYXVs
dCBkZWZjb25maWcNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE9vaSwgSm95Y2UgPGpveWNlLm9v
aUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gdjI6IGRpc2FibGUgQ09ORklHX01URF9TUElfTk9S
X1VTRV80S19TRUNUT1JTIHVzaW5nIHRoZSBjb3JyZWN0IHN5bnRheA0KPiA+IC0tLQ0KPiA+ICBh
cmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdz
L2RlZmNvbmZpZw0KPiA+IGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyBpbmRleCBjOWFk
YWU0Li42MDgwYzZlIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25m
aWcNCj4gPiArKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gQEAgLTg2MCwz
ICs4NjAsNSBAQCBDT05GSUdfREVCVUdfS0VSTkVMPXkgICMNCj4gQ09ORklHX0RFQlVHX1BSRUVN
UFQgaXMNCj4gPiBub3Qgc2V0ICAjIENPTkZJR19GVFJBQ0UgaXMgbm90IHNldCAgQ09ORklHX01F
TVRFU1Q9eQ0KPiA+ICtDT05GSUdfSkZGUzJfRlM9eQ0KPiA+ICsjIENPTkZJR19NVERfU1BJX05P
Ul9VU0VfNEtfU0VDVE9SUyBpcyBub3Qgc2V0DQo+ID4NCj4gDQo+IENhbiB5b3UgZXhwbGFpbiB3
aHkgeW91J3JlIHJlbW92aW5nDQo+IENPTkZJR19NVERfU1BJX05PUl9VU0VfNEtfU0VDVE9SUz8N
ClJlbW92aW5nIENPTkZJR19NVERfU1BJX05PUl9VU0VfNEtfU0VDVE9SUyB3aWxsIGZpeCBlcnJv
cnMgbGlrZSB0aGlzOg0KWyAxLjkwNTc3Ml0gamZmczI6IGpmZnMyX3NjYW5fZXJhc2VibG9jaygp
OiBNYWdpYyBiaXRtYXNrIDB4MTk4NSBub3QgZm91bmQgYXQgMHgwMDAwMGY5MDogMHgwMGJmIGlu
c3RlYWQgDQpbIDEuOTE1Mjc1XSBqZmZzMjogamZmczJfc2Nhbl9lcmFzZWJsb2NrKCk6IE1hZ2lj
IGJpdG1hc2sgMHgxOTg1IG5vdCBmb3VuZCBhdCAweDAwMDAwZjk0OiAweDZhYmIgaW5zdGVhZA0K
DQpJJ2xsIGFkZCB0aGlzIGV4cGxhbmF0aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+
IERpbmgNCg==
