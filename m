Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846F9C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CBC207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfFFIoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:44:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:59677 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFFIoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:44:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 01:44:38 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 06 Jun 2019 01:44:37 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 6 Jun 2019 01:44:37 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 6 Jun 2019 01:44:37 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.10]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.137]) with mapi id 14.03.0415.000;
 Thu, 6 Jun 2019 16:44:35 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 1/3] x86/CPU: Add more Icelake model number
Thread-Topic: [PATCH 1/3] x86/CPU: Add more Icelake model number
Thread-Index: AQHVGhI6CBhJKpTmwUOFAEOJmoUocKaNqcuAgACJ/8D//4ZDgIAAl0QA
Date:   Thu, 6 Jun 2019 08:44:34 +0000
Message-ID: <E6AF1AFDEA62A94A97508F458CBDD47F7A22F2E7@SHSMSX101.ccr.corp.intel.com>
References: <20190603134122.13853-1-kan.liang@linux.intel.com>
 <20190606063525.GA26146@zn.tnic>
 <E6AF1AFDEA62A94A97508F458CBDD47F7A22F284@SHSMSX101.ccr.corp.intel.com>
 <20190606073336.GB26146@zn.tnic>
In-Reply-To: <20190606073336.GB26146@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDAzMDRhNjktMmQ1MS00M2YwLWEwZDUtOTk2ZWZiMmZlZjBjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZlEweFhoT0FNNldBdWRYSWZRblM5WDFQb3BHUHpOVFo3eUNzcktzNFVJSXhJRG9jdjNQZTlnczlkaTN5cmk2SSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+PiAuLi4NCj4+
IERyb3BwaW5nIG15IFNPQiBvciBhZGRpbmcgYSB0ZXh0ICJbUWl1eHU6IEdldCB0aGUgbWFjcm9z
IGluIHRoZSBJY2UgTGFrZSBncm91cCBzb3J0ZWQgYnkNCj4gPiBtb2RlbCBudW1iZXIuXSIgYXQg
dGhlIGVuZCBvZiB0aGUgY29tbWl0IG1lc3NhZ2UgLSB3aGljaCBvbmUgaXMgYmV0dGVyL2NsZWFy
IGZvciB5b3U/DQo+IA0KPiBJJ2xsIGFkZCB0aGF0IG5vdGUgd2hlbiBhcHBseWluZy4NCj4gDQo+
IFRoeC4NCg0KVGhhbmtzIEJvcmlzIQ0KLVFpdXh1DQo=
