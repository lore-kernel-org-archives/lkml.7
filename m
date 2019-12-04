Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C767C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339832073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KIr6acxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfLDKIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:08:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40226 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727351AbfLDKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:08:03 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4A2uX8011913;
        Wed, 4 Dec 2019 11:07:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=mooPwyMKqKXw7FbErPboyCzEEJ1X0+5Wq2Zf6DUE08s=;
 b=KIr6acxC6AcslemFW8emuwRshHmh4t2WVbRrwpJLMEW06n6Co15WVdSq6XChVGnSBUG5
 z87/41g7CB6IeGPgn7cjlOslmX2y83Q/yfMRX6frOWALWLKsgYIuImdp6AE3QhkygBz0
 bzEKWdbLnxRZvX3WjCMWagpStEE96+pi3og3YfhL/2h62jFEJVE6P3BTPtQip0a8FlXd
 K40sqMAKdqDrBYNRZzJApgDrUOha2+Bk7qdcczXsiMmbxfU71I/f1RkduOmBF/y9dgGK
 S8Vjr3+UXt0D5EyWwL/+Cc103rSS1wZv73q+r4meHyrZihwdMhD1yaDtQGGrQAZTo01J /Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkg6kmc1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 11:07:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C9D84100034;
        Wed,  4 Dec 2019 11:07:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9AB592AC0B4;
        Wed,  4 Dec 2019 11:07:44 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 4 Dec
 2019 11:07:44 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 4 Dec 2019 11:07:44 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/modes: remove unused variables
Thread-Topic: [PATCH] drm/modes: remove unused variables
Thread-Index: AQHVnt/VSP/oKiq2AUetqzXw/N41gKepveoAgAAI6IA=
Date:   Wed, 4 Dec 2019 10:07:44 +0000
Message-ID: <f210413f-2d2f-9887-ca3b-a3c48564d9d6@st.com>
References: <20191119134706.10893-1-benjamin.gaignard@st.com>
 <8056f838-3ebf-26db-f5be-3e78d61aa512@suse.de>
