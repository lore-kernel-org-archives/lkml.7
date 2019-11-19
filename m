Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FABDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85AF2231E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKSSxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:53:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:38884 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfKSSxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:53:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 10:53:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,219,1571727600"; 
   d="scan'208";a="200452249"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2019 10:53:12 -0800
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 10:53:12 -0800
Received: from fmsmsx117.amr.corp.intel.com ([169.254.3.27]) by
 fmsmsx120.amr.corp.intel.com ([169.254.15.106]) with mapi id 14.03.0439.000;
 Tue, 19 Nov 2019 10:53:12 -0800
From:   "Souza, Jose" <jose.souza@intel.com>
To:     "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/crtc-helper: drm_connector_get_single_encoder
 prototype is missing
Thread-Topic: [PATCH] drm/crtc-helper: drm_connector_get_single_encoder
 prototype is missing
Thread-Index: AQHVntkEouhMu4wV4EmGG0RqgiHpJqeTXZiA
Date:   Tue, 19 Nov 2019 18:53:11 +0000
Message-ID: <f6f32b4d8d8e271953f887c50793f9d64d48e7b3.camel@intel.com>
References: <20191119125805.4266-1-benjamin.gaignard@st.com>
In-Reply-To: <20191119125805.4266-1-benjamin.gaignard@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.135]
Content-Type: text/plain; charset="utf-8"
Content-ID: <02A80DBA1E3FBC4DA3F514E8370B1733@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTE5IGF0IDEzOjU4ICswMTAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90
ZToNCj4gSW5jbHVkZSBkcm1fY3J0Y19oZWxwZXJfaW50ZXJuYWwuaCB0byBwcm92aWRlDQo+IGRy
bV9jb25uZWN0b3JfZ2V0X3NpbmdsZV9lbmNvZGVyDQo+IHByb3RvdHlwZS4NCj4gDQo+IEZpeGVz
OiBhOTI0NjJkNmJmNDkzICgiZHJtL2Nvbm5lY3RvcjogU2hhcmUgd2l0aCBub24tYXRvbWljIGRy
aXZlcnMNCj4gdGhlIGZ1bmN0aW9uIHRvIGdldCB0aGUgc2luZ2xlIGVuY29kZXIiKQ0KDQpkcm1f
Y29ubmVjdG9yX2dldF9zaW5nbGVfZW5jb2RlcigpIGlzIGltcGxlbWVudGVkIGJlZm9yZSB0aGUg
dXNlIGluDQp0aGlzIGZpbGUgc28gaXQgaXMgbm90IGJyb2tlbiwgbm8gbmVlZCBvZiBhIGZpeGVz
IHRhZy4NCg0KUmV2aWV3ZWQtYnk6IEpvc8OpIFJvYmVydG8gZGUgU291emEgPGpvc2Uuc291emFA
aW50ZWwuY29tPg0KDQo+IA0KPiBDYzogSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSA8am9zZS5zb3V6
YUBpbnRlbC5jb20+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVu
amFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9kcm1fY3J0
Y19oZWxwZXIuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2NydGNfaGVscGVyLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vZHJtX2NydGNfaGVscGVyLmMNCj4gaW5kZXggNDk5YjA1YWFjY2ZjLi45
M2E0ZWVjNDI5ZTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fY3J0Y19oZWxw
ZXIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2NydGNfaGVscGVyLmMNCj4gQEAgLTQ4
LDYgKzQ4LDggQEANCj4gICNpbmNsdWRlIDxkcm0vZHJtX3ByaW50Lmg+DQo+ICAjaW5jbHVkZSA8
ZHJtL2RybV92YmxhbmsuaD4NCj4gIA0KPiArI2luY2x1ZGUgImRybV9jcnRjX2hlbHBlcl9pbnRl
cm5hbC5oIg0KPiArDQo+ICAvKioNCj4gICAqIERPQzogb3ZlcnZpZXcNCj4gICAqDQo=
