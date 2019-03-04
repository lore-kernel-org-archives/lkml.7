Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC08C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29CF20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCDSzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:55:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:36809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfCDSzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:55:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 10:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="122562213"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga008.jf.intel.com with ESMTP; 04 Mar 2019 10:55:51 -0800
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 4 Mar 2019 10:55:51 -0800
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.35]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.201]) with mapi id 14.03.0415.000;
 Mon, 4 Mar 2019 10:55:51 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH v4 05/17] x86/cpufeatures: Enumerate
 IA32_CORE_CAPABILITIES MSR
Thread-Topic: [PATCH v4 05/17] x86/cpufeatures: Enumerate
 IA32_CORE_CAPABILITIES MSR
Thread-Index: AQHU0KMIwCuCsBsk402eG6ax0c24q6X8W/yA//96NSA=
Date:   Mon, 4 Mar 2019 18:55:50 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712209D87A319@ORSMSX106.amr.corp.intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-6-git-send-email-fenghua.yu@intel.com>
 <f7ccbe2f-2b7d-e79e-991d-965ac48da081@intel.com>
In-Reply-To: <f7ccbe2f-2b7d-e79e-991d-965ac48da081@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBIYW5zZW4sIERhdmUNCj4gT24gMy8xLzE5IDY6NDQgUE0sIEZlbmdodWEgWXUgd3Jv
dGU6DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgN
Cj4gYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlcy5oDQo+ID4gaW5kZXggNmQ2MTIy
NTI0NzExLi4zNTBlZWNjZDBjZTkgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vY3B1ZmVhdHVyZXMuaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1
cmVzLmgNCj4gPiBAQCAtMzQ5LDYgKzM0OSw3IEBADQo+ID4gICNkZWZpbmUgWDg2X0ZFQVRVUkVf
SU5URUxfU1RJQlAJCSgxOCozMisyNykgLyogIiIgU2luZ2xlDQo+IFRocmVhZCBJbmRpcmVjdCBC
cmFuY2ggUHJlZGljdG9ycyAqLw0KPiA+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0ZMVVNIX0wxRAkJ
KDE4KjMyKzI4KSAvKiBGbHVzaCBMMUQNCj4gY2FjaGUgKi8NCj4gPiAgI2RlZmluZSBYODZfRkVB
VFVSRV9BUkNIX0NBUEFCSUxJVElFUwkoMTgqMzIrMjkpIC8qDQo+IElBMzJfQVJDSF9DQVBBQklM
SVRJRVMgTVNSIChJbnRlbCkgKi8NCj4gPiArI2RlZmluZSBYODZfRkVBVFVSRV9DT1JFX0NBUEFC
SUxJVFkJKDE4KjMyKzMwKSAvKg0KPiBJQTMyX0NPUkVfQ0FQQUJJTElUWSBNU1IgKi8NCj4gPiAg
I2RlZmluZSBYODZfRkVBVFVSRV9TUEVDX0NUUkxfU1NCRAkoMTgqMzIrMzEpIC8qICIiIFNwZWN1
bGF0aXZlDQo+IFN0b3JlIEJ5cGFzcyBEaXNhYmxlICovDQo+IA0KPiBXaGF0IGRvZXMgdGhpcyBm
ZWF0dXJlIGVuZCB1cCBsb29raW5nIGxpa2UgaW4gL3Byb2MvY3B1aW5mbz8NCg0KVGhlIGZsYWcg
c3RyaW5nIGlzICJjb3JlX2NhcGFiaWxpdHkiIGluIC9wcm9jL2NwdWluZm8uDQoNClRoYW5rcy4N
Cg0KLUZlbmdodWENCg==
