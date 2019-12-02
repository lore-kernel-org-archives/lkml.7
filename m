Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F47C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1697920848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLBW3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:29:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:41070 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLBW3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:29:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 14:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="218464248"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2019 14:29:21 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.121]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.246]) with mapi id 14.03.0439.000;
 Mon, 2 Dec 2019 14:29:20 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH] ia64: remove stale paravirt leftovers
Thread-Topic: [PATCH] ia64: remove stale paravirt leftovers
Thread-Index: AQHVh/bwVpusAEgcQUWj23hoyWR/g6ea4/AAgAzLYiA=
Date:   Mon, 2 Dec 2019 22:29:20 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4E7C10@ORSMSX115.amr.corp.intel.com>
References: <20191021100415.7642-1-jgross@suse.com>
 <5724dc57-2e1c-7ff4-c8df-758840aeae81@suse.com>
In-Reply-To: <5724dc57-2e1c-7ff4-c8df-758840aeae81@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGM5YmJiZTctNjZiOC00OWIxLTkwYzEtYjAyM2U1YTMyMjM3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ1o5RnlzVmtnbVBuU20zblhjUkFhdnNsSVRFeGZDQUFsZzB4M1dIdlNjeUxNWGROOFFPQ1h1MlFSODA1ODI5eiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBQaW5nPw0KDQo+IE9uIDIxLjEwLjE5IDEyOjA0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiA+
IFJlbW92ZSB0aGUgbGFzdCBsZWZ0b3ZlcnMgZnJvbSBJQTY0IFhlbiBwdi1ndWVzdCBzdXBwb3J0
Lg0KPiA+IA0KPiA+IFBBUkFWSVJUIGlzIGxvbmcgZ29uZSBmcm9tIElBNjQgS2NvbmZpZyBhbmQg
WGVuIElBNjQgc3VwcG9ydCwgdG9vLg0KPiA+IA0KPiA+IER1ZSB0byBsYWNrIG9mIGluZnJhc3Ry
dWN0dXJlIG5vIHRlc3RpbmcgZG9uZS4NCg0KU29ycnkuIEZvciB0aGUgZGVsYXkuICBJIHBpY2tl
ZCB0aGlzIHVwIGFuZCBpdCBidWlsZHMgb24gYWxsIG15DQp0ZXN0IGNvbmZpZ3VyYXRpb25zLiAg
Qm9vdHMgb24gbXkgdGVzdCBtYWNoaW5lIHRvby4NCg0KV2lsbCBwdXNoIHRvIExpbnVzIHNvb24u
DQoNCi1Ub255DQo=