In-Reply-To: <8056f838-3ebf-26db-f5be-3e78d61aa512@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <74BF3CA761102347A7D3B2745BDA20A5@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi80LzE5IDEwOjM1IEFNLCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToNCj4gSGkNCj4N
Cj4gQW0gMTkuMTEuMTkgdW0gMTQ6NDcgc2NocmllYiBCZW5qYW1pbiBHYWlnbmFyZDoNCj4+IFdo
ZW4gY29tcGlsaW5nIHdpdGggVz0xIGZldyB3YXJuaW5ncyBhYm91dCB1bnVzZWQgdmFyaWFibGVz
IHNob3cgdXAuDQo+PiBUaGlzIHBhdGNoIHJlbW92ZXMgYWxsIHRoZSBpbnZvbHZlZCB2YXJpYWJs
ZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdh
aWduYXJkQHN0LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vZHJtX21vZGVzLmMg
fCAyMiArKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX21vZGVzLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX21vZGVzLmMNCj4+IGluZGV4
IDg4MjMyNjk4ZDdhMC4uYWNhOTAxYWZmMDQyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9tb2Rlcy5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX21vZGVzLmMNCj4+
IEBAIC0yMzMsNyArMjMzLDcgQEAgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKmRybV9jdnRfbW9k
ZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBpbnQgaGRpc3BsYXksDQo+PiAgIAkJLyogMykgTm9t
aW5hbCBIU3luYyB3aWR0aCAoJSBvZiBsaW5lIHBlcmlvZCkgLSBkZWZhdWx0IDggKi8NCj4+ICAg
I2RlZmluZSBDVlRfSFNZTkNfUEVSQ0VOVEFHRQk4DQo+PiAgIAkJdW5zaWduZWQgaW50IGhibGFu
a19wZXJjZW50YWdlOw0KPj4gLQkJaW50IHZzeW5jYW5kYmFja19wb3JjaCwgdmJhY2tfcG9yY2gs
IGhibGFuazsNCj4+ICsJCWludCB2c3luY2FuZGJhY2tfcG9yY2gsIGhibGFuazsNCj4+ICAgDQo+
PiAgIAkJLyogZXN0aW1hdGVkIHRoZSBob3Jpem9udGFsIHBlcmlvZCAqLw0KPj4gICAJCXRtcDEg
PSBIVl9GQUNUT1IgKiAxMDAwMDAwICAtDQo+PiBAQCAtMjQ5LDcgKzI0OSw2IEBAIHN0cnVjdCBk
cm1fZGlzcGxheV9tb2RlICpkcm1fY3Z0X21vZGUoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgaW50
IGhkaXNwbGF5LA0KPj4gICAJCWVsc2UNCj4+ICAgCQkJdnN5bmNhbmRiYWNrX3BvcmNoID0gdG1w
MTsNCj4+ICAgCQkvKiAxMC4gRmluZCBudW1iZXIgb2YgbGluZXMgaW4gYmFjayBwb3JjaCAqLw0K
Pj4gLQkJdmJhY2tfcG9yY2ggPSB2c3luY2FuZGJhY2tfcG9yY2ggLSB2c3luYzsNCj4+ICAgCQlk
cm1fbW9kZS0+dnRvdGFsID0gdmRpc3BsYXlfcm5kICsgMiAqIHZtYXJnaW4gKw0KPj4gICAJCQkJ
dnN5bmNhbmRiYWNrX3BvcmNoICsgQ1ZUX01JTl9WX1BPUkNIOw0KPj4gICAJCS8qIDUpIERlZmlu
aXRpb24gb2YgSG9yaXpvbnRhbCBibGFua2luZyB0aW1lIGxpbWl0YXRpb24gKi8NCj4+IEBAIC0z
ODYsOSArMzg1LDggQEAgZHJtX2d0Zl9tb2RlX2NvbXBsZXgoc3RydWN0IGRybV9kZXZpY2UgKmRl
diwgaW50IGhkaXNwbGF5LCBpbnQgdmRpc3BsYXksDQo+PiAgIAlpbnQgdG9wX21hcmdpbiwgYm90
dG9tX21hcmdpbjsNCj4+ICAgCWludCBpbnRlcmxhY2U7DQo+PiAgIAl1bnNpZ25lZCBpbnQgaGZy
ZXFfZXN0Ow0KPj4gLQlpbnQgdnN5bmNfcGx1c19icCwgdmJhY2tfcG9yY2g7DQo+PiAtCXVuc2ln
bmVkIGludCB2dG90YWxfbGluZXMsIHZmaWVsZHJhdGVfZXN0LCBocGVyaW9kOw0KPj4gLQl1bnNp
Z25lZCBpbnQgdmZpZWxkX3JhdGUsIHZmcmFtZV9yYXRlOw0KPj4gKwlpbnQgdnN5bmNfcGx1c19i
cDsNCj4+ICsJdW5zaWduZWQgaW50IHZ0b3RhbF9saW5lczsNCj4+ICAgCWludCBsZWZ0X21hcmdp
biwgcmlnaHRfbWFyZ2luOw0KPj4gICAJdW5zaWduZWQgaW50IHRvdGFsX2FjdGl2ZV9waXhlbHMs
IGlkZWFsX2R1dHlfY3ljbGU7DQo+PiAgIAl1bnNpZ25lZCBpbnQgaGJsYW5rLCB0b3RhbF9waXhl
bHMsIHBpeGVsX2ZyZXE7DQo+PiBAQCAtNDUxLDIzICs0NDksOSBAQCBkcm1fZ3RmX21vZGVfY29t
cGxleChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBpbnQgaGRpc3BsYXksIGludCB2ZGlzcGxheSwN
Cj4+ICAgCS8qIFtWIFNZTkMrQlBdID0gUklOVCgoW01JTiBWU1lOQytCUF0gKiBoZnJlcV9lc3Qg
LyAxMDAwMDAwKSkgKi8NCj4+ICAgCXZzeW5jX3BsdXNfYnAgPSBNSU5fVlNZTkNfUExVU19CUCAq
IGhmcmVxX2VzdCAvIDEwMDA7DQo+PiAgIAl2c3luY19wbHVzX2JwID0gKHZzeW5jX3BsdXNfYnAg
KyA1MDApIC8gMTAwMDsNCj4+IC0JLyogIDkuIEZpbmQgdGhlIG51bWJlciBvZiBsaW5lcyBpbiBW
IGJhY2sgcG9yY2ggYWxvbmU6ICovDQo+PiAtCXZiYWNrX3BvcmNoID0gdnN5bmNfcGx1c19icCAt
IFZfU1lOQ19SUUQ7DQo+PiAgIAkvKiAgMTAuIEZpbmQgdGhlIHRvdGFsIG51bWJlciBvZiBsaW5l
cyBpbiBWZXJ0aWNhbCBmaWVsZCBwZXJpb2Q6ICovDQo+PiAgIAl2dG90YWxfbGluZXMgPSB2ZGlz
cGxheV9ybmQgKyB0b3BfbWFyZ2luICsgYm90dG9tX21hcmdpbiArDQo+PiAgIAkJCXZzeW5jX3Bs
dXNfYnAgKyBHVEZfTUlOX1ZfUE9SQ0g7DQo+PiAtCS8qICAxMS4gRXN0aW1hdGUgdGhlIFZlcnRp
Y2FsIGZpZWxkIGZyZXF1ZW5jeTogKi8NCj4+IC0JdmZpZWxkcmF0ZV9lc3QgPSBoZnJlcV9lc3Qg
LyB2dG90YWxfbGluZXM7DQo+PiAtCS8qICAxMi4gRmluZCB0aGUgYWN0dWFsIGhvcml6b250YWwg
cGVyaW9kOiAqLw0KPj4gLQlocGVyaW9kID0gMTAwMDAwMCAvICh2ZmllbGRyYXRlX3JxZCAqIHZ0
b3RhbF9saW5lcyk7DQo+PiAtDQo+PiAtCS8qICAxMy4gRmluZCB0aGUgYWN0dWFsIFZlcnRpY2Fs
IGZpZWxkIGZyZXF1ZW5jeTogKi8NCj4+IC0JdmZpZWxkX3JhdGUgPSBoZnJlcV9lc3QgLyB2dG90
YWxfbGluZXM7DQo+PiAtCS8qICAxNC4gRmluZCB0aGUgVmVydGljYWwgZnJhbWUgZnJlcXVlbmN5
OiAqLw0KPj4gLQlpZiAoaW50ZXJsYWNlZCkNCj4+IC0JCXZmcmFtZV9yYXRlID0gdmZpZWxkX3Jh
dGUgLyAyOw0KPj4gLQllbHNlDQo+PiAtCQl2ZnJhbWVfcmF0ZSA9IHZmaWVsZF9yYXRlOw0KPiBU
aGUgYW1vdW50IG9mIHVudXNlZCBjb2RlIGlzIHF1aXRlIGxhcmdlLCB3aGljaCBtYWtlcyBtZSB3
b25kZXIgaWYNCj4gdGhlcmUncyBzb21ldGhpbmcgbWlzc2luZyBiZWxvdyB3aGVyZSB0aGVzZSB2
YXJpYWJsZXMgYXJlIHN1cHBvc2VkIHRvIGJlDQo+IHVzZWQuDQo+DQo+IElmIHRoZXNlIHZhcmlh
YmxlcyBjYW4gYmUgcmVtb3ZlZCwgY29tbWVudHMgc2hvdWxkIG1lbnRpb24gdGhhdCBzdGVwcyA5
DQo+IGFuZCAxMSB0byAxNCBhcmUgYmVpbmcgbGVmdCBvdXQuIEFmdGVyIGFsbCwgdGhlIGZ1bmN0
aW9uIGlzIGZhaXJseQ0KPiBleHBsaWNpdCBhYm91dCBpbXBsZW1lbnRpbmcgdGhlIEdURiBhbGdv
cml0aG0gc3RlcCBieSBzdGVwLg0KPg0KPiBCZXN0IHJlZ2FyZHMNCj4gVGhvbWFzDQoNCklmIHRo
ZSBnb2FsIGlzIHRvIGtlZXAgYWxsIHRoZSBzdGVwcyB0aGVuIEkgY291bGQgcHJlZml4IGFsbCBw
cm9ibGVtYXRpYyANCnZhcmlhYmxlcyB3aXRoIF9fbWF5YmVfdW51c2VkIG1hY3JvLg0KDQpCZW5q
YW1pbg0KDQo+DQo+PiAgIAkvKiAgMTUuIEZpbmQgbnVtYmVyIG9mIHBpeGVscyBpbiBsZWZ0IG1h
cmdpbjogKi8NCj4+ICAgCWlmIChtYXJnaW5zKQ0KPj4gICAJCWxlZnRfbWFyZ2luID0gKGhkaXNw
bGF5X3JuZCAqIEdURl9NQVJHSU5fUEVSQ0VOVEFHRSArIDUwMCkgLw0KPj4=
