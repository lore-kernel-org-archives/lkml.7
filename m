Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E262C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524C921721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGBAbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:31:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:59594 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfGBAbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:31:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 17:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,441,1557212400"; 
   d="scan'208";a="163847232"
Received: from pgsmsx111.gar.corp.intel.com ([10.108.55.200])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2019 17:31:34 -0700
Received: from pgsmsx109.gar.corp.intel.com ([169.254.14.145]) by
 PGSMSX111.gar.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0439.000;
 Tue, 2 Jul 2019 08:31:33 +0800
From:   "Ong, Hean Loong" <hean.loong.ong@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        "Thayer, Thor" <thor.thayer@intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>
Subject: RE: [PATCHv1] ARM64: defconfig: Add LEDS_TRIGGERS_TIMER for
 blinking leds
Thread-Topic: [PATCHv1] ARM64: defconfig: Add LEDS_TRIGGERS_TIMER for
 blinking leds
Thread-Index: AQHVLK+Aoy1pYiDkPUSpIA+rs0+23aa1axUAgAEWfIA=
Date:   Tue, 2 Jul 2019 00:31:32 +0000
Message-ID: <FB1B748C9B55D647AEE382CBB370D20F46F6E600@PGSMSX109.gar.corp.intel.com>
References: <20190627140709.707-1-hean.loong.ong@intel.com>
 <20190627140709.707-2-hean.loong.ong@intel.com>
 <722335f6-1c39-5f1e-d5f5-8aa32626dc6c@kernel.org>
In-Reply-To: <722335f6-1c39-5f1e-d5f5-8aa32626dc6c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODU4MzIyZDgtZjZlMy00ZDYzLTk2ZjUtOWQ1ZGFiNjFiNjcyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaXJmQ3BERDUzS0pTN00yaHQ4a1NuSEZ6SGFHUXlSbjlJazVPVHJXaE9nN2w4empTZWc2ME9LalNaM2Z4azE1ZiJ9
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IERpbmgNCg0KQmVzdCBSZWdhcmRzLA0KDQpIZWFuIExvb25nDQpJbnRlcm5hbCBH
bG9iYWwgRGlhbDogMiA3MDEgNjc3Mw0KRGlyZWN0IExpbmU6ICs2MCA0IDYzNiA2NzczDQoNCg0K
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGluaCBOZ3V5ZW4gPGRpbmd1eWVu
QGtlcm5lbC5vcmc+DQo+U2VudDogTW9uZGF5LCBKdWx5IDEsIDIwMTkgMTE6NTUgUE0NCj5Ubzog
T25nLCBIZWFuIExvb25nIDxoZWFuLmxvb25nLm9uZ0BpbnRlbC5jb20+OyBUaGF5ZXIsIFRob3IN
Cj48dGhvci50aGF5ZXJAaW50ZWwuY29tPg0KPkNjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNlZSwNCj5DaGluIExp
YW5nIDxjaGluLmxpYW5nLnNlZUBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSHYxXSBB
Uk02NDogZGVmY29uZmlnOiBBZGQgTEVEU19UUklHR0VSU19USU1FUiBmb3INCj5ibGlua2luZyBs
ZWRzDQo+DQo+DQo+DQo+T24gNi8yNy8xOSA5OjA3IEFNLCBPbmcsIEhlYW4gTG9vbmcgd3JvdGU6
DQo+PiBBZGRpbmcgTEVEIFRyaWdnZXJzIFRpbWVycyBmb3IgTEVEIGJsaW5raW5nIHN1cHBvcnQg
b24gQVJNIGRldmljZXMNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBPbmcsIEhlYW4gTG9vbmcgPGhl
YW4ubG9vbmcub25nQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gvYXJtNjQvY29uZmlncy9k
ZWZjb25maWcgfCAgICAxICsNCj4+ICAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdzL2Rl
ZmNvbmZpZw0KPj4gYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIGluZGV4IDRkNTgzNTEu
LjZmYmQ2NTEgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+
PiArKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+PiBAQCAtNTk1LDYgKzU5NSw3
IEBAIENPTkZJR19MRURTX1RSSUdHRVJfSEVBUlRCRUFUPXkNCj4+IENPTkZJR19MRURTX1RSSUdH
RVJfQ1BVPXkgIENPTkZJR19MRURTX1RSSUdHRVJfREVGQVVMVF9PTj15DQo+PiBDT05GSUdfTEVE
U19UUklHR0VSX1BBTklDPXkNCj4+ICtDT05GSUdfTEVEU19UUklHR0VSX1RJTUVSPXkNCj4+ICBD
T05GSUdfRURBQz15DQo+PiAgQ09ORklHX0VEQUNfR0hFUz15DQo+PiAgQ09ORklHX1JUQ19DTEFT
Uz15DQo+Pg0KPg0KPkkndmUgYXBwbGllZCB0aGlzIHBhdGNoIHdpdGggdGhpcyBjaGFuZ2U6DQo+
DQo+LS0tIGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPisrKyBiL2FyY2gvYXJtNjQv
Y29uZmlncy9kZWZjb25maWcNCj5AQCAtNTkwLDYgKzU5MCw3IEBAIENPTkZJR19MRURTX0NMQVNT
PXkNCj4gQ09ORklHX0xFRFNfR1BJTz15DQo+IENPTkZJR19MRURTX1BXTT15DQo+IENPTkZJR19M
RURTX1NZU0NPTj15DQo+K0NPTkZJR19MRURTX1RSSUdHRVJfVElNRVI9eQ0KPiBDT05GSUdfTEVE
U19UUklHR0VSX0RJU0s9eSBkZWZjb25maWcNCj4gQ09ORklHX0xFRFNfVFJJR0dFUl9IRUFSVEJF
QVQ9eQ0KPiBDT05GSUdfTEVEU19UUklHR0VSX0NQVT15DQo+DQo+QWxzbywgdGhlIGNvbW1pdCBo
ZWFkZXIgc2hvdWxkIGJlICJhcm02NDogZGVmY29uZmlnIi4NCj4NCj5EaW5oDQo=
