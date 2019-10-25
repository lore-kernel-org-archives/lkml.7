Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB786CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894142053B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505233AbfJYQPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:15:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:2545 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390348AbfJYQPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:15:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 09:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="197465732"
Received: from kmsmsx151.gar.corp.intel.com ([172.21.73.86])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2019 09:14:47 -0700
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.51]) by
 KMSMSX151.gar.corp.intel.com ([169.254.10.97]) with mapi id 14.03.0439.000;
 Sat, 26 Oct 2019 00:14:46 +0800
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "M, Naveen" <naveen.m@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [alsa-devel] [PATCH] ASoC: eve: implement set_bias_level
 function for rt5514
Thread-Topic: [alsa-devel] [PATCH] ASoC: eve: implement set_bias_level
 function for rt5514
Thread-Index: AQHVixSpuo5KyaaW0kmhCX7+/fo7hqdq3ikAgACJfMD//4KWAIAAhrNg
Date:   Fri, 25 Oct 2019 16:14:46 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C74032096B@PGSMSX108.gar.corp.intel.com>
References: <1571994691-20199-1-git-send-email-brent.lu@intel.com>
 <3ce80285-ddb5-653d-cf60-febc9fd0bdee@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C740320822@PGSMSX108.gar.corp.intel.com>
 <219281e5-d685-d584-0d22-5dcf3ca2bec2@linux.intel.com>
In-Reply-To: <219281e5-d685-d584-0d22-5dcf3ca2bec2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmY3MWIyOGYtZTdiNi00YmU4LTlhMDQtMDZmNmU3MzFkMWNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU1NaSnFzZmJBRHhoMFlwdG5UaGZFSXNtNXBzYkU4VU5WbXJIMERIXC80d09yMmYrN0tMSWdkXC9LV0psKzNxb3RRIn0=
x-ctpclassification: CTP_NT
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

PiANCj4gQ2FuIHlvdSBjbGFyaWZ5IGlmIHRoZSBydDU1MTQgbmVlZHMgdGhlIE1DTEsgd2hpbGUg
aXQncyBkb2luZyB0aGUgaG90d29yZA0KPiBkZXRlY3Rpb24/DQoNCk5vLCBydW5uaW5nIHRoZSBk
ZXRlY3Rpb24gZG9lcyBub3QgcmFpc2UgdGhlIGJpYXMgbGV2ZWwgc28gdGhlIHNldF9iaWFzX2xl
dmVsIA0Kd2lsbCBub3QgYmUgY2FsbGVkLiBUaGUgbWNsayBpcyBvbmx5IHR1cm5lZCBvbiB0aGVu
IG9mZiBpbiBtaXhlciBjb250cm9sJ3MgaGFuZGxlciANCihydDU1MTRfZHNwX3ZvaWNlX3dha2Vf
dXBfcHV0KSB3aGVuIGVuYWJsaW5nIHRoZSBob3R3b3JkIGRldGVjdGlvbi4NCg0KPiANCj4gTXkg
cG9pbnQgaXMgcmVhbGx5IHRoYXQgdGhpcyBwYXRjaCB1c2VzIGEgY2FyZC1sZXZlbCBCSUFTIGlu
ZGljYXRpb24sIGFuZCBJJ2QgbGlrZQ0KPiB0byBtYWtlIHN1cmUgdGhpcyBkb2VzIG5vdCBpbnRl
cmZlcmUgd2l0aCB0aGUgYXVkaW8gRFNQIGJlaW5nIGluIEQzIHN0YXRlLg0KDQpUaGUgZnVuY3Rp
b24gY2hlY2tzIHRoZSBuYW1lIG9mIGRhcG0gc28gaXQgd291bGQgb25seSByZWFjdCB3aGVuIHJ0
NTUxNCdzIA0KYmlhcyBsZXZlbCBpcyBjaGFuZ2luZy4gQW5kIGFsc28gdGhlIGlkbGVfYmlhc19v
ZmYgb2YgdGhlIGNvZGVjIGRyaXZlciBpcyB0cnVlIHNvIA0KaXQncyB0YXJnZXRfYmlhc19sZXZl
bCBzaG91bGQgbm90IGJlIG92ZXJ3cml0dGVuIGluIHRoZSBkYXBtX3Bvd2VyX3dpZGdldHMoKSAN
CmZ1bmN0aW9uLiBUaGUgYmVoYXZpb3Igc2hvdWxkIGJlIHNpbWlsYXIgdG8gdGhlIHByZXZpb3Vz
IHBhdGNoIHdoaWNoIGlzIHVzaW5nIA0Kc3VwcGx5IHdpZGdldC4NCg0KDQpSZWdhcmRzLA0KQnJl
bnQNCg==
