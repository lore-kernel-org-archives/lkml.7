Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B9AC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985E620854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436486AbfJQGLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:11:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:27729 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406077AbfJQGLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:11:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 23:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,306,1566889200"; 
   d="scan'208";a="396149430"
Received: from kmsmsx152.gar.corp.intel.com ([172.21.73.87])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2019 23:11:39 -0700
Received: from pgsmsx101.gar.corp.intel.com ([169.254.1.80]) by
 KMSMSX152.gar.corp.intel.com ([169.254.11.51]) with mapi id 14.03.0439.000;
 Thu, 17 Oct 2019 14:09:09 +0800
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
CC:     "Tan, Ley Foon" <ley.foon.tan@intel.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Ong, Hean Loong" <hean.loong.ong@intel.com>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Marcin Juszkiewicz" <marcin.juszkiewicz@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Olof Johansson <olof@lixom.net>,
        "Leonard Crestez" <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm64: defconfig: add JFFS FS support in defconfig
Thread-Topic: [PATCH] arm64: defconfig: add JFFS FS support in defconfig
Thread-Index: AQHVhAUciHO2DjknO06FLl5XQUjE+qdcoHQAgAG6GCA=
Date:   Thu, 17 Oct 2019 06:09:09 +0000
Message-ID: <D53702B8F0ACD34B9B1D7D82EE03C0450784EE2B@PGSMSX101.gar.corp.intel.com>
References: <1571218528-12126-1-git-send-email-joyce.ooi@intel.com>
 <8869edbc-e7b4-dfb3-1567-740132820133@arm.com>
In-Reply-To: <8869edbc-e7b4-dfb3-1567-740132820133@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmMxZDAxYWEtZGUzYy00NzhmLTlmZjAtMDk2ZWFhNDFiODgyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU0pGRk5MTllsWTcwVjRlVHNBXC9wWUtsVHlzVTFFdWZzMFFjZTR3eEg4c1dYWFwvOXNEcG00MDd2RlRtS3RadEE3In0=
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBNdXJ6aW4gW21h
aWx0bzp2bGFkaW1pci5tdXJ6aW5AYXJtLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDE2LCAyMDE5IDc6NDYgUE0NCj4gVG86IE9vaSwgSm95Y2UgPGpveWNlLm9vaUBpbnRlbC5jb20+
OyBDYXRhbGluIE1hcmluYXMNCj4gPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFj
b24gPHdpbGxAa2VybmVsLm9yZz47IERpbmggTmd1eWVuDQo+IDxkaW5ndXllbkBrZXJuZWwub3Jn
Pg0KPiBDYzogVGFuLCBMZXkgRm9vbiA8bGV5LmZvb24udGFuQGludGVsLmNvbT47IEFuc29uIEh1
YW5nDQo+IDxBbnNvbi5IdWFuZ0BueHAuY29tPjsgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5k
ZT47IE9uZywgSGVhbiBMb29uZw0KPiA8aGVhbi5sb29uZy5vbmdAaW50ZWwuY29tPjsgU2VlLCBD
aGluIExpYW5nIDxjaGluLmxpYW5nLnNlZUBpbnRlbC5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5vcmc+OyBCam9ybg0K
PiBBbmRlcnNzb24gPGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnPjsgTWFyY2luIEp1c3praWV3
aWN6DQo+IDxtYXJjaW4uanVzemtpZXdpY3pAbGluYXJvLm9yZz47IEphZ2FuIFRla2kgPGphZ2Fu
QGFtYXJ1bGFzb2x1dGlvbnMuY29tPjsNCj4gT2xvZiBKb2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0
PjsgTGVvbmFyZCBDcmVzdGV6DQo+IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47IFNoYXduIEd1
byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IGRlZmNvbmZpZzogYWRkIEpG
RlMgRlMgc3VwcG9ydCBpbiBkZWZjb25maWcNCj4gDQo+IE9uIDEwLzE2LzE5IDEwOjM1IEFNLCBP
b2ksIEpveWNlIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBKRkZTMiBGUyBzdXBwb3J0IGFu
ZCByZW1vdmUgUVNQSSBTZWN0b3IgNEsgc2l6ZSBmb3JjZQ0KPiA+IGluIHRoZSBkZWZhdWx0IGRl
ZmNvbmZpZw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogT29pLCBKb3ljZSA8am95Y2Uub29pQGlu
dGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyB8IDIg
KysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCj4gPiBiL2FyY2gvYXJtNjQvY29u
Zmlncy9kZWZjb25maWcgaW5kZXggYzlhZGFlNC4uNjA4MGM2ZSAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gKysrIGIvYXJjaC9hcm02NC9jb25maWdz
L2RlZmNvbmZpZw0KPiA+IEBAIC04NjAsMyArODYwLDUgQEAgQ09ORklHX0RFQlVHX0tFUk5FTD15
ICAjDQo+IENPTkZJR19ERUJVR19QUkVFTVBUIGlzDQo+ID4gbm90IHNldCAgIyBDT05GSUdfRlRS
QUNFIGlzIG5vdCBzZXQgIENPTkZJR19NRU1URVNUPXkNCj4gPiArQ09ORklHX0pGRlMyX0ZTPXkN
Cj4gPiArQ09ORklHX01URF9TUElfTk9SX1VTRV80S19TRUNUT1JTPW4NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeXl5eDQo+IFRoaXMgaXMgaW5jb3JyZWN0IHN5bnRheCBm
b3IgZGlzYWJsaW5nIGNvbmZpZyBvcHRpb24uIENvcnJlY3Qgb25lIGlzDQo+IA0KPiAjIENPTkZJ
R19NVERfU1BJX05PUl9VU0VfNEtfU0VDVE9SUyBpcyBub3Qgc2V0DQpPa2F5LCB3aWxsIGRvIHRo
YXQuDQoNCj4gDQo+IEhvd2V2ZXIsIGl0IGxvb2tzIHRvIG1lIHlvdSB3YW50IHRvIHJlbW92ZSBp
dCBmcm9tIGRlZmNvbmZpZyByYXRoZXIgdGhhbiBmb3JjZQ0KPiBpdCB0byBiZSB1bnNldC4NCj4g
DQo+IENoZWVycw0KPiBWbGFkaW1pcg0K
