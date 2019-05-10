Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4091FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A82217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfEJTBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:01:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:1614 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbfEJTBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:01:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 12:01:31 -0700
X-ExtLoop1: 1
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2019 12:01:31 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 10 May 2019 12:01:31 -0700
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.121]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.120]) with mapi id 14.03.0415.000;
 Fri, 10 May 2019 12:01:31 -0700
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 02/13] selftests/resctrl: Add basic resctrl file
 system operations and data
Thread-Topic: [PATCH v7 02/13] selftests/resctrl: Add basic resctrl file
 system operations and data
Thread-Index: AQHVB1ej+BTg+H4QbEWo5NXCJsuddqZktrYg
Date:   Fri, 10 May 2019 19:01:30 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712209D8A3BE5@ORSMSX106.amr.corp.intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
 <1549767042-95827-3-git-send-email-fenghua.yu@intel.com>
 <20190510174146.GD29927@zn.tnic>
In-Reply-To: <20190510174146.GD29927@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+IE9uIFNhdCwg
RmViIDA5LCAyMDE5IGF0IDA2OjUwOjMxUE0gLTA4MDAsIEZlbmdodWEgWXUgd3JvdGU6DQo+ID4g
RnJvbTogU2FpIFByYW5lZXRoIFByYWtoeWEgPHNhaS5wcmFuZWV0aC5wcmFraHlhQGludGVsLmNv
bT4NCj4gPg0KPiA+IFRoZSBiYXNpYyByZXNjdHJsIGZpbGUgc3lzdGVtIG9wZXJhdGlvbnMgYW5k
IGRhdGEgYXJlIGFkZGVkIGZvciBmdXR1cmUNCj4gPiB1c2FnZSBieSByZXNjdHJsIHNlbGZ0ZXN0
IHRvb2wuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWkgUHJhbmVldGggUHJha2h5YSA8c2Fp
LnByYW5lZXRoLnByYWtoeWFAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFyc2hpeWEg
SGF5YXRraGFuIFBhdGhhbg0KPiA+IDxhcnNoaXlhLmhheWF0a2hhbi5wYXRoYW5AaW50ZWwuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZlbmdodWEgWXUgPGZlbmdodWEueXVAaW50ZWwuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4gDQo+
IEFuZCB3aGlsZSBmZWVkYmFjayBmcm9tIEFuZHJlIGlzIGJlaW5nIGFkZHJlc3NlZCwgeW91IHRo
b3NlIFNPQiBjaGFpbnMNCj4gbmVlZCB0byBiZSBmaXhlZC4NCg0KV2lsbCBmaXggdGhlIFNPQiBj
aGFpbnMuDQoNClRoYW5rcy4NCg0KLUZlbmdodWENCg==
