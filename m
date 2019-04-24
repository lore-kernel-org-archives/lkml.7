Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A239BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B0220835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbfDXSZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:25:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:49927 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733024AbfDXSZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:25:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 11:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="164511590"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 24 Apr 2019 11:25:05 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 24 Apr 2019 11:25:04 -0700
Received: from bgsmsx102.gar.corp.intel.com (10.223.4.172) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 24 Apr 2019 11:25:04 -0700
Received: from bgsmsx104.gar.corp.intel.com ([169.254.5.147]) by
 BGSMSX102.gar.corp.intel.com ([169.254.2.128]) with mapi id 14.03.0415.000;
 Wed, 24 Apr 2019 23:55:01 +0530
From:   "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
CC:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        "acpi4asus-user@lists.sourceforge.net" 
        <acpi4asus-user@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 08/11] platform/x86: asus-wmi: Enhance detection of
 thermal data
Thread-Topic: [PATCH v3 08/11] platform/x86: asus-wmi: Enhance detection of
 thermal data
Thread-Index: AQHU9uV87Y2v6Snf9UulCjbRrFZcgqZLprzA
Date:   Wed, 24 Apr 2019 18:25:01 +0000
Message-ID: <3C3E65E75D9910479323816378A812E7414CDE12@BGSMSX104.gar.corp.intel.com>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <7595c4f0-3dbb-2fe5-4daf-4b9a266f67d7@gmail.com>
In-Reply-To: <7595c4f0-3dbb-2fe5-4daf-4b9a266f67d7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjliMGYyYmYtMDE3MS00Y2MxLTkwMWMtY2M0OTE1Mzg3ZTg1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoienBqMm93bXBrTmtqOTNsYVRyV3ZXQXNESEd5ekk0SnJJXC9UUkdNU1l0S21Sd1c5Z1V1eGtURWVTU3hrRXdQOUYifQ==
x-ctpclassification: CTP_NT
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IHBsYXRmb3JtLWRyaXZlci14
ODYtb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86cGxhdGZvcm0tZHJpdmVyLQ0KPng4Ni1v
d25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBZdXJpaSBQYXZsb3Zza3lpDQo+U2Vu
dDogRnJpZGF5LCBBcHJpbCAxOSwgMjAxOSAzOjQzIFBNDQo+Q2M6IENvcmVudGluIENoYXJ5IDxj
b3JlbnRpbi5jaGFyeUBnbWFpbC5jb20+OyBEYXJyZW4gSGFydA0KPjxkdmhhcnRAaW5mcmFkZWFk
Lm9yZz47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBpbmZyYWRlYWQub3JnPjsgRGFuaWVsDQo+RHJh
a2UgPGRyYWtlQGVuZGxlc3NtLmNvbT47IGFjcGk0YXN1cy11c2VyQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsNCj5wbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFtQQVRDSCB2MyAwOC8xMV0gcGxhdGZvcm0veDg2
OiBhc3VzLXdtaTogRW5oYW5jZSBkZXRlY3Rpb24gb2YNCj50aGVybWFsIGRhdGENCj4NCj5UaGUg
b2J2aW91c2x5IHdyb25nIHZhbHVlIDEgZm9yIHRlbXBlcmF0dXJlIGRldmljZSBJRCBpbiB0aGlz
IGRyaXZlciBpcw0KPnJldHVybmVkIGJ5IGF0IGxlYXN0IHNvbWUgZGV2aWNlcywgaW5jbHVkaW5n
IFRVRiBHYW1pbmcgc2VyaWVzIGxhcHRvcHMsDQo+aW5zdGVhZCBvZiAwIGFzIGV4cGVjdGVkIHBy
ZXZpb3VzbHkuIE9ic2VydmFibGUgZWZmZWN0IGlzIHRoYXQgYSB0ZW1wMV9pbnB1dA0KPmluIGh3
bW9uIHJlYWRzIHRlbXBlcmF0dXJlIG5lYXIgYWJzb2x1dGUgemVyby4NCj4NCj4qIENvbnNpZGVy
IDAuMSBLIGFuIGVycm9uZW91cyB2YWx1ZSBpbiBhZGRpdGlvbiB0byAwIEsuDQo+KiBSZWZhY3Rv
ciBkZXRlY3Rpb24gb2YgdGhlcm1hbCBpbnB1dCBhdmFpbGFiaWxpdHkgdG8gYSBzZXBhcmF0ZSBm
dW5jdGlvbi4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBZdXJpaSBQYXZsb3Zza3lpIDx5dXJpaS5wYXZs
b3Zza3lpQGdtYWlsLmNvbT4NCj4tLS0NCj4gZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy13bWku
YyB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAxIGZpbGUgY2hhbmdl
ZCwgMzggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvZHJp
dmVycy9wbGF0Zm9ybS94ODYvYXN1cy13bWkuYyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMt
DQo+d21pLmMgaW5kZXggZTY5ZTU1NjM1YWZiLi4xYjgyNzIzNzQ2NjAgMTAwNjQ0DQo+LS0tIGEv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy13bWkuYw0KPisrKyBiL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L2FzdXMtd21pLmMNCj5AQCAtMTc4LDYgKzE3OCw3IEBAIHN0cnVjdCBhc3VzX3dtaSB7DQo+
IAlzdHJ1Y3QgYXN1c19yZmtpbGwgZ3BzOw0KPiAJc3RydWN0IGFzdXNfcmZraWxsIHV3YjsNCj4N
Cj4rCWJvb2wgYXN1c19od21vbl90aGVybWFsX2F2YWlsYWJsZTsNCj4gCWJvb2wgYXN1c19od21v
bl9mYW5fbWFudWFsX21vZGU7DQo+IAlpbnQgYXN1c19od21vbl9udW1fZmFuczsNCj4gCWludCBh
c3VzX2h3bW9uX3B3bTsNCj5AQCAtMTM3NSw2ICsxMzc2LDMyIEBAIHN0YXRpYyBzdHJ1Y3QgYXR0
cmlidXRlICpod21vbl9hdHRyaWJ1dGVzW10gPSB7DQo+IAlOVUxMDQo+IH07DQo+DQo+K3N0YXRp
YyBpbnQgYXN1c19od21vbl9jaGVja190aGVybWFsX2F2YWlsYWJsZShzdHJ1Y3QgYXN1c193bWkg
KmFzdXMpIHsNCj4rCXUzMiB2YWx1ZSA9IEFTVVNfV01JX1VOU1VQUE9SVEVEX01FVEhPRDsNCj4r
CWludCBlcnI7DQo+Kw0KPisJYXN1cy0+YXN1c19od21vbl90aGVybWFsX2F2YWlsYWJsZSA9IGZh
bHNlOw0KPisJZXJyID0gYXN1c193bWlfZ2V0X2RldnN0YXRlKGFzdXMsDQo+QVNVU19XTUlfREVW
SURfVEhFUk1BTF9DVFJMLA0KPismdmFsdWUpOw0KPisNCj4rCWlmIChlcnIgPCAwKSB7DQo+KwkJ
aWYgKGVyciA9PSAtRU5PREVWKQ0KPisJCQlyZXR1cm4gMDsNCj4rDQo+KwkJcmV0dXJuIGVycjsN
Cj4rCX0NCj4rDQo+KwkvKg0KPisJICogSWYgdGhlIHRlbXBlcmF0dXJlIHZhbHVlIGluIGRlY2kt
S2VsdmluIGlzIG5lYXIgdGhlIGFic29sdXRlDQo+KwkgKiB6ZXJvIHRlbXBlcmF0dXJlLCBzb21l
dGhpbmcgaXMgY2xlYXJseSB3cm9uZy4NCj4rCSAqLw0KPisJaWYgKCF2YWx1ZSB8fCB2YWx1ZSA9
PSAxKQ0KPisJCXJldHVybiAwOw0KRG8geW91IHN0aWxsIG5lZWQgdG8gcmV0dXJuIDAgaW4gY2Fz
ZSBvZiB3cm9uZy9mYWlsdXJlIGNhc2UgPyANClNob3VsZG4ndCB5b3UgcmV0dXJuIGVycm9yIGhl
cmUgPyANCg0KPisNCj4rCWFzdXMtPmFzdXNfaHdtb25fdGhlcm1hbF9hdmFpbGFibGUgPSB0cnVl
Ow0KPisJcmV0dXJuIDA7DQo+K30NCj4rDQo+IHN0YXRpYyB1bW9kZV90IGFzdXNfaHdtb25fc3lz
ZnNfaXNfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gCQkJCQkgIHN0cnVjdCBhdHRy
aWJ1dGUgKmF0dHIsIGludCBpZHgpICB7IEBAIC0NCj4xMzg4LDggKzE0MTUsNiBAQCBzdGF0aWMg
dW1vZGVfdCBhc3VzX2h3bW9uX3N5c2ZzX2lzX3Zpc2libGUoc3RydWN0DQo+a29iamVjdCAqa29i
aiwNCj4NCj4gCWlmIChhdHRyID09ICZkZXZfYXR0cl9wd20xLmF0dHIpDQo+IAkJZGV2X2lkID0g
QVNVU19XTUlfREVWSURfRkFOX0NUUkw7DQo+LQllbHNlIGlmIChhdHRyID09ICZkZXZfYXR0cl90
ZW1wMV9pbnB1dC5hdHRyKQ0KPi0JCWRldl9pZCA9IEFTVVNfV01JX0RFVklEX1RIRVJNQUxfQ1RS
TDsNCj4NCj4gCWlmIChhdHRyID09ICZkZXZfYXR0cl9mYW4xX2lucHV0LmF0dHINCj4gCSAgICB8
fCBhdHRyID09ICZkZXZfYXR0cl9mYW4xX2xhYmVsLmF0dHIgQEAgLTE0MTQsMTUgKzE0MzksMTMg
QEANCj5zdGF0aWMgdW1vZGVfdCBhc3VzX2h3bW9uX3N5c2ZzX2lzX3Zpc2libGUoc3RydWN0IGtv
YmplY3QgKmtvYmosDQo+IAkJICogLSByZXZlcnZlZCBiaXRzIGFyZSBub24temVybw0KPiAJCSAq
IC0gc2Z1biBhbmQgcHJlc2VuY2UgYml0IGFyZSBub3Qgc2V0DQo+IAkJICovDQo+LQkJaWYgKHZh
bHVlID09IEFTVVNfV01JX1VOU1VQUE9SVEVEX01FVEhPRCB8fCB2YWx1ZSAmDQo+MHhGRkY4MDAw
MA0KPisJCWlmICh2YWx1ZSA9PSBBU1VTX1dNSV9VTlNVUFBPUlRFRF9NRVRIT0QgfHwgKHZhbHVl
ICYNCj4weEZGRjgwMDAwKQ0KPiAJCSAgICB8fCAoIWFzdXMtPnNmdW4gJiYgISh2YWx1ZSAmDQo+
QVNVU19XTUlfRFNUU19QUkVTRU5DRV9CSVQpKSkNCj4gCQkJb2sgPSBmYWxzZTsNCj4gCQllbHNl
DQo+IAkJCW9rID0gZmFuX2F0dHIgPD0gYXN1cy0+YXN1c19od21vbl9udW1fZmFuczsNCj4tCX0g
ZWxzZSBpZiAoZGV2X2lkID09IEFTVVNfV01JX0RFVklEX1RIRVJNQUxfQ1RSTCkgew0KPi0JCS8q
IElmIHZhbHVlIGlzIHplcm8sIHNvbWV0aGluZyBpcyBjbGVhcmx5IHdyb25nICovDQo+LQkJaWYg
KCF2YWx1ZSkNCj4tCQkJb2sgPSBmYWxzZTsNCj4rCX0gZWxzZSBpZiAoYXR0ciA9PSAmZGV2X2F0
dHJfdGVtcDFfaW5wdXQuYXR0cikgew0KPisJCW9rID0gYXN1cy0+YXN1c19od21vbl90aGVybWFs
X2F2YWlsYWJsZTsNCj4gCX0gZWxzZSBpZiAoZmFuX2F0dHIgPD0gYXN1cy0+YXN1c19od21vbl9u
dW1fZmFucyAmJiBmYW5fYXR0ciAhPSAtMSkNCj57DQo+IAkJb2sgPSB0cnVlOw0KPiAJfSBlbHNl
IHsNCj5AQCAtMTQ2OSw2ICsxNDkyLDE0IEBAIHN0YXRpYyBpbnQgYXN1c193bWlfZmFuX2luaXQo
c3RydWN0IGFzdXNfd21pDQo+KmFzdXMpDQo+IAl9DQo+DQo+IAlwcl9pbmZvKCJOdW1iZXIgb2Yg
ZmFuczogJWRcbiIsIGFzdXMtPmFzdXNfaHdtb25fbnVtX2ZhbnMpOw0KPisNCj4rCXN0YXR1cyA9
IGFzdXNfaHdtb25fY2hlY2tfdGhlcm1hbF9hdmFpbGFibGUoYXN1cyk7DQo+KwlpZiAoc3RhdHVz
KSB7DQo+KwkJcHJfd2FybigiQ291bGQgbm90IGNoZWNrIGlmIHRoZXJtYWwgYXZhaWxhYmxlOiAl
ZFxuIiwgc3RhdHVzKTsNCj4rCQlyZXR1cm4gLUVOWElPOw0KPisJfQ0KPisNCj4rCXByX2luZm8o
IlRoZXJtYWwgYXZhaWxhYmxlOiAlZFxuIiwNCj4rYXN1cy0+YXN1c19od21vbl90aGVybWFsX2F2
YWlsYWJsZSk7DQo+IAlyZXR1cm4gMDsNCj4gfQ0KPg0KPi0tDQo+Mi4xNy4xDQoNCg==
